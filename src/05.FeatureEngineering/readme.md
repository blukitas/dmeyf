# Feature engineering

## 740

Script de gustavo para graficar algunas estadísticas muy puntuales sobre cda variable del dataset.

Output:

* nas_ratio -> Cantidad de datos nulos (na) 
    * Referencias
        * Lineas verdes llenas, primer mes del año
        * Lineas verdes cortadas, mes 7 del año
        * Linea roja, 2020-11
        * Ultima línea verde, donde tenemos que predecir 2021-01
    * Observaciones
        * tmobile_app -> Comienza en 201907
        * cmobile_app_trx -> "
        * Master_delinquency -> En promedio 9-11% de faltantes (113)
        * Master_status -> " (Comportamiento calcado)
        * Master_mfinanciacion_limite -> " (Comportamiento calcado)
        * Master_Fvencimiento -> " (Comportamiento calcado)
        * Master_msaldototal -> " (Comportamiento calcado delinquency)
        * Master_msaldopesos -> " (Comportamiento calcado delinquency)
        * Master_msaldodolares -> " (Comportamiento calcado delinquency)
        * Master_Finiciomora -> 9-10% de faltantes (Caida abrupta 2018-07)
        * Master_mlimitecompra -> 9-11% de faltantes
        * Master_mlimitecompra -> " (Comportamiento calcado pesos)
        * Master_fultimo_cierre -> " (Comportamiento calcado pesos)
        * Master_mpagado -> " (Comportamiento calcado pesos)
        * Master_fechaalta -> " (Comportamiento calcado pesos)
        * Master_mpagominimo -> " (Comportamiento calcado pesos)
        * Master_madelantopesos -> 50-60% faltantes
        * Master_mconsumosdolares ->  " (Comportamiento calcado adelanto)
        * Master_mpagospesos ->  " (Comportamiento calcado adelanto)
        * Master_mpagosdolares ->  " (Comportamiento calcado adelanto)
        * Master_mconsumototal ->  " (Comportamiento calcado adelanto)
        * Master_cconsumos ->  " (Comportamiento calcado adelanto)
        * Master_cadelantosefectivo ->  " (Comportamiento calcado adelanto)
        * Visa_delinquency -> Abrupto en 202006 - en 2 y 5 % (135)
        * Visa_status -> "
        * Visa_mfinanciacion_limite -> "
        * Visa_Fvencimiento -> "
        * Visa_msaldototal -> "
        * Visa_msaldopesos -> "
        * Visa_msaldodolares -> "
        * Visa_mlimitecompra -> "
        * Visa_fultimo_cierre -> "
        * Visa_mpagado -> "
        * Visa_fechaalta -> "
        * Visa_mpagominimo -> "
        * Visa_Finiciomora -> 95-99% de faltantes
        * Visa_mconsumospesos -> 11-15%
        * Visa_mconsumosdolares -> "
        * Visa_madelantopesos -> "
        * Visa_madelantodolares -> "
        * Visa_mpagospesos -> "
        * Visa_mpagosdolares -> "
        * Visa_mconsumototal -> "
        * Visa_cconsumos -> "
        * Visa_cadelantosefectivo -> "   

* zeroes_ratio
    * Cantidad de ceros por variable. Porcentaje de valores = 0.
    * Referencias
        * Lineas verdes llenas, primer mes del año
        * Lineas verdes cortadas, mes 7 del año
        * Linea roja, 2020-11
        * Ultima línea verde, donde tenemos que predecir 2021-01
    * Observaciones

* Promedios cero    
    * Promedio sacando nan y ceros
    * Referencias
        * Lineas verdes llenas, primer mes del año
        * Lineas verdes cortadas, mes 7 del año
        * Linea roja, Si el ratio de 0 es > .99% y la media < 0.99 (Es menos 1 digamos)
        * Ultima línea verde, donde tenemos que predecir 2021-01
    * Observaciones

* Promedios no cero
    * Promedio sacando nan
    * Referencias
        * Lineas verdes llenas, primer mes del año
        * Lineas verdes cortadas, mes 7 del año
        * Linea roja, Si el ratio de 0 es > .99% y la media < 0.99 (Es menos 1 digamos)
        * Ultima línea verde, donde tenemos que predecir 2021-01
    * Observaciones
	
	
