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

	














