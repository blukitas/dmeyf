require("data.table")
require("randomForest")


#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

setwd( "~/buckets/b1/" )

version <- "v951"
#leo el dataset , aqui se puede usar algun super dataset con Feature Engineering
dataset <- fread(paste0("./datasets/dataset_epic_",version,".csv.gz"), stringsAsFactors= TRUE)
# dataset  <- fread( "datasetsOri/paquete_premium.csv.gz", stringsAsFactors= TRUE)
gc()

#achico el dataset
dataset[  ,  azar := runif( nrow(dataset) ) ]
dataset  <-  dataset[  clase_ternaria =="BAJA+1"  & foto_mes>=202001  & foto_mes<=202011, ]
gc()


#quito los nulos para que se pueda ejecutar randomForest,  Dios que algoritmo prehistorico ...
dataset  <- na.roughfix( dataset )
gc()


campos_buenos  <- c( "ctrx_quarter", "cpayroll_trx", "mcaja_ahorro", "mtarjeta_visa_consumo", "ctarjeta_visa_transacciones",
                     "mcuentas_saldo", "mrentabilidad_annual", "mprestamos_personales", "mactivos_margen", "mpayroll",
                     "Visa_mpagominimo", "Master_fechaalta", "cliente_edad", "chomebanking_transacciones", "Visa_msaldopesos",
                     "Visa_Fvencimiento", "mrentabilidad", "Visa_msaldototal", "Master_Fvencimiento", "mcuenta_corriente",
                     "Visa_mpagospesos", "Visa_fechaalta", "mcomisiones_mantenimiento", "Visa_mfinanciacion_limite",
                     "mtransferencias_recibidas", "cliente_antiguedad", "Visa_mconsumospesos", "Master_mfinanciacion_limite",
                     "mcaja_ahorro_dolares", "cproductos", "mcomisiones_otras", "thomebanking", "mcuenta_debitos_automaticos",
                     "mcomisiones", "Visa_cconsumos", "ccomisiones_otras", "Master_status", "mtransferencias_emitidas",
                     "mpagomiscuentas")



#Ahora, a esperar mucho con este algoritmo del pasado que NO correr en paralelo, patetico
modelo  <- randomForest( x= dataset[ , campos_buenos, with=FALSE ],
                         y= NULL,
                         ntree= 1000, #se puede aumentar a 10000
                         proximity= TRUE,
                         oob.prox = TRUE )

#genero los clusters jerarquicos
hclust.rf  <- hclust( as.dist ( 1.0 - modelo$proximity),  #distancia = 1.0 - proximidad
                      method= "ward.D2" )


pdf( paste0( paste0("./work/cluster_jerarquico",version,".pdf" ) ))
plot( hclust.rf )
dev.off()


h <- 20
distintos <- 0

while(  h>0  &  !( distintos >=6 & distintos <=7 ) )
{
  h <- h - 1
  rf.cluster  <- cutree( hclust.rf, h)

  dataset[  , cluster2 := NULL ]
  dataset[  , cluster2 := rf.cluster ]

  distintos  <- nrow( dataset[  , .N,  cluster2 ] )
  cat( distintos, " " )
}

#en  dataset,  la columna  cluster2  tiene el numero de cluster
#sacar estadicas por cluster
dataset[  , .N,  cluster2 ]  #tamaño de los clusters

#ahora a mano veo las variables
dataset[  , mean(ctrx_quarter),  cluster2 ]  #media de la variable  ctrx_quarter
# dataset[  , mean(ctrx_quarter),  cluster2 ]  #media de la variable  ctrx_quarter
# head(dataset)
# unique(dataset[ , cluster2])
# unique(dataset[, clase_ternaria])
# unique(dataset[clase_ternaria == "BAJA+2", cluster2])
colnames(dataset)

#############################################################################

# Calcular Medias y Varianza para cada variable en cada cluster
# SELECCIONAR VARIABLES PARA MIRAR
colnames(dataset)
# cortar <- c("ctrx_quarter", "ctrx_quarter_lag1", "ctrx_quarter_lag2", #"ctrx_quarter_lag3", "ctrx_quarter_lag4", "ctrx_quarter_lag5", "ctrx_quarter_lag6", 
#                             "ctrx_quarter_delta1", "ctrx_quarter_delta2", # "ctrx_quarter_delta3", "ctrx_quarter_delta4", "ctrx_quarter_delta5", "ctrx_quarter_delta6",
#             "numero_de_cliente", 
#             "mcaja_ahorro", "mtarjeta_visa_consumo", 
#             "mcuentas_saldo","ctarjeta_visa_transacciones", 
#             "cpayroll_trx", "mpayroll", 
#             # "ctrx_quarter_avg3", "mcuentas_saldo_avg3",
#             "mprestamos_personales", "cluster2")
campos_lags = c()
for (i in campos_buenos) 
{ 
  campos_lags <- append(campos_lags, c(paste0(i, '_lag1'), paste0(i, '_delta1'),paste0(i, '_lag3'), paste0(i, '_delta3'),paste0(i, '_lag6'), paste0(i, '_delta6')) )  
}
cortar <- append(campos_lags, "cluster2")

# cortar <- c( "cluster2", "ctrx_quarter", "cpayroll_trx", "mcaja_ahorro", "mtarjeta_visa_consumo", "ctarjeta_visa_transacciones",
#                                   "mcuentas_saldo", "mrentabilidad_annual", "mprestamos_personales", "mactivos_margen", "mpayroll",
#                                   "Visa_mpagominimo", "Master_fechaalta", "cliente_edad", "chomebanking_transacciones", "Visa_msaldopesos",
#                                   "Visa_Fvencimiento", "mrentabilidad", "Visa_msaldototal", "Master_Fvencimiento", "mcuenta_corriente",
#                                   "Visa_mpagospesos", "Visa_fechaalta", "mcomisiones_mantenimiento", "Visa_mfinanciacion_limite",
#                                   "mtransferencias_recibidas", "cliente_antiguedad", "Visa_mconsumospesos", "Master_mfinanciacion_limite",
#                                   "mcaja_ahorro_dolares", "cproductos", "mcomisiones_otras", "thomebanking", "mcuenta_debitos_automaticos",
#                                   "mcomisiones", "Visa_cconsumos", "ccomisiones_otras", "Master_status", "mtransferencias_emitidas",
#                                   "mpagomiscuentas")
d <- dataset[, cortar, with=FALSE]
vars.mean <- d[, lapply(.SD, mean), by = cluster2]
vars.std <- d[, lapply(.SD, sd), by = cluster2]
# colnames(d)
cortar
colnames(vars.mean)
colnames(vars.std)
vars.mean.std = merge(vars.mean, vars.std, by = c('cluster2'))

colnames(vars.mean.std) =  gsub(".x", "_mean", colnames(vars.mean.std), fixed = TRUE)
colnames(vars.mean.std) =  gsub(".y", "_std", colnames(vars.mean.std), fixed = TRUE)
vars.mean.std
fwrite(vars.mean.std,
       file=paste0("12.clustering",version,".csv"),
       sep=";" )

# # #############################################################################
# require('ggplot2')
# 
# ggplot(data=vars.mean, aes(y=ctrx_quarter, x=cluster2, group=1)) +
#   geom_line()+
#   geom_point()
# 
# require(GGally)
# 
# ggparcoord(data = vars.mean,
#            groupColumn = "cluster2")
# 
# vars.mean
# 
# 
# fwrite(vars.mean,
#         file="datasets/baja4AgoClusters.txt",
#         sep="\t" )

## Guardo el cluster asignado
head(dataset[, c("numero_de_cliente", "cluster2")])

fwrite(dataset[, c("numero_de_cliente", "cluster2")],
       file=paste0("datasets/nro_cli_cluster",version,".csv"),
       sep="\t" )
