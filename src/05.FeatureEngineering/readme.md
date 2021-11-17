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