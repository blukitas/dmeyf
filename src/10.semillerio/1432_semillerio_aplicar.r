#limpio la memoria
rm( list=ls() )  #remove all objects
gc()             #garbage collection

require("rlist")
require("yaml")

require("data.table")
require("lightgbm")
install.packages("primes")
require("primes")

#paquetes necesarios para la Bayesian Optimization
require("DiceKriging")
require("mlrMBO")


setwd("~/buckets/b1/")

kexperimento  <- NA

karch_dataset  <- "./datasets/dataset_epic_v1053.csv.gz"
ksalida  <- "semillerio" 

# 200 está bien, porque ahi se estabiliza la superposición de modelos
# 200 demoro se cortó. A mas de 20 horas, iba 151 
kcantidad_semillas  <- 150
 
#ATENCION
#aqui deben ir los mejores valores que salieron de la optimizacion bayesiana
# TODO: Estos valores hay que sacarlos mejores valores del bolog, y meterlos a mano
# TODO: Porque no hay mas hiperparametros?
x  <- list()
x$gleaf_size   <-  77.1555209849589
x$gnum_leaves  <-  0.782663140179195
x$learning_rate <-  0.04860339032512330
x$feature_fraction <-  0.54092754941253000
x$bagging_fraction <- 0.93214838765733200
x$bagging_freq <- 259
x$min_gain_to_split <- 0.782657615850288
x$lambda_l1 <- 3.239815686180980
x$lambda_l2 <- 163.0017370593740
x$max_bin <- 95
x$num_iterations  <- 445
x$pos_ratio  <- 0.04725799837647390
 
#------------------------------------------------------------------------------

particionar  <- function( data,  division, agrupa="",  campo="fold", start=1, seed=NA )
{
  if( !is.na(seed) )   set.seed( seed )

  bloque  <- unlist( mapply(  function(x,y) { rep( y, x )} ,   division,  seq( from=start, length.out=length(division) )  ) )  

  data[ ,  (campo) :=  sample( rep( bloque, ceiling(.N/length(bloque))) )[1:.N],
            by= agrupa ]
}
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


setwd("~/buckets/b1/")

set.seed( 102191 )   #dejo fija esta semilla

#me genero un vector de semilla buscando numeros primos al azar
primos  <- generate_primes(min=100000, max=1000000)  #genero TODOS los numeros primos entre 100k y 1M
ksemillas  <- sample(primos)[ 1:kcantidad_semillas ]   #me quedo con CANTIDAD_SEMILLAS primos al azar

#cargo el dataset donde voy a entrenar
dataset  <- fread(karch_dataset)

dataset  <- dataset[ foto_mes >= 202001 ]
gc()


setorder( dataset,  foto_mes, numero_de_cliente )

#paso la clase a binaria que tome valores {0,1}  enteros
dataset[ , clase01 := ifelse( clase_ternaria=="CONTINUA", 0L, 1L) ]


dataset[  , generacion := 0L ]
dataset[  foto_mes>=202001 & foto_mes<=202011, generacion := 1L ]


#los campos que se van a utilizar
campos_buenos  <- setdiff( colnames(dataset), c("clase_ternaria","clase01", "generacion") )


dfuturo  <- copy( dataset[ foto_mes==202101 ] )


#dejo los datos en el formato que necesita LightGBM
dtrain  <- lgb.Dataset( data= data.matrix(  dataset[ generacion==1, campos_buenos, with=FALSE]),
                        label= dataset[ generacion==1, clase01] )


# x$gleaf_size   <-  85.4649142464541
# x$gnum_leaves  <-  0.981276683577041
cat("x$gleaf_size")
cat(x$gleaf_size)
cat(x$gleaf_size/10.0)
#Hago la transformacion de los hiperparametros
x$min_data_in_leaf  <- pmax( 4 , as.integer( round( nrow(dtrain) /(1+ exp(x$gleaf_size/10.0) ) ) ) )
max_leaves          <- as.integer( 1 + nrow(dtrain) / x$min_data_in_leaf )
x$num_leaves        <- pmin(  pmax(  2,  as.integer( round(x$gnum_leaves*max_leaves)) ), 100000 )


