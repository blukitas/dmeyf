#script para HIBRIDAR  semillerios
#ha vuelto la diversidad genetica !

#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

require("data.table")
require("yaml")

# setwd( "~/buckets/b1/" )
setwd( "/home/lucas/Desktop/2021/Maestria/02.05.Data.Mining.E.y.F/Repo.TP/dmeyf/src/99.buckets/" )

#notar que son de experimentos distintos, y uno sumo 200 semillas y el otro apenas 70
# E1000 - s1511
# arch1  <- "./kaggle/E5058/Esemillerio_130_14000.csv"
# arch2  <- "./kaggle/E5032/semillerio_150_15000.csv"
# arch3  <- "./kaggle/E5041/Esemillerio_130_15000.csv"
# E1001 - s1512
arch1  <- "./kaggle/E5058/Esemillerio_130_11000.csv"
arch2  <- "./kaggle/E5032/semillerio_150_11000.csv"
arch3  <- "./kaggle/E5041/Esemillerio_130_11000.csv"


kexperimento <-  NA

kscript <-  "s1512"

#------------------------------------------------------------------------------
#Funcion que lleva el registro de los experimentos

get_experimento  <- function()
{
  if( !file.exists( "./maestro.yaml" ) )  cat( file="./maestro.yaml", "experimento: 1000" )

  exp  <- read_yaml( "./maestro.yaml" )
  experimento_actual  <- exp$experimento

  exp$experimento  <- as.integer(exp$experimento + 1)
  Sys.chmod( "./maestro.yaml", mode = "0644", use_umask = TRUE)
  write_yaml( exp, "./maestro.yaml" )
  Sys.chmod( "./maestro.yaml", mode = "0444", use_umask = TRUE) #dejo el archivo readonly

  return( experimento_actual )
}
#------------------------------------------------------------------------------
#Aqui empieza el programa

if( is.na(kexperimento ) )   kexperimento <- get_experimento()  #creo el experimento

#en estos archivos quedan los resultados
dir.create( paste0( "./kaggle/E",  kexperimento, "/" ) )     #creo carpeta del experimento dentro de work
kkaggle       <- paste0("./kaggle/E",kexperimento, "/E",  kexperimento, "_", kscript, "_" )



#leo lo datasets
modelo1  <- fread( arch1 )
modelo2  <- fread( arch2 )
modelo3  <- fread( arch3 )

#esta hermosamente ordenados por probabilidad descente
modelo1[ , ranking := .I ]
modelo2[ , ranking := .I ]
modelo3[ , ranking := .I ]


#los ordeno antes de aparearlos
#como tienen exactamente los mismos numero de cliente, todo va a ir bien
setorder( modelo1, numero_de_cliente )
setorder( modelo2, numero_de_cliente )
setorder( modelo3, numero_de_cliente )

modelo_nuevo  <- copy(  modelo1[  , c("numero_de_cliente"), with=FALSE ] )
modelo_nuevo[ , ranking  :=  130*modelo1$ranking + 150*modelo2$ranking + 130*modelo3$ranking ]   #ATENCION  el 200 es por las 200 semillas del modelo1, y el 70 por las 70 del modelo2

setorder( modelo_nuevo, ranking ) 

for(  corte  in seq( 10000, 14000, 250) ) #imprimo cortes en 10000, 11000, 12000, 13000, 14000 y 15000
{
  modelo_nuevo[ ,  Predicted := 0L ]
  modelo_nuevo[ 1:corte,  Predicted := 1L ]  #me quedo con los primeros

  #genero el archivo para Kaggle
  fwrite( modelo_nuevo[ , c("numero_de_cliente","Predicted"), with=FALSE], 
          file=  paste0(  kkaggle, "_",corte, ".csv" ),  
          sep= "," )
}


