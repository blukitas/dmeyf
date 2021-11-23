#Feature Engineering
#creo nuevas variables dentro del mismo mes
#Condimentar a gusto con nuevas variables

#limpio la memoria
rm( list=ls() )
gc()

require("data.table")



#Establezco el Working Directory
# setwd( "~/buckets/b1/crudoB" )
setwd("/home/lucas/Desktop/2021/Maestria/02.05.Data.Mining.E.y.F/Repo.TP/dmeyf/src/01.rpart/")  #Establezco el Working Directory


EnriquecerDataset <- function( dataset , arch_destino )
{
  columnas_originales <-  copy(colnames( dataset ))

  #INICIO de la seccion donde se deben hacer cambios con variables nuevas
  #se crean los nuevos campos para MasterCard  y Visa, teniendo en cuenta los NA's
  #varias formas de combinar Visa_status y Master_status
  dataset[ , mv_status01       := pmax( Master_status,  Visa_status, na.rm = TRUE) ]
  dataset[ , mv_status02       := Master_status +  Visa_status ]
  dataset[ , mv_status03       := pmax( ifelse( is.na(Master_status), 10, Master_status) , ifelse( is.na(Visa_status), 10, Visa_status) ) ]
  dataset[ , mv_status04       := ifelse( is.na(Master_status), 10, Master_status)  +  ifelse( is.na(Visa_status), 10, Visa_status)  ]
  dataset[ , mv_status05       := ifelse( is.na(Master_status), 10, Master_status)  +  100*ifelse( is.na(Visa_status), 10, Visa_status)  ]

  dataset[ , mv_status06       := ifelse( is.na(Visa_status), 
                                          ifelse( is.na(Master_status), 10, Master_status), 
                                          Visa_status)  ]

  dataset[ , mv_status07       := ifelse( is.na(Master_status), 
                                          ifelse( is.na(Visa_status), 10, Visa_status), 
                                          Master_status)  ]


  #combino MasterCard y Visa
  dataset[ , mv_mfinanciacion_limite := rowSums( cbind( Master_mfinanciacion_limite,  Visa_mfinanciacion_limite) , na.rm=TRUE ) ]

  dataset[ , mv_Fvencimiento         := pmin( Master_Fvencimiento, Visa_Fvencimiento, na.rm = TRUE) ]
  dataset[ , mv_Finiciomora          := pmin( Master_Finiciomora, Visa_Finiciomora, na.rm = TRUE) ]
  dataset[ , mv_msaldototal          := rowSums( cbind( Master_msaldototal,  Visa_msaldototal) , na.rm=TRUE ) ]
  dataset[ , mv_msaldopesos          := rowSums( cbind( Master_msaldopesos,  Visa_msaldopesos) , na.rm=TRUE ) ]
  dataset[ , mv_msaldodolares        := rowSums( cbind( Master_msaldodolares,  Visa_msaldodolares) , na.rm=TRUE ) ]
  dataset[ , mv_mconsumospesos       := rowSums( cbind( Master_mconsumospesos,  Visa_mconsumospesos) , na.rm=TRUE ) ]
  dataset[ , mv_mconsumosdolares     := rowSums( cbind( Master_mconsumosdolares,  Visa_mconsumosdolares) , na.rm=TRUE ) ]
  dataset[ , mv_mlimitecompra        := rowSums( cbind( Master_mlimitecompra,  Visa_mlimitecompra) , na.rm=TRUE ) ]
  dataset[ , mv_madelantopesos       := rowSums( cbind( Master_madelantopesos,  Visa_madelantopesos) , na.rm=TRUE ) ]
  dataset[ , mv_madelantodolares     := rowSums( cbind( Master_madelantodolares,  Visa_madelantodolares) , na.rm=TRUE ) ]
  dataset[ , mv_fultimo_cierre       := pmax( Master_fultimo_cierre, Visa_fultimo_cierre, na.rm = TRUE) ]
  dataset[ , mv_mpagado              := rowSums( cbind( Master_mpagado,  Visa_mpagado) , na.rm=TRUE ) ]
  dataset[ , mv_mpagospesos          := rowSums( cbind( Master_mpagospesos,  Visa_mpagospesos) , na.rm=TRUE ) ]
  dataset[ , mv_mpagosdolares        := rowSums( cbind( Master_mpagosdolares,  Visa_mpagosdolares) , na.rm=TRUE ) ]
  dataset[ , mv_fechaalta            := pmax( Master_fechaalta, Visa_fechaalta, na.rm = TRUE) ]
  dataset[ , mv_mconsumototal        := rowSums( cbind( Master_mconsumototal,  Visa_mconsumototal) , na.rm=TRUE ) ]
  dataset[ , mv_cconsumos            := rowSums( cbind( Master_cconsumos,  Visa_cconsumos) , na.rm=TRUE ) ]
  dataset[ , mv_cadelantosefectivo   := rowSums( cbind( Master_cadelantosefectivo,  Visa_cadelantosefectivo) , na.rm=TRUE ) ]
  dataset[ , mv_mpagominimo          := rowSums( cbind( Master_mpagominimo,  Visa_mpagominimo) , na.rm=TRUE ) ]

  #a partir de aqui juego con la suma de Mastercard y Visa
  dataset[ , mvr_Master_mlimitecompra:= Master_mlimitecompra / mv_mlimitecompra ]
  dataset[ , mvr_Visa_mlimitecompra  := Visa_mlimitecompra / mv_mlimitecompra ]
  dataset[ , mvr_msaldototal         := mv_msaldototal / mv_mlimitecompra ]
  dataset[ , mvr_msaldopesos         := mv_msaldopesos / mv_mlimitecompra ]
  dataset[ , mvr_msaldopesos2        := mv_msaldopesos / mv_msaldototal ]
  dataset[ , mvr_msaldodolares       := mv_msaldodolares / mv_mlimitecompra ]
  dataset[ , mvr_msaldodolares2      := mv_msaldodolares / mv_msaldototal ]
  dataset[ , mvr_mconsumospesos      := mv_mconsumospesos / mv_mlimitecompra ]
  dataset[ , mvr_mconsumosdolares    := mv_mconsumosdolares / mv_mlimitecompra ]
  dataset[ , mvr_madelantopesos      := mv_madelantopesos / mv_mlimitecompra ]
  dataset[ , mvr_madelantodolares    := mv_madelantodolares / mv_mlimitecompra ]
  dataset[ , mvr_mpagado             := mv_mpagado / mv_mlimitecompra ]
  dataset[ , mvr_mpagospesos         := mv_mpagospesos / mv_mlimitecompra ]
  dataset[ , mvr_mpagosdolares       := mv_mpagosdolares / mv_mlimitecompra ]
  dataset[ , mvr_mconsumototal       := mv_mconsumototal  / mv_mlimitecompra ]
  dataset[ , mvr_mpagominimo         := mv_mpagominimo  / mv_mlimitecompra ]

  #valvula de seguridad para evitar valores infinitos
  #paso los infinitos a NULOS
  infinitos      <- lapply(names(dataset),function(.name) dataset[ , sum(is.infinite(get(.name)))])
  infinitos_qty  <- sum( unlist( infinitos) )
  if( infinitos_qty > 0 )
  {
    cat( "ATENCION, hay", infinitos_qty, "valores infinitos en tu dataset. Seran pasados a NA\n" )
    dataset[mapply(is.infinite, dataset)] <- NA
  }


  #valvula de seguridad para evitar valores NaN  que es 0/0
  #paso los NaN a 0 , decision polemica si las hay
  #se invita a asignar un valor razonable segun la semantica del campo creado
  nans      <- lapply(names(dataset),function(.name) dataset[ , sum(is.nan(get(.name)))])
  nans_qty  <- sum( unlist( nans) )
  if( nans_qty > 0 )
  {
    cat( "ATENCION, hay", nans_qty, "valores NaN 0/0 en tu dataset. Seran pasados arbitrariamente a 0\n" )
    cat( "Si no te gusta la decision, modifica a gusto el programa!\n\n")
    dataset[mapply(is.nan, dataset)] <- 0
  }

  #FIN de la seccion donde se deben hacer cambios con variables nuevas

  columnas_extendidas <-  copy( setdiff(  colnames(dataset), columnas_originales ) )

  #grabo con nombre extendido
  fwrite( dataset,
          file=arch_destino,
          sep= "," )
}
#------------------------------------------------------------------------------