# x$learning_rate <-  0.051729901923946
# x$feature_fraction <-  0.986244358771326
# x$bagging_fraction <- 0.809860999651362
# x$bagging_freq <- 841
# x$min_gain_to_split <- 1.07298723201579
# x$lambda_l1 <- 0.21183583148739
# x$lambda_l2 <- 141.69389448401500
# x$max_bin <- 224
# x$num_iterations  <- 358
#Aqui se deben cargar los parametros
param_buenos  <- list( objective= "binary",
                       metric= "custom",
                       first_metric_only= TRUE,
                       boost_from_average= TRUE,
                       feature_pre_filter= FALSE,
                       verbosity= -100,
                       seed= 484201,
                       max_depth=  -1,
                       max_bin=x$max_bin, # 31,
                       min_gain_to_split= x$min_gain_to_split,
                       lambda_l1=x$lambda_l1,
                       lambda_l2= x$lambda_l2, 
                       bagging_fraction = x$bagging_fraction,
                       bagging_freq = x$bagging_freq,
                       num_iterations= x$num_iterations,
                       learning_rate=  x$learning_rate,
                       feature_fraction= x$feature_fraction,
                       min_data_in_leaf=  x$min_data_in_leaf,
                       num_leaves= x$num_leaves
                     )


#inicializo donde voy a guardar los resultados
tb_predicciones  <- as.data.table( list( predicciones_acumuladas = rep( 0, nrow(dfuturo) ) ) )


if( is.na(kexperimento ) )   kexperimento <- get_experimento()  #creo el experimento

#en estos archivos quedan los resultados
dir.create( paste0( "./kaggle/E",  kexperimento, "/" ) )     #creo carpeta del experimento dentro de work


isemilla  <- 0

for( semilla in  ksemillas)
{
  gc()

  isemilla  <- isemilla + 1
  cat( isemilla, " " )  #imprimo para saber por que semilla va, ya que es leeentooooo

  param_buenos$seed  <- semilla   #aqui utilizo la semilla
  #genero el modelo
  set.seed( semilla )
  modelo  <- lgb.train( data= dtrain,
                        param= param_buenos )

  #aplico el modelo a los datos nuevos
  prediccion  <- frank(  predict( modelo, 
                                  data.matrix( dfuturo[ , campos_buenos, with=FALSE ]) ) )

  tb_predicciones[  , predicciones_acumuladas :=  predicciones_acumuladas +  prediccion ]  #acumulo las predicciones
  tb_predicciones[  , paste0( "pred_", isemilla ) :=  prediccion ]  #guardo el resultado de esta prediccion


  if(  isemilla %% 10 == 0 )  #imprimo cada 10 semillas
  {
    #Genero la entrega para Kaggle
    entrega  <- as.data.table( list( "numero_de_cliente"= dfuturo[  , numero_de_cliente],
                                     "prob"= tb_predicciones$predicciones_acumuladas ) ) #genero la salida

    setorder( entrega, -prob )

    #genero la salida oficial, sin mesetas
    entrega[ ,  Predicted := 0L ]
    cantidad_estimulos  <-  as.integer( nrow(dfuturo)*x$pos_ratio )
    entrega[ 1:cantidad_estimulos,  Predicted := 1L ]  #me quedo con los primeros

    #genero el archivo para Kaggle
    fwrite( entrega[ , c("numero_de_cliente","Predicted"), with=FALSE], 
            file=  paste0(  kkaggle, isemilla, ".csv" ),  
            sep= "," )



    for(  corte  in seq( 11000, 14000, 1000) ) #imprimo cortes en 10000, 11000, 12000, 13000, 14000 y 15000
    {
      entrega[ ,  Predicted := 0L ]
      entrega[ 1:corte,  Predicted := 1L ]  #me quedo con los primeros

      #genero el archivo para Kaggle
      cat(paste0("./kaggle/E",  kexperimento, "/E",  ksalida, "_", isemilla,"_",corte, ".csv"))
      fwrite( entrega[ , c("numero_de_cliente","Predicted"), with=FALSE], 
              file=  paste0("./kaggle/E",  kexperimento, "/E",  ksalida, "_", isemilla,"_",corte, ".csv"),
              # file=  paste0( "./kaggle/" , ksalida, "_", isemilla,"_",corte, ".csv" ),  
              sep= "," )
    }
  }


}

