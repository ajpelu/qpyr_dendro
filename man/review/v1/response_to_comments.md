# Response to comments

# 5 GGI: Mucho me parece pero si lo dicen las citas... 
# 6 GGI: ¿No está más al sur el rodalito (minúsculo) del Parque de Alcornocales o alguno de la Provincia de Málaga (leo que en Tejeda, Almijara hay, posiblemente en Serranía Ronda también)?
--- 


# 7 FJB: Creo que esta sección solapa un poco con la parte de "climate" de la sección "climate and growth" que hay más abajo. Sugiero fusionarlas.

No estoy de acuerdo, son dos cosas diferentes y complementarias. Por un lado se caracteriza las sequías (esta sección) y en la otra se ve las posibles relaciones entre datos climáticos y tree-ring. 

# 8 GGI: Comentamos cuando estabas construyendo tus cronos cómo 1995 parecía el peor “pointer year”… lo cual pone en situación las sequías que podéis analizar con las imagines de satellite. Creo que es bueno hablar de esto, pues con los datos dendro te pone en major situación histórica las sequías que tanto preocupan en los últimos 15 años (relativizándolas en cierto modo).

Ok, se ha incluido información de otras sequías, y se analizarán las resilience metrics de BAI frente a esas sequías. 

# 9 GGI: No te pueden preguntar los revisores: 1) por qué no mostrar también NDVI? 2) por qué no usar mejor el period fenológico mayo-octubre (aprox) que es cuando los robles tienen hojas? En el annual tienes más influencia de especies perennes y herbáceas, no?

1) Mas arriba hemos escrito las diferencias entre NDVI y EVI, y por que es mejor coger EVI. 
2) He quitado el annual profile. No obstante, usar el EVI medio anual corrige el efecto de los datos aberrantes de EVI/NDVI etc derivados de la presencia de nubes, datos de mala calidad, etc. Existen varias referencias que hablan de eso. Por otro lado se ha llevao a cabo un filtrado de los datos quitando datos ... $COMPLETAR$  
---

# 10 FJB: Creo que no queda clara la diferencia entre annual EVI profile y EVI's annual mean. 

Cierto, he eliminado lo del EVI profile confunde mas de lo que aporta. 

# 11 FJB: Si calculamos el period de referencia quitando el año i, entonces no es  referencia porque cambia cada año, ¿no?

No, si ves los trabajos donde se definen las anomalías estandarizadas esto es así. A mi me surgió la duda en su momento y le pregunté a D. Alcaraz y me comentó que las anomalias se calculaban así. No obstante, échale un vistazo a los papers de Samanta et al. 2010, 2012 y algunos de los que los citan. 

# 12 GGI: Of all pixels???

No, se calcula para cada pixel. 

# 13 FJB: No, para cada pixel. 

Pues eso. 

# 14 FJB: Entonces ¿hay un valor de GC por año y por árbol?, ¿no?. No queda claro aquí. Se deduce de la siguiente frase, en la que se habla de cómo se genera esta variable a escala de sitio. 

Si te fijas escribimos: "GC were calculated for the individual tree-ring series", es decir, estamos calculando GC para cada árbol. Luego se construyen series a nivel de sitio haciendo la media para todos los árboles de cada sitio de forma anual (creo que también está escrito). Es una metodología típica de dendro.  


# 15 GGI: 50% está mejor que 25%, creo que lo comentamos la otra vez.

Ok, done. 

# 16 FJB: ¿podemos decir pues que resilience = recovery * resistance?

Si, así es. De hecho creo que para la discussión nos puede venir bien centrarnos solo en dos de ellos, para evitar redundancia. 

# 17 FJB: Tengo entendido que los valores de resistence, recovery y resilience se calculan para todos los pixels de cada zona. ¿sería factible calcularlos para el pixel o los pixels en los que se encuentran los árboles muestreados con dendro?. Eso nos permitiría hacer una comparación más fina, creo. Al menos habría un solape entre ambas series en los últimos 16 años

Sí, sería factible, aunque veo algunas limitaciones a lo que propones:
(i) en un pixel entran mas de un árbol, y tenemos pixeles con algunos árboles y otros con un solo árbol. Al final no tenemos pixel-arbol, y tendríamos que hacer averages de crecimiento para aquellos árboles que caen en un mismo pixel. Creo que perderíamos información
(ii) algunos árboles caen entre dos pixeles, por tanto el valor de EVI para ese pixel no podríamos asociarlo a dicho árbol (estaría sesgado)

Total, que creo que la aproximación de analizar a nivel de población el EVI y compararla (sin pretender ser correlacional) con la respuesta a nivel de stand tiene menos sesgo que si intentamos afinar en la escala. 

# 18 GGI: ¿por qué no calculas los indices para crecimiento también para unas cuantas sequías desde 1940 (que parece la fecha en que está bien replicado SJ)? De este modo puedes comparer si es mayor o menor que en 2005 y 2012 y a lo mejor hasta te puedes construer una pequeña serie de 5-10 años y ver si hay tendencia o similar. Desde luego el 1995, puedes usar más-menos 2 SD de precipitación annual o de año hidrológico (posiblemente mejor).

Done. He utilizado los años de sequía mas severa desde 1900 (ver apendice S4) y he computado los índices de Resiliencia con una ventana temporal de 3 years (todo igual) para los 12 eventos de sequía mas severos del siglo. 

# 19 GGI: Hay que resumir un poco, hay ideas repetidas que se deben condenser en menos palabras.

----------

# 20 FJB: Strong es un adjetivo equívoco. ¿Quiere decir que la magnitud de la tendencia es más alta o que la tendencia es más acusada o que hay más pixels con tendencia significativa allí?

Ok. No obstante he quitado esta parte para enfocar el trabajo, creo que la parte espacial aquí mete mas ruido. No hemos hablado de ella en MM y creo que despista mas que otra cosa. 

# 19 GGI: Los negativos están en el norte?

He quitado la parte espacial de resultados, lo dejamos para otro trabajo. 

# 22 FJB: No me atrevería yo a decir que en este año el perfil de EVI fuera significativamente más bajo que el del period de referencia. De hecho ambos son casi iguales en los meses de verano y el de 2012 es mayor en otoño-invierno.

Bueno, viendo la gráfica puede ser que no, aunque cuando realizas la comparación estadistica si sale (no incluida aquí, es lo que hicimos para el poster que presentamos en Sevilla en la AEET). No obstante he dedicido quitar esto porque no aporta gran cosa y hay que resumir. 

# 23 FJB: ¿te refieres aquí a todo el periodo o a dicho period menos 2005 y 2012?

El reference period, según indico en los MM se calcula como promedio de todos los años menos el 2005 y 2012. Aunque este apartado lo he quitado.  


# 24 FJB: Algo parecido a esto ya queda dicho en la sección anterior. Aquí hablas de resiliencia y no de pérdida de verdor por la sequía. Ambos conceptos están relacionados, claramente, pero creo que se mezclan aquí. 

Cierto, llevas razón. He reescrito esta parte para no ser tan redundante. 

#25 GGI ¿Esto es significativo?, ¿se recuperan ma´s en terminus relativos porque vienen desde más abajo en 2005?

Si, se recuperan mas porque vienen de mas abajo. De hecho he creado un gráfico (Appendix S10) donde se puede ver la evolución del EVI, que ayuda a entederlo. Si es significativo (ver Table 3 y Table S1) 

# 26 FJB: Igual no entiendo esto bien. Pero los porcentajes que muestras dan a entender que no solo recuperan el verdor, sino que superan el previo a la sequía pocos años después... ¿es correcta esta afirmación?

No, con el recovery se computa el post / drouht, por lo que sería que recuperan el verdor respecto a los valores que tenían durante la sequía. Lo que tu indicas corresponde con la métrica de Rs. 

# 27 FJB: Esta frase parece contradecir a la primera frase de este párrafo. A no ser que la primera frase se haya obtenido con un análisis aplicado a todos los robledales en su conjunto. En ese caso, creo que debería de indicarse así.

Para todos los índices de Resiliencia, se hace un análisis parecido a una ANOVA, esto es: Rc ~ año_sequia + sitio + año_sequía:sitio. Primero se exploran las diferencias del recovery (o cualquier otra métrica) a nivel de año_sequía (esto sería la primera frase a la que te refieres), luego a nivel de sitio, y luego la interacción. En la frase estamos diciendo, que hay diferencias entre el recovery tras el 2005 y tras el 2012. Y luego decimos las diferencias post hoc en la interacción (fijate en las letras de la figura 3 para la recovery; y también en la table S1). 

# 28 GGI: Separa claramente cuando hablas de Rs (índice) de cuando hablas de “Resilience” en general integrando los 3 índices.

Done. 

# 29 FJB: Yo no veo que la tabla 3 diga esto que dices tú. 

La tabla 3 indica el p-valor de la Robust anova, y nos está diciendo, para la resiliencia (Rs) y el Drought event: F = 207.2 p= 0.001. Es decir, que hay diferencia significativas entre drought events para la resiliencia. 

Si te fijas en la frase decimos: 
"Resilience (Rs) was significantly higher for the 2012 drought event than for 2005 (Tables 3, S1)" 

la palabra signigicantly es lo que está indicado en la tabla 3. Y en la tabla S1 s dan valores de las medias (bueno en realidad no son medias, pero para entendernos)

# 30 GGI: ESto es por correlaciones entre cronos? Da alguna referencia de dónde lo ves y cómo.

He indicado la figura, y he añadido un Suplement 

# 31 GGI: Todo esto es muy interesante. Asegúrate de distribuirlo bien entre Results y Discus. Insisto que sería bueno dar valores de precipitación y ETP los años que consideras sequía. Pareciera que 2005 es más intense que 2012, y 1995 la peor, sí?

----

# 32 GGI: Esto es muy interesante. Por eso sería bueno meter alguna sequía más antes de 1995 también. Por otro lado es parecido a lo que te tendría que salir con los indices de resiliencia. Los árboles se han recuperado bien de lo 1995, se diría.

Done. Ver apartado de resiliencia. 


# 33 GGI: Quizá quitar eso si no lo discutes luego.

Quitado. 

# 34 FJB: Creo que esta sección de bería estar junto a "greenness resilience to drought events". Se habla del mismo proceso ecológico pero usando métodos diferentes. Los resultados deberían de describirse juntos o casi, creo.

No me convence tu propuesta. 

# 35 FJB: Igual no lo he entendido bien, pero creo que lo que medimos con el recovery es el % de verdor que se recupera en el perido post sequía. En ningún momento se evalúa cuándo se recupera tal %. Si tengo razón, creo que no es correcto hablar de rapidly ni de velocidad de recuperación. ¿no?

Con el recovery medimos el ratio entre el valor de la variable X post evento y el valor de la variable X en el evento. Lo de la velocidad es una forma de expresarlo, lo he visto en un artículo (Pretzsch et al 2013. Plant Biology 15:483) y me parecía interesante expresarlo así. Lo he reescrito de nuevo.  

# 36 GGI: Esto va en discussion.

Ok. Movido 

# 37 FJB: Pondría mejor "Disturbances in forest structure" para distinguirlo de las sequías, que también son perturbaciones, ¿no?

Ok. cambiado a Forest disturbances 

# 38 GGI: Sí, esto es discussion.
Ok. movido 

# 39 GGI: Si no hay signos de gestión… tal vez sea que ha habido algo de mortalidad o sencillamente que es una época que han respondido a un period más húmedo. Si lo dejas se comenta en discussion.

Lo he quitado. 
