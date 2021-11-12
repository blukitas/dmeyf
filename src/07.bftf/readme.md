# Archivos de último visto

- 951: es como el 812 (genera el dataset) pero en este caso pone null a las variables rotas. En la línea 63 se puede levantar la palanca canarito (la levanté pero todavía no exploré ni usé los resultados)
- 961: es como el 823 pero hace un subsampling (muy recomendado)
- 981: sirven para hacer el cambio de semillas que después permite hacer el test de wilcox

Creo que no sirven:

- 991/992: Usa private
- 921: resultado del experimento
- 931: test de wilcox

Pregunta: Puedo tomar la referencia de estos últimos scripts para comparar los modelos


# Observaciones

Charlita sobre 951

[10/11 18:18] Maestría - Antonio Velázquez: Perdón el cuelgue, pero Denicolay dio una explicación de la serie 9XX de los scripts? O los tiró al repositorio y "averigüen qué hace"??? Gracias!
[10/11 18:21] +54 9 11 2783-5113: hay algo en los slides "back from de future" en el repo de la materia, pero no mucho la verdad, y durante la clase no recuerdo que se haya dicho mucho más.
[10/11 18:26] +54 9 11 5063-8741: Hola! Esto es lo que entendí yo de esos scripts y de las slides que dice Sebastián:
- 951: es como el 812 (genera el dataset) pero en este caso pone null a las variables rotas. En la línea 63 se puede levantar la palanca canarito (la levanté pero todavía no exploré ni usé los resultados)
- 961: es como el 823 pero hace un subsampling (muy recomendado)
- 981 y 991: sirven para hacer el cambio de semillas que después permite hacer el test de wilcox
- 921: resultado del experimento
- 931: test de wilcox

Si alguien tiene más info, bienvenida.
[10/11 18:34] +54 9 11 2783-5113: Buena onda che, gracias. Yo del 981 y 991 todavía no los entendí bien, porque tienen ganancia public y private, y creo que usa que ya sabe la clase del 202101.
Pero no sé, quizás estoy confundido. De hecho vengo desde hace unos días luchando para hacer un script que te corra el lgbm con los parámetros fijos sin BO igual que hace el 961 o 962 cuando genera la salida para kaggle (y de paso también guardar las probas antes, para intentar hacer lo que dijo Gustavo la última clase de promediarlas y obtener mejor ganancia).
[10/11 18:43] +54 9 11 2783-5113: Si recuerdo bien lo que dijo Gustavo, no porque stackear sin promediar es meter salidas de modelos que se parecen mucho. Creo que por eso Gustavo tiró lo de promediar las probas (y reordenar para cortar por el ratio original).

[10/11 18:43] +54 9 11 2783-5113: Si recuerdo bien lo que dijo Gustavo, no porque stackear sin promediar es meter salidas de modelos que se parecen mucho. Creo que por eso Gustavo tiró lo de promediar las probas (y reordenar para cortar por el ratio original).
[10/11 18:46] +54 9 11 2783-5113: Los 981 y 982 son los que creo que andan y encontré más parecido a correr un lgbm con parámetros fijos, pero pasa que esos te calculan ganancia en testing para cada semilla. (Bah si estoy interpretando bien los scripts).
[10/11 18:47] Maestría - Diego Milnik: Siempre con probas da más exacto. Pero tb es más dificil y lleva más tiempo
[10/11 18:47] Maestría - Diego Milnik: Los unos son rapidos y podes meter mas cosas en el puchero

[10/11 19:03] +54 9 11 5063-8741: Uuh, esta parte me cuesta. No me queda claro por qué no tendría el mismo o mejor resultado que promediar.
[10/11 19:12] +54 9 11 2783-5113: Sí es difícil. Ojo, yo la verdad que sé poco. Lo que entendí hasta ahora fue esto:


Tenés salidas de modelos diversos entre sí y los querés combinar para que (en teoría) dé mejor: stacking y otra BO.


Tenés un solo modelos, y querés reducir la varianza y estabilizar la ganancia de la perdigonada producto de la semilla del lgbm: promediar probas de las distintas semillas y recalcular la salida para kaggle.