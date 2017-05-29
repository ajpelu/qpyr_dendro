########Plots growth changes Montejo RW
########
######
### este es un ejemplo que usé para el artículo Dorado-Liñán et al. (2017) Dendrochronlogia
### Hay 3 especies (misma función uso): Q. pyrenaica, Q. petraea, Fagus sylvatica en el norte de Madrid (Montejo)

####A LA VUELTA DE LUGO SEGUIR CALCULANDO EL % DE ÁRBOLES QUE PASAN LOS LÍMITES 25-50%, LUEGO SEGUIR CON BAI
####

library(dplR)
#
##Primero me construyo una matriz con todos los crecimientos por columnas
#
AGC2=function(RWL)
{
GC=as.data.frame(NULL)
#
for (n in 1:ncol(RWL))
{
	series <- as.data.frame(RWL[, n])
	series$year=as.numeric(row.names(RWL))
	series=subset(series, !is.na(series[1]))
	tree=as.numeric(substr(colnames(RWL)[n],3,4))
	tree2=as.numeric(substr(colnames(RWL)[n], 5,5))
	if(!is.na(tree2)){tree3=as.numeric(substr(colnames(RWL[n]),3,5))} else {tree3=tree}
	series$tree=as.numeric(tree3)
	GC=rbind(GC, series)
}
names(GC)[1]="RW"
GC2=aggregate(GC[,1], by=list(year=GC$year,tree=GC$tree), mean)
names(GC2)[3]="RW"
GC2=GC2[order(GC2$tree, GC2$year),]
GC2$tree2=1
for (i in 2:nrow(GC2))
{
if(GC2$year[i]<GC2$year[i-1]) GC2$tree2[i]=1+GC2$tree2[i-1]
else GC2$tree2[i]=GC2$tree2[i-1]
}
GC2<<-GC2
}
#
#
AGC2haya=function(RWL)
{
  GC=as.data.frame(NULL)
  #
  for (n in 1:ncol(RWL))
  {
    series <- as.data.frame(RWL[, n])
    series$year=as.numeric(row.names(RWL))
    series=subset(series, !is.na(series[1]))
    #tree=as.numeric(substr(colnames(RWL)[n],3,4))
    #tree=colnames(series[i])
    #tree2=as.numeric(substr(colnames(RWL)[n], 5,5))
    #if(!is.na(tree2)){tree3=as.numeric(substr(colnames(RWL[n]),3,5))} else {tree3=tree}
    series$tree=n
    GC=rbind(GC, series)
  }
  names(GC)[1]="RW"
  GC2=aggregate(GC[,1], by=list(year=GC$year,tree=GC$tree), mean)
  names(GC2)[3]="RW"
  GC2=GC2[order(GC2$tree, GC2$year),]
  GC2$tree2=1
  for (i in 2:nrow(GC2))
  {
    if(GC2$year[i]<GC2$year[i-1]) GC2$tree2[i]=1+GC2$tree2[i-1]
    else GC2$tree2[i]=GC2$tree2[i-1]
  }
  GC2<<-GC2
}
#
#######FUNCION NUMERO 2 PARA CALCULARSE EL GC
#n es el numero de años que se usa como intervalo de respuesta
#
AGC3=function(RWL, n)
{
GCfin2=data.frame(NULL)
for (i in 1:max(RWL[,4]))
{
series=subset(RWL, tree2==i)
GCfin=data.frame(NULL)
#
for (j in (min(series$year)+n):(max(series$year)-n))
{
	M2=subset(series, series$year>=j & series$year<(j+n-1))
	M1=subset(series, series$year<(j-1) & series$year>=(j-n))
	GCper=100*((mean(M2[,3])-mean(M1[,3]))/mean(M1[,3]))  ##PGC
	GCperneg=100*((mean(M1[,3])-mean(M2[,3]))/mean(M2[,3])) ###NGC
	GCfin=rbind(GCfin, c(i, j, GCper, GCperneg))
	names(GCfin)=c("tree2", "year", "GCper", "GCperneg")
}
GCfin2=rbind(GCfin2, GCfin)
}
GCfin2$GCfinal=ifelse(GCfin2$GCper>0, GCfin2$GCper, -1*GCfin2$GCperneg) ###pongo para los positivos el PGC, para los negativos el NGC
GCfin2<<-GCfin2
}
#

#####para calcularse la crono media de RW con un número de repeticiones mayor que n (n=5, por ejemplo)
###
plotRW=function(RWL, sp)
{
RWL.raw=chron(RWL, biweight=FALSE, prewhiten=FALSE)
RWL.trunc<-subset(RWL.raw, samp.depth>sp)
names(RWL.trunc)=c("RW", "n")
RWL.trunc$year=row.names(RWL.trunc)
RW<<-RWL.trunc
}

###FUNCIóN PARA CALCULAR EL PORCENTAJE DE ÁRBOLES QUE PASAN EL THRESHOLD
##

GCth=function(GCdata, th)
{
  GCdata=GCdata
  GCdata$GC1=ifelse(GCdata[,3]>th, 1, 0)
  GCdata$GC2=ifelse(GCdata[,3]<(-1*th), 1, 0)
  GCt=NULL
  #
  for (i in min(GCdata[,2]):max(GCdata[,2]))
  {
    year=subset(GCdata, GCdata[,2]==i)
    zz=cbind(i, nrow(year), sum(year$GC1), sum(year$GC2))
    GCt=as.data.frame(rbind(GCt, zz))
  }
  names(GCt)=c("year", "size", "GC1", "GC2")
  GCt$GC1t=100*(GCt$GC1/GCt$size)
  GCt$GC2t=-100*(GCt$GC2/GCt$size)
  GCt<<-GCt
}

#########################
####QUPY
qupy=read.rwl("/Users/guigeiz/Documents/Post-doc OT-MED 2013 Aix/Varios/Muestreo Isabel Dorado 2013/Datos/Montejo y Tejera/montejo/QUPY/QUPYmontejo.rwl")
qupy=qupy[, -39]  ##quito el 39 porque no sabía qué pie era (para el dap)
#
Reb=AGC2(qupy)
Reb2=AGC3(Reb, 10)
rb=plotRW(qupy, 4)
#
rb2=aggregate(Reb2[,c(3,4,5)], by=list(year=Reb2$year), mean)
#
rb22=subset(rb2, rb2$year>=min(rb$year))
#write.csv(rb22,"/Users/guigeiz/Documents/Artículos y proyectos míos a partir de agosto 2013/Artículos Isabel Dorado/3-Artículo Montejo/QUPYmgc.csv")
#
RBperc=GCth(Reb2, 50)
#
RBperc2=subset(RBperc, RBperc$year>=min(rb$year))
#write.csv(RBperc2,"/Users/guigeiz/Documents/Artículos y proyectos míos a partir de agosto 2013/Artículos Isabel Dorado/3-Artículo Montejo/QUPYgc.csv")

###QUPE
qupe=read.rwl("/Users/guigeiz/Documents/Post-doc OT-MED 2013 Aix/Varios/Muestreo Isabel Dorado 2013/Datos/Montejo y Tejera/montejo/QUPE/QUPEmontejo.rwl")
qupe=qupe[, -40]  ##quito la flotante para BAI
#
Pet=AGC2(qupe)
#
Pet2=AGC3(Pet, 10)
#
pt=plotRW(qupe, 4)
#
pt2=aggregate(Pet2[,c(3,4,5)], by=list(year=Pet2$year), mean)
#
pt22=subset(pt2, pt2$year>=min(pt$year))
#write.csv(pt22,"/Users/guigeiz/Documents/Artículos y proyectos míos a partir de agosto 2013/Artículos Isabel Dorado/3-Artículo Montejo/QUPEmgc.csv")
#
PTperc=GCth(Pet2, 50)
#
PTperc2=subset(PTperc, PTperc$year>=min(pt$year))
#write.csv(PTperc2,"/Users/guigeiz/Documents/Artículos y proyectos míos a partir de agosto 2013/Artículos Isabel Dorado/3-Artículo Montejo/QUPEgc.csv")

#####FASY
fagu=read.rwl("/Users/guigeiz/Documents/Post-doc OT-MED 2013 Aix/Varios/Muestreo Isabel Dorado 2013/Datos/Montejo y Tejera/mon.rwl")
#
hay=AGC2haya(fagu)
hay2=AGC3(hay, 10)
hy=plotRW(fagu, 4)
#
hy2=aggregate(hay2[, c(3,4,5)], by=list(year=hay2$year), mean)
#
hy22=subset(hy2, hy2$year>=min(hy$year))
#write.csv(hy22,"/Users/guigeiz/Documents/Artículos y proyectos míos a partir de agosto 2013/Artículos Isabel Dorado/3-Artículo Montejo/FAGUmgc.csv")
#
HYperc=GCth(hay2, 50)
#
HYperc2=subset(HYperc, HYperc$year>=min(hy$year))
#
#write.csv(HYperc2,"/Users/guigeiz/Documents/Artículos y proyectos míos a partir de agosto 2013/Artículos Isabel Dorado/3-Artículo Montejo/FAGUgc.csv")









####FIGURE % TREES GC OVER THRESHOLD
###QUPY


plot(RBperc2$year, RBperc2$GC1t, type="h", xlim=c(1700, 2015), ylim=c(-100,100), xlab="", ylab="")
lines(RBperc2$year, RBperc2$GC2t, type="h", col="grey", ylim=c(-100,100), xlab="", ylab="", xlim=c(1700,2015))
abline(h=50, lty=2, col="grey4")
abline(h=-50, lty=2, col="grey4")
par(new=TRUE, yaxt="n", xaxt="n")
plot(RBperc2$year, RBperc2$size, type="l", ylim=c(0,70), lwd=1.5, xlab="", ylab="", xlim=c(1700, 2015))
par(yaxt="s", xaxt="s")
axis(4, at=seq(0,30, 5), labels=c(0,5,10,15,20,25,30))
par(mgp=c(2, 0.2, 0))
axis(3, at=seq(1700, 2000, 25), labels=seq(1700, 2000, 25), cex=0.7)
#
par(xpd=NA)
text(2035, -3.5, "Sample depth (# trees)", srt=90,font=2)
par(xpd=FALSE)



###QUPE

plot(PTperc2$year, PTperc2$GC1t, type="h", xlim=c(1700, 2015), ylim=c(-100,100), xlab="", ylab="")
lines(PTperc2$year, PTperc2$GC2t, type="h", col="grey", ylim=c(-100,100), xlab="", ylab="", xlim=c(1700,2015))
abline(h=50, lty=2, col="grey4")
abline(h=-50, lty=2, col="grey4")
par(new=TRUE, yaxt="n", xaxt="n")
plot(PTperc2$year, PTperc2$size, type="l", ylim=c(0,70), lwd=1.5, xlab="", ylab="", xlim=c(1700, 2015))
par(yaxt="s", xaxt="s")
axis(4, at=seq(0,30, 5), labels=c(0,5,10,15,20,25,30))
par(mgp=c(2, 0.2, 0))
axis(3, at=seq(1700, 2000, 25), labels=seq(1700, 2000, 25), cex=0.7)
#
par(xpd=NA)
text(2035, -3.5, "Sample depth (# trees)", srt=90,font=2)
par(xpd=FALSE)


