# Get data by station

### NOTE 

* ***See this resource*** https://www.juntadeandalucia.es/agriculturaypesca/ifapa/ria/servlet/FrontController?action=Static&url=listadoEstaciones.jsp&c_provincia=18 

## What variables have been recorded in each station? 
* First we check the variables available for each station 

```sql 
SELECT 
  cli_estaciones.nombre, 
  cli_estaciones.codigo, 
  cli_variables.codigo, 
  cli_variables.descripcion, 
  cli_estaciones.fecha_inicio,
  cli_estaciones.fecha_fin
FROM 
  public.cli_datos_estaciones, 
  public.cli_variables, 
  public.cli_estaciones
WHERE 
  cli_variables.id = cli_datos_estaciones.cli_variable_id AND
  cli_estaciones.id = cli_datos_estaciones.cli_estacion_id AND
  cli_estaciones.codigo IN ('RIA1806', 'EARM10', 'CETURSA1','EARM27','RIA1807') 
GROUP BY cli_variables.codigo, cli_estaciones.codigo, cli_estaciones.nombre, cli_variables.descripcion, cli_estaciones.fecha_inicio,
  cli_estaciones.fecha_fin
ORDER BY cli_estaciones.nombre, cli_variables.codigo; 
```

and store the output as: '/data_raw/meteo/variables_by_station.csv' 

## Temperature and Precipitation data for each station 

This sql statement was used to get raw data (10-min interval): 

```sql
SELECT 
  cli_estaciones.nombre, 
  cli_estaciones.codigo, 
  cli_estaciones.punto_x, 
  cli_estaciones.punto_y, 
  cli_variables.codigo, 
  cli_variables.descripcion, 
  cli_datos_estaciones.valor, 
  cli_datos_estaciones.fecha
FROM 
  public.cli_datos_estaciones, 
  public.cli_variables, 
  public.cli_estaciones
WHERE 
  cli_variables.id = cli_datos_estaciones.cli_variable_id AND
  cli_estaciones.id = cli_datos_estaciones.cli_estacion_id AND 
  cli_variables.codigo IN ('PI1', 'TI1') AND 
  cli_estaciones.codigo IN ('RIA1806', 'EARM10', 'CETURSA1','EARM27','RIA1807');
```

and the output was stored as: '/data_raw/meteo/meteo_data.csv'


## Long term series 

* Series from 1950 to 2009: 
 * `cli_estaciones.id` = c(195, 386, 368)
 * `cli_estaciones.nombre` = Granada Base Aérea, Soportujar, Quentar
 
### Granada Base Aérea 
```sql
SELECT 
  cli_estaciones.codigo, 
  cli_variables.codigo, 
  cli_datos_estaciones.valor, 
  cli_datos_estaciones.fecha
FROM 
  public.cli_datos_estaciones, 
  public.cli_variables, 
  public.cli_estaciones
WHERE 
  cli_variables.id = cli_datos_estaciones.cli_variable_id AND
  cli_estaciones.id = cli_datos_estaciones.cli_estacion_id AND 
  cli_variables.codigo IN ('PI1', 'TI1') AND 
  cli_estaciones.id =  195;
```

and the output was stored as: '/data_raw/meteo/meteo_data_base_aerea.csv'