DeflacionarDataset <- function( dataset, inflacion , arch_destino )
{
  columnas_originales <-  copy(colnames( dataset ))
  
  sufijodeflactado = "_deflactada"
  cols = c("mrentabilidad" , 
           "mrentabilidad_annual" , 
           "mcomisiones" , 
           "mactivos_margen" , 
           "mpasivos_margen" , 
           "mcuenta_corriente_adicional" , 
           "mcuenta_corriente" , 
           "mcaja_ahorro" , 
           "mcaja_ahorro_adicional" , 
           "mcaja_ahorro_dolares" , 
           "mdescubierto_preacordado" , 
           "mcuentas_saldo" , 
           "mautoservicio" , 
           "mtarjeta_visa_consumo" , 
           "mtarjeta_master_consumo" , 
           "mprestamos_personales" , 
           "mprestamos_prendarios" , 
           "mprestamos_hipotecarios" , 
           "mplazo_fijo_dolares" , 
           "mplazo_fijo_pesos" , 
           "minversion1_pesos" , 
           "minversion1_dolares" , 
           "minversion2" , 
           "mpayroll" , 
           "mpayroll2" , 
           "mcuenta_debitos_automaticos" , 
           "mttarjeta_visa_debitos_automaticos" , 
           "mttarjeta_master_debitos_automaticos" , 
           "mpagodeservicios" , 
           "mpagomiscuentas" , 
           "mcajeros_propios_descuentos" , 
           "mtarjeta_visa_descuentos" , 
           "mtarjeta_master_descuentos" , 
           "mcomisiones_mantenimiento" , 
           "mcomisiones_otras" , 
           "mforex_buy" , 
           "mforex_sell" , 
           "mtransferencias_recibidas" , 
           "mtransferencias_emitidas" , 
           "mextraccion_autoservicio" , 
           "mcheques_depositados" , 
           "mcheques_emitidos" , 
           "mcheques_depositados_rechazados" , 
           "mcheques_emitidos_rechazados" , 
           "matm" , 
           "matm_other" , 
           "Master_mfinanciacion_limite" , 
           "Master_msaldototal" , 
           "Master_msaldopesos" , 
           "Master_msaldodolares" , 
           "Master_mconsumospesos" , 
           "Master_mconsumosdolares" , 
           "Master_mlimitecompra" , 
           "Master_madelantopesos" , 
           "Master_madelantodolares" , 
           "Master_mpagado" , 
           "Master_mpagospesos" , 
           "Master_mpagosdolares" , 
           "Master_mconsumototal" , 
           "Master_mpagominimo" , 
           "Visa_mfinanciacion_limite"  , 
           "Visa_msaldototal" , 
           "Visa_msaldopesos" , 
           "Visa_msaldodolares" , 
           "Visa_mconsumospesos" , 
           "Visa_mconsumosdolares"  , 
           "Visa_mlimitecompra" , 
           "Visa_madelantopesos" , 
           "Visa_madelantodolares" , 
           "Visa_mpagado"  , 
           "Visa_mpagospesos" , 
           "Visa_mpagosdolares" , 
           "Visa_mconsumototal" , 
           "Visa_mpagominimo"  
    )
  
  # dataset = dataset_or[,c("numero_de_cliente","foto_mes",cols), with =FALSE]
  
  #agrego la inflacion acumulada
  dataset[inflacion, on = 'foto_mes', inflacion_acumulada := variacion_acumulada]
  
  for(vcol in cols)
  {
    dataset[, paste0(vcol, sufijodeflactado) := round(get(vcol)/(1+inflacion_acumulada),6)]
  }
  
  dataset[, inflacion_acumulada := NULL]
  
  #grabo con nombre extendido
  fwrite( dataset,
          file=arch_destino,
          sep= "," )
}
DeflacionarDataset(dataset1, inflacion, "./datasets/paquete_premium_202009_def.csv")
#------------------------------------------------------------------------------