* Comentarios Zulip:
	* LAGS:
		* Utilizando solo el dataset original (los 159 campos ) . Aumenta bastante la ganancia, y disminuye la varianza
		* Utiliando los lag1 y delta1 ( unas 450 variables en el dataset). No aumenta tanto la ganancia al acumular modelos, pero afortunadamente con mas de 100 modelos disminuye la varianza.
		* Eso si, hay que correr 100 modelos sobre este dataset cambiando las semillas, por más que los hiperparámetros están fijos y son los que encontró una Optimización Bayesiana.
	* Acumulacion de modelos
		* Ante la pregunta de @Alejandro Bolaños sobre si el Modelo 1 , sobre los datos originales, al acumular le termina ganando al Modelo 2 sobre los datos
			* Modelo 1 datos originales, simple : 21. 62
			* Modelo 1, datos originales, acumulando 100 modelos : 22.24
			* -
			* Modelo 2 lag1 y delta1, simple : 22.36
			* Modelo 2, lag1 y delta1, acumulando 100 modelos : 22.60
		* La respuesta es no, el modelo 2 aún sin acumular es mejor que el modelo 1 acumulando.
		* Si es notable el aumento del modelo 1 cuando acumula, situación que no se observa en tal medida en el modelo 2.
	* Promedio de probabilidades
		* Entonces, sería super overfitero quedarse con el promedio de probabilidades que da la máxima ganancia en esa curva. Respuesta:
			* Decididamente creer que vas a poder alcanzar la MAYOR ganancia de la curva roja es totalmente overfitero, yo me quedaria con el valor de cuando se estabiliza.
	
		* El valor del empujón final esta en reducir la varianza, depender menos de la suerte en la competencia.
		* Que aumente un poco la ganancia, aunque no supere al mejor modelo con alguna semilla, es un plus no buscado, y es muy bienvenido !
		* Vuelta de rosca:
			* frank de las probabilidades
			* se promedian los rankings
			* Se cortan cierta cantidad de modelos


## Estratégias que mejoran mejores modelos

Hemos probado experimentalmente que estas dos estrategias generan mejores modelos :

entrenar en la unión de varios meses
agregar variables nuevas mediante el Feature Engineering
Lo anterior aumenta enormemente la "superficie" de los datasets donde luego debe correr la Bayesian Optimization.

Para aliviar el tiempo de corrida de la B.O. procedemos a :

Eliminar variables mediante "Canaritos"
Hacer undersampling de los CONTINUA al 10%
Luego de corrida la B.O. tenemos los mejores hiperparámetros, y finalmente entrenamos sobre el dataset sin undersampling de los CONTINUA, entreno sobre todos los datos para generar un modelo mas preciso. No entreno durante la B.O. sobre todos los datos por una cuestion de tiempo.
( En realidad los scripts actuales van generando los archivos para Kaggle durante la corrida y mientras corren, cuando hay una ganancia superadora, corren el entrenamiento final sobre los datos sin undersampling.)

Se produce la siguiente situación :

Se corre una optimización bayesiana sonbre train_BO=[202001,20209] nrow(train_BO)= 214510 , validate/test=[202011]
De la B.O. salen los mejores hiperparámetros
El modelo final se entrena en train_final= [202001, 202011] , dos meses más, y sin undersampling, con lo cual ahora queda un nrow( train_final ) = 2506546
Aquí se ve que la B.O. ha entrenado en menos de la décima parte de donde se entrena el modelo final

Sin embargo surge una duda existencial :

¿Es razonable/optimo que utilice los hiperparámetros obtenidos sobre un dataset de apenas 214510 registros para entrenar el modelo final sobre un enorme dataset de 2506546 registros ?
Si en la B.O. sale como óptimo un min_data_in_leaf de por ejemplo 545 , ¿ es ese el valor óptimo para entrenar en el dataset con 10 veces más registros?

¿ Debería yo utilizar min_data_in_leaf= 545 como estoy haciendo hasta ahora o ESCALARLO al tamaño del nuevo dataset donde voy a entrenar? Es decir probar entrenar en el dataset grande final con un min_data_in_leaf de 5450 (diez veces el original)

Hoy los resultados que obtenemos son buenos, la inquietud es si no los podemos mejorar atendiendo el tema de este post.
	
	
	
	
	
	
	
	
	
	