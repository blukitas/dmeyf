# Csv para subir a Kaggle

Csv generados para subir a kaggle para la competencia

## Datos

Dataset usado en cada uno:

* 00.K101_001 y 02.K101_001 -> Primeros dataset. El original + un tiro con tuneo de hiperparametros a mano
* K101* -> Usando el grid search de hiperparametros que pasó. Todo el espacio en números acotados.


### Usando optimizacion bayesiana

* E1001 -> Espacio de búsqueda sin modificación (Ejecución básica)
* E1002 -> Espacio de búsqueda sin modificación (Ejecución total, 200 iteraciones)
	* Subir al puesto 2
* E1004, E1005 y E1006 -> Espacio de búsqueda sin modificación, todas las columnas (Problemas con las iteraciones)
* E1007, E1008, E1009 -> 
	* Espacio de búsqueda sin modificación 
	* Ejecución total
	* 500 iteraciones
	* Seed: 102191

* E1010 -> 
	* Espacio de búsqueda sin modificación 
	* Ejecución total
	* 500 iteraciones
	* Seed: 200177
	* Drop de columnas con posible data drifting
		* 'internet'
        * 'tmobile_app'
        * 'cmobile_app_trx'
        * 'mtarjeta_visa_descuentos'
        * 'mtarjeta_master_descuentos'
        * 'mcajeros_propios_descuentos'
        * 'Master_madelantodolares'
        * 'Visa_msaldodolares'

* E1011 -> 
	* Espacio de búsqueda sin modificación 
	* Ejecución total
	* 500 iteraciones
	* Seed: 200177
	* Drop de columnas con posible data drifting
		* 'internet'
        * 'tmobile_app'
        * 'cmobile_app_trx'
        * 'mtarjeta_visa_descuentos'
        * 'mtarjeta_master_descuentos'
        * 'mcajeros_propios_descuentos'
        * 'Master_madelantodolares'
        * 'Visa_msaldodolares'
	    * 'Master_Finiciomora'
	    * 'Visa_Finiciomora'



## Ideas

* Ver el dataset, el diccionario, posibles transformaciones
* 0 como nan? Algo que sugirió Joaquin
* Transformación de datos de fecha. Usar fecha de cierre de cartera, días de mora desde el cierre de cartera.
	* 'Master_Finiciomora'
	* 'Visa_Finiciomora'
* Reveer data drifting y curvas del delta
	* Las de fecha tienen una forma de sinusoidal interesante
* Versionar dataset + parametros + resultado

* Normalizar pesos?
	* Mensaje de Gustavo para => @Antonio Velazquez Bustamante con respecto a "estoy investigando aplicar transformaciones logarítmicas a las variables" los arboles de decisión y sus primos mayores Random Forest y Gradient Boosting of Decision Trees son INSENSIBLES a transformaciones univariadas estrictamente monótonas de los atributos, por ejemplo normalizar un atributo, calcularle el logaritmo, una transformación lineal del tipo ax + b, etc.
	* Atencion, distinto es que vos tengas los atributos v1 y v2 y los combines, y crees el cociente v1/v2 , o log(v1) + log(v2) , etc
* Ajuste por inflacion?
	


* LightGBM 
	* Antonio Velazquez Bustamante Adrian Norberto Marino A mi me gusta trabajar con LightGBM, que corre tres o cuatro veces más rápido que XGBoost ( tanto R, Python y Julia llaman al mismo XGBoost y LightGBM, ya que estos dos últimos están programados en C/C++ )
	* Los hiperparámetros que optimizo de LightGBM con una Bayesian Optimization son:
		* min_data_in_leaf de 1 a 5000
		* num_leaves de 16 a 1024
		* feature_fraction de 0.1 a 1.0
		* learning_rate de 0.01 a 0.1

	* Parámetros que dejo FIJOS en LightGBM
		* objective= "binary"
		* metric= "custom"
		* first_metric_only= TRUE
	 	* boost_from_average= TRUE
		* feature_pre_filter= FALSE

		* max_bin=31

		* early_stopping_rounds= as.integer(50 + 5/x$learning_rate)
		* num_iterations= 99999 #Lo frena el Early Stopping
	* Finalmente, uso como eval= fganancia_logistic_lightgbm donde la función es la función de la materia

		fganancia_logistic_lightgbm <- function(probs, datos)
		{
		vlabels <- getinfo(datos, "label")

		gan <- sum( (probs > PROB_CORTE ) * ifelse( vlabels== 1, 48750, -1250 )
		)

		return( list( "name"= "ganancia",
		"value"= gan,
		"higher_better"= TRUE ) )
		}

	* Otra cosa interesante, para Light GBM me pareció mucho más simple instalar la versión con soporte para GPU en R (Con XGBoost es mas complicado).