DolarizarDataset <- function( dataset, arch_destino )
{
  cat("Dolariza dataset")
  
  inflacion <- fread("/home/lucas/Desktop/2021/Maestria/02.05.Data.Mining.E.y.F/Repo.TP/dmeyf/src/05.FeatureEngineering/20211116-precio-dolar.csv")
  
  columnas_originales <-  copy(colnames( dataset ))
  
  sufijodolarizado = "_dolariza"
  cols = c("mrentabilidad", "mrentabilidad_annual", "mcomisiones", "mactivos_margen", "mpasivos_margen", "mcuenta_corriente_adicional", "mcuenta_corriente", "mcaja_ahorro", "mcaja_ahorro_adicional", "mcaja_ahorro_dolares", "mdescubierto_preacordado", "mcuentas_saldo", "mautoservicio", "mtarjeta_visa_consumo", "mtarjeta_master_consumo", "mprestamos_personales", "mprestamos_prendarios", "mprestamos_hipotecarios",  "mplazo_fijo_dolares",  "mplazo_fijo_pesos",  "minversion1_pesos",  "minversion1_dolares",  "minversion2",  "mpayroll",  "mpayroll2",  "mcuenta_debitos_automaticos",  "mttarjeta_visa_debitos_automaticos",  "mttarjeta_master_debitos_automaticos",  "mpagodeservicios",  "mpagomiscuentas",  "mcajeros_propios_descuentos",  "mtarjeta_visa_descuentos",  "mtarjeta_master_descuentos",  "mcomisiones_mantenimiento",  "mcomisiones_otras",  "mforex_buy",  "mforex_sell",  "mtransferencias_recibidas",  "mtransferencias_emitidas",  "mextraccion_autoservicio",  "mcheques_depositados",  "mcheques_emitidos",  "mcheques_depositados_rechazados",  "mcheques_emitidos_rechazados",  "matm",  "matm_other",  "Master_mfinanciacion_limite",  "Master_msaldototal",  "Master_msaldopesos",  "Master_msaldodolares",  "Master_mconsumospesos",  "Master_mconsumosdolares",  "Master_mlimitecompra",  "Master_madelantopesos",  "Master_madelantodolares",  "Master_mpagado",  "Master_mpagospesos",  "Master_mpagosdolares",  "Master_mconsumototal",  "Master_mpagominimo",  "Visa_mfinanciacion_limite" ,  "Visa_msaldototal",  "Visa_msaldopesos",  "Visa_msaldodolares",  "Visa_mconsumospesos",  "Visa_mconsumosdolares" ,  "Visa_mlimitecompra",  "Visa_madelantopesos",  "Visa_madelantodolares",  "Visa_mpagado" ,  "Visa_mpagospesos",  "Visa_mpagosdolares",  "Visa_mconsumototal",  "Visa_mpagominimo"  )
  
  # dataset = dataset_or[,c("numero_de_cliente","foto_mes",cols), with =FALSE]
  
  #agrego la inflacion acumulada
  dataset[inflacion, on = 'foto_mes', dolar := valor]
  
  for(vcol in cols)
  {
    dataset[, paste0(vcol, sufijodolarizado) := round(get(vcol)/dolar,6)]
  }
  
  dataset[, dolar := NULL]
  
  #grabo con nombre extendido
  fwrite( dataset,
          file=arch_destino,
          sep= "," )
}
DolarizarDataset(dataset1, "./datasets/paquete_premium_202009_dol.csv")
#------------------------------------------------------------------------------
dir.create( "./datasets/" )


#lectura rapida del dataset  usando fread  de la libreria  data.table
dataset1  <- fread("./datasetsOri/paquete_premium_202009.csv")
dataset2  <- fread("./datasetsOri/paquete_premium_202011.csv")
inflacion <- fread("./datasetsOri/20211116-indice-inflacion.csv")

dataset1[clase_ternaria != 'CONTINUA' & foto_mes<=202011, ]

EnriquecerDataset( dataset1, "./datasets/paquete_premium_202009_def.csv" )
EnriquecerDataset( dataset2, "./datasets/paquete_premium_202011_def.csv" )



quit( save="no")
