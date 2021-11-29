require("data.table")
require("randomForest")

#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

#####################################
dataset <- fread( "datasets/paquete_premium_meses_muerte.txt.gz", stringsAsFactors= TRUE)
setwd( "~/buckets/b1/" )
gc()

# FILTRAR A GUSTO
#dataset[  ,  azar := runif( nrow(dataset) ) ]
#unique(dataset[ meses_muerte == NA , ])
dataset  <-  dataset[  meses_muerte == 4  & foto_mes==202008, ]# & foto_mes<=202009, ]

gc()

## clase_ternaria =="BAJA+1"
#quito los nulos para que se pueda ejecutar randomForest,  Dios que algoritmo prehistorico ...
dataset  <- na.roughfix( dataset )
gc()

# SELECCIONAR VARIABLES CON LAS QUE CLUSTERIZAR
campos_buenos  <- c( "ctrx_quarter", "cpayroll_trx", "mcaja_ahorro", "mtarjeta_visa_consumo", "ctarjeta_visa_transacciones",
                     "mcuentas_saldo", "mrentabilidad_annual", "mprestamos_personales", "mactivos_margen", "mpayroll",
                     "Visa_mpagominimo", "Master_fechaalta", "cliente_edad", "chomebanking_transacciones", "Visa_msaldopesos",
                     "Visa_Fvencimiento", "mrentabilidad", "Visa_msaldototal", "Master_Fvencimiento", "mcuenta_corriente",
                     "Visa_mpagospesos", "Visa_fechaalta", "mcomisiones_mantenimiento", "Visa_mfinanciacion_limite",
                     "mtransferencias_recibidas", "cliente_antiguedad", "Visa_mconsumospesos", "Master_mfinanciacion_limite",
                     "mcaja_ahorro_dolares", "cproductos", "mcomisiones_otras", "thomebanking", "mcuenta_debitos_automaticos",
                     "mcomisiones", "Visa_cconsumos", "ccomisiones_otras", "Master_status", "mtransferencias_emitidas",
                     "mpagomiscuentas")

# #
# #
# #Ahora, a esperar mucho con este algoritmo del pasado que NO correr en paralelo, patetico
modelo  <- randomForest( x= dataset[ , campos_buenos, with=FALSE ],
                         y= NULL,
                         ntree= 1000, #se puede aumentar a 10000
                         proximity= TRUE,
                         oob.prox = TRUE )
# 
#genero los clusters jerarquicos
hclust.rf  <- hclust( as.dist ( 1.0 - modelo$proximity),  #distancia = 1.0 - proximidad
                      method= "ward.D2" )
# 
# 
pdf( paste0( paste0("./work/cluster_jerarquico.pdf" ) ))
plot( hclust.rf )
dev.off()
# 
# 
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
# dataset[  , mean(ctrx_quarter),  cluster2 ]  #media de la variable  ctrx_quarter
# head(dataset)
# unique(dataset[ , cluster2])
# unique(dataset[, clase_ternaria])
# unique(dataset[clase_ternaria == "BAJA+2", cluster2])


#############################################################################

# Calcular Medias y Varianza para cada variable en cada cluster
# SELECCIONAR VARIABLES PARA MIRAR

cortar <- c("ctrx_quarter", "numero_de_cliente", "mcaja_ahorro", "mtarjeta_visa_consumo", "mcuentas_saldo",
"ctarjeta_visa_transacciones", "cpayroll_trx", "mpayroll", "mprestamos_personales", "cluster2")
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
colnames(d)
vars.mean.std = merge(vars.mean, vars.std, by = 'cluster2')


# fwrite(vars.mean.std,
#         file="datasets/baja1OctClusters.txt",
#         sep="\t" )
# 
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


# # #############################################################################
# baja4  <-  dataset[  meses_muerte == 4  & foto_mes==202008, numero_de_cliente ]# & foto_mes<=202009, ]
# require(dplyr)
# filter(dataset[numero_de_cliente,] %in% baja4)
# dataset[numero_de_cliente == baja4, ]
# filtro <- c(baja4)
# filtro
# 
# keys = data.table(numero_de_cliente = baja4)
# setkey(keys, "numero_de_cliente")
# setkey(dataset, "numero_de_cliente")
# slice_clientes4 = dataset[keys]
# sliced = slice_clientes4[ foto_mes == 202011,]

################################################################################
# continuan <- dataset[is.na(meses_muerte),]
# continuan[ foto_mes == 202011,]