#FAGU
plot(HYperc2$year, HYperc2$GC1t, type="h", xlim=c(1700, 2015), ylim=c(-100,100), xlab="", ylab="")
lines(HYperc2$year, HYperc2$GC2t, type="h", col="grey", ylim=c(-100,100), xlab="", ylab="", xlim=c(1700,2015))
abline(h=50, lty=2, col="grey4")
abline(h=-50, lty=2, col="grey4")
par(new=TRUE, yaxt="n", xaxt="n")
#plot(Sal1$year, Sal1$RW, type="l", ylim=c(-2, 5), col="black", lwd=2, xlab="", ylab="", xlim=c(1835,2005))
plot(HYperc2$year, HYperc2$size, type="l", ylim=c(0,70), lwd=1.5, xlab="", ylab="", xlim=c(1700, 2015))
par(yaxt="s", xaxt="s")
axis(4, at=seq(0,30, 5), labels=c(0,5,10,15,20,25,30))
par(mgp=c(2, 0.2, 0))
axis(3, at=seq(1700, 2000, 25), labels=seq(1700, 2000, 25), cex=0.7)
#
par(xpd=NA)
text(2035, -3.5, "Sample depth (# trees)", srt=90,font=2)
par(xpd=FALSE)



############################
####las 3 juntas

gc=merge(PTperc2, RBperc2, by=c("year"), all.x=TRUE)
gc2=merge(gc, HYperc2, by=c("year"), all.x=TRUE)
#
##quito los NAs
#
for(i in 7:ncol(gc2))
{
gc2[,i]=ifelse(is.na(gc2[,i]), 0, gc2[,i])	
}
#

###FIGURA GCs todas juntas

color=c("orange", "black", "green")   ##el primero es petraeae, el segundo pyrenaica y el tercero el haya
#d=c(-1,-1,-1, 0, 25,25, 25, 11, 11)
d=c(-1, -1, -1)
years=gc2$year
#
Corr=t(as.matrix(cbind(gc2$GC1t.x, gc2$GC1t.y, gc2$GC1t)))
Corr2=t(as.matrix(cbind(gc2$GC2t.x, gc2$GC2t.y, gc2$GC2t)))
#

#############Figura
#
par(las=1, cex=1.31, cex.lab=1.71, cex.axis=1.71, lwd=1, font.axis=2, font.lab=2, tck=0.3, tcl=0.3, mgp=c(2,0.2,0), yaxt="n", xaxt="n", mar=c(11,11,7,15))
#
mp=barplot(Corr, beside=TRUE, col=color, borde=color, names.arg=NULL, width=0.01, space=c(0.01,0.02), density=d, font=1, ylim=c(-110, 110))
#
par(new=TRUE)
#
mp2=barplot(Corr2, beside=TRUE, col=color, borde=color, names.arg=NULL, width=0.01, space=c(0.01,0.02), density=d, font=1, ylim=c(-110, 110), legend=c(expression(bold(QUPT)), expression(bold(QUPY)),expression(bold(FAGU))), args.legend=list(x=3, y=-77, border=color, bty="n", ncol=3, cex=1.51))
box()
#
par(xpd=FALSE)
abline(h=0, lty=1, col="black")
abline(h=50, lty=3, col="black")
abline(h=-50, lty=3, col="black")
abline(v=max(colMeans(mp))*(165/310), lty=3, col="black")   ##aprox 1862
abline(v=max(colMeans(mp))*(282/310), lty=3, col="black")   ##aprox 1974
par(yaxt="s", xaxt="s", las=1)
axis(4, at=seq(-100, 100, by=25))
axis(2, at=seq(-100, 100, by=25))
#
xx=seq(0,max(colMeans(mp)), max(colMeans(mp))/12)
yy=seq(1700, 2000, 25)
#
axis(3, at=xx, labels=seq(1700, 2000, 25), cex=1.5)
par(mgp=c(3,0.5,0))
axis(1, at=xx, labels=seq(1700, 2000, 25), cex=1.5)
#
par(xpd=NA)
text(-1.1, 0, srt=90, "% trees GC> 50%", font=2, cex=2.2)
text(max(colMeans(mp))/2, -131, "Year", font=2, cex=2.2)
text(max(colMeans(mp))*(165/310), -88, "1861", cex=1.51, font=2)
text(max(colMeans(mp))*(270/310), -88, "1974", cex=1.51, font=2)
