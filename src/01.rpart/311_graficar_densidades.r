#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

require("data.table")


#Aqui se debe poner la carpeta de la computadora local
setwd("/home/lucas/Desktop/2021/Maestria/02.05.Data.Mining.E.y.F/TP/dmeyf/src/rpart/")  #Establezco el Working Directory

seed <- 20

datasetA  <- fread( "./datasetsOri/paquete_premium_202009.csv" )
datasetB  <- fread( "./datasetsOri/paquete_premium_202011.csv" )


campos_buenos  <- setdiff(  colnames( datasetA),  c("numero_de_cliente","foto_mes","clase_ternaria" ) )


pdf("./work/densidades_01.pdf")
for( campo in  campos_buenos )
{
  cat( campo, "  " )
  distA  <- quantile(  datasetA[ , get(campo) ] , prob= c(0.05, 0.95), na.rm=TRUE )
  distB  <- quantile(  datasetB[ , get(campo) ] , prob= c(0.05, 0.95), na.rm=TRUE )

  a1  <- pmin( distA[[1]], distB[[1]] )
  a2  <- pmax( distA[[2]], distB[[2]] )

  densidadA  <- density( datasetA[ , get(campo) ] , kernel="gaussian", na.rm=TRUE)
  densidadB  <- density( datasetB[ , get(campo) ] , kernel="gaussian", na.rm=TRUE)

  plot(densidadA, 
       col="blue",
       xlim= c( a1, a2),
       main= paste0("Densidades    ",  campo), )

  lines(densidadB, col="red", lty=2)
  
  legend(  "topright",  
           legend=c("A", "B"),
           col=c("blue", "red"), lty=c(1,2))

}
dev.off()
