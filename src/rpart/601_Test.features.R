#Arbol elemental con libreria  rpart
require("data.table")
require("rpart")

#Aqui se debe poner la carpeta de la computadora local
setwd("/home/lucas/Desktop/2021/Maestria/02.05.Data.Mining.E.y.F/Repo.TP/dmeyf/src/rpart")  #Establezco el Working Directory

# ksemilla_azar  <- 102191  #Aqui poner la propia semilla
seed <- 200177

# #cargo los datos de 202009 que es donde voy a ENTRENAR el modelo
# dtrain <- fread("./datasetsOri/paquete_premium_202009.csv")
# #cargo los datos de 202011, que es donde voy a APLICAR el modelo
# dapply  <- fread("./datasetsOri/paquete_premium_202011.csv")
#cargo los datos de 202009 que es donde voy a ENTRENAR el modelo
dtrain <- fread("./datasets/paquete_premium_202009_ext.csv")
#cargo los datos de 202011, que es donde voy a APLICAR el modelo
dapply  <- fread("./datasets/paquete_premium_202011_ext.csv")


## Drop de columnas con data drifting
drop_cols = c('internet'
             ,'tmobile_app'
             ,'cmobile_app_trx'
             ,'mcajeros_propios_descuentos'
             ,'mtarjeta_visa_descuentos'
             ,'mtarjeta_master_descuentos'
             ,'mcajeros_propios_descuentos'
             ,'Master_madelantodolares'
             ,'Visa_msaldodolares'
             # ,'Master_Finiciomora'
             # ,'Visa_Finiciomora'
)
dtrain <- dtrain[ ,.SD, .SDcols = !drop_cols]
dapply <- dapply[ ,.SD, .SDcols = !drop_cols]

#genero el modelo
modelo  <- rpart("clase_ternaria ~ .",
                 data = dtrain,
                 xval=0,
                 cp=        -0.980973448759374, 
                 minsplit=  1400,
                 minbucket=  406,
                 maxdepth=   6 )


#aplico al modelo  a los datos de 202011


prediccion  <- predict( modelo, dapply , type = "prob") #aplico el modelo

prediccion
#prediccion es una matriz con TRES columnas, llamadas "BAJA+1", "BAJA+2"  y "CONTINUA"
#cada columna es el vector de probabilidades 

dapply[ , prob_baja2 := prediccion[, "BAJA+2"] ]
dapply[ , Predicted  := as.numeric(prob_baja2 > 0.025) ]

table(dapply[ as.numeric(prob_baja2 > 0.025), 'prob_baja2'])
table(dapply[ as.numeric(prob_baja2 < 0.025), 'prob_baja2'])

entrega  <- dapply[   , list(numero_de_cliente, Predicted) ] #genero la salida

#genero el archivo para Kaggle
fwrite( entrega, file="./kaggle/E1019_featuring_kaggle_6.csv", sep="," )
