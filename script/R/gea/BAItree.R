####Ejemplo calculo BAI por arbol
###17042017


####### BAI  #####
###MACRO PARA CALCULARSE BAI POR PARCELA
### CUIDADO CON SERIES QUE NO EMPIEZAN EN LA MISMA FECHA QUE EL FINAL (PUEDEN METER SESGO): por eso uso BAItree
### BAI calculado por árbol para evitar sesgo de series que no lleguen hasta el final ("flotantes")
##

###daps = archivo donde est´án los diametros que se han metido en campo
### rwls = archivo .rwl que me importo con library(dplR) funci´ón read.rwl

BAItree=function(daps, rwls)
{
  BAIdata=NULL
  #
  for (i in 1:(ncol(rwls)-1))
  {
    Var=as.data.frame(cbind(as.numeric((rwls[,i])), as.numeric(rwls$year)))
    Var=subset(Var, !is.na(Var[,1]))
    colnames(Var)=c("Growth", "year")
    Var$age1=seq(1, nrow(Var), 1)
    parcela2=as.numeric(substr(colnames(rwls[i]), 3,4))
    arbol=as.numeric(substr(colnames(rwls[i]),5,7))
    checkage=subset(daps, Parcela==parcela2 & Identidad..==arbol)
    Var$dapcc=as.numeric(c(checkage[13]))
    Var$dapsc=(Var$dapcc-(2*(0.02*Var$dapcc+0.39)))*10   ###pongo la de la encina de siempre, lo paso todo a mm
    Var$tree=arbol
    #
    BAIdata=rbind(BAIdata, Var)
  }
  
  BAIdatatree=aggregate(BAIdata, by=list(BAIdata$year, BAIdata$tree), mean)
  #
  BAIdatatree=BAIdatatree[order(BAIdatatree$tree, BAIdatatree$year),-c(4, 8)]
  colnames(BAIdatatree)=c("year", "tree", "Growth", "age1", "dapcc", "dapsc")
  #  
  arboles=aggregate(BAIdatatree[,2], by=list(arbol=BAIdatatree$tree), mean)  
  arboles=arboles[,1]
  ###ahora me calculo el BAI por pie
  BAIdata2=NULL
  #
  for (i in arboles)
  {
    ##Me calculo el BAI ahora
    Var=subset(BAIdatatree, tree==i)
    Var=Var[rev(order(Var$year)),]
    Var$RWcorr=Var[,3]*Var$dapsc/(2*sum(Var[,3]))
    Var$BAI=ifelse(2*sum(Var[,3])<max(Var$dapsc),(pi/4)*(Var$dapsc**2-(Var$dapsc-2*Var[,3])**2)/100,(pi/4)*(Var$dapsc**2-(Var$dapsc-2*Var[,7])**2)/100)   ##en cm2, podrÌa hacerse con pi r cuadrado, pero lo pongo como Piovesan et al 2008
    #lo paso todo a cm ahora
    for (vv in 2:nrow(Var))
    {
      Var$dapsc[vv]=ifelse(2*sum(Var[,3])<max(Var$dapsc),Var$dapsc[vv-1]-2*Var[vv-1,3], Var$dapsc[vv-1]-2*Var[vv-1,7]) #en mm
      Var$BAI[vv]=ifelse(2*sum(Var[,3])<max(Var$dapsc),(pi/4)*(Var$dapsc[vv]**2-(Var$dapsc[vv]-2*Var[vv,3])**2)/100,(pi/4)*(Var$dapsc[vv]**2-(Var$dapsc[vv]-2*Var[vv,7])**2)/100)   ##en cm2, podrÌa hacerse con pi r cuadrado, pero lo pongo como Piovesan et al 2008
    }
    #
    BAIdata2=rbind(BAIdata2, Var)
  }
  #
  #BAIdata2$plot=parcela2
  #
  Muestra=NULL
  for (i in min(BAIdata2$year):max(BAIdata2$year))
  {
    numer=c(i, nrow(BAIdata2[BAIdata2$year==i,]))
    Muestra=rbind(Muestra,numer)
  }
  Muestra<-Muestra
  Muestra2<-Muestra[Muestra[,2]>=3,]  ###3 pies son como mínimo 6 radios
  #
  BAIdata2<-BAIdata2[BAIdata2$year>=min(Muestra2[,1]),]
  #
  BAIdata_sd=aggregate(BAIdata2[,8], by=list(year1=BAIdata2$year), sd)
  #BAIdata_sd$year=BAIdata_sd$Group.1
  BAIdata3=aggregate(BAIdata2, by=list(BAIdata2$year), mean)   ###los NA son omitidos (na.action) y cuando hay sólo un radio coge el que hay como la media
  #
  BAIdata_sd[,2]=BAIdata_sd[,2]/sqrt(Muestra2[,2])
  colnames(BAIdata_sd)=c("year", "BAIsd")
  #
  BAIdata<<-as.data.frame(merge(BAIdata3, BAIdata_sd, by.x="year", by.y="year"))
}

