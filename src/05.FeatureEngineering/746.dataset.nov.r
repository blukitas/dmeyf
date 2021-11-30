

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
dataset  <- fread("./datasets/dataset_epic_v747_full.csv.gz")

cat("Guardo nov")
#Grabo el dataset
fwrite( dataset[  foto_mes>=202011  & foto_mes<=202011, ],
        paste0( "./datasets/dataset_noviembre_747.gz" ),
        logical01 = TRUE,
        sep= "," )
        
gc()

quit()