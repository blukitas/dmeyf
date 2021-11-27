

#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

require("data.table")
require("Rcpp")
require("rlist")
require("yaml")

require("lightgbm")
 

#defino la carpeta donde trabajo
directory.root  <-  "~/buckets/b1/"  #Google Cloud
setwd( directory.root )

#cargo el dataset donde voy a entrenar
dataset  <- fread("./datasetsOri/paquete_premium.csv.gz")

cat("Guardo baja+1")
#Grabo el dataset
fwrite( dataset[  clase_ternaria =="BAJA+1"  & foto_mes>=202001  & foto_mes<=202011, ],
        paste0( "./datasets/dataset_2021_baja_1.csv.gz" ),
        logical01 = TRUE,
        sep= "," )


cat("Guardo baja+2")
#Grabo el dataset
fwrite( dataset[  clase_ternaria =="BAJA+2"  & foto_mes>=202001  & foto_mes<=202011, ],
        paste0( "./datasets/dataset_2021_baja_2.csv.gz" ),
        logical01 = TRUE,
        sep= "," )

gc()

quit()