# Juan Grande

Juan Grande, 38 años, es el gerente de ciencia de datos de la compañía, es su jefe directo y fue quien lo contrató hace 8 meses.

Juan posee un título de grado de **Actuario**, desde su graduación de dedicó a análisis econométricos en riesgo crediticio, en el año 2015 cursó una maestría en ciencia de datos e ingresó a trabajar a la compañía en el año 2016, ya en 2019 lo ascendieron a gerente en medio de una reorganización general de toda el área comercial. Juan es una persona muy metódica y organizada, pausado en su hablar, elige sus palabras con gran precisión, reflexivo, considera muchas opciones antes de tomar una decisión, ante una situación difícil a resolver escribe un cuadro en su **excel** con las alternativas a las que les estima una probabilidad. Juan en las reuniones va escribiendo la minuta en tiempo real y la disponibiliza a todos ni bien termina. Juan es una persona muy **focalizada** y ninguna idea foránea lo distrae del problema que debe resolver.

Prefiere aprender en forma estructurada y abordar los temas desde lo abstracto.

Juan posee un elevado sentido de la ética y la justicia.

Juan espera de usted un video con una breve presentación de _alrededor de 5 minutos_ en donde con un _storytelling_ le cuente la forma en que resolvió el problema, los hallazgos más importantes. Esta no es una tesis de maestría, usted no debe explicar el algoritmo árbol de decisión ni gradient boosting, usted **debe ir al grano con Juan, pero sorprenderlo**.

A Juan _le reportan 20 personas;_ él le reporta a la directora comercial y es el "gerente de menos peso". Sus
pares son las siguientes gerencias:

* sucursales (1000 comerciales), 
* productos pasivos
* productos activos
* canales digitales
* marketing
* telemarketing 
* atención al cliente.


## Tips

* Estamos parados en octubre 2022, usted ingresó al Banco en febrero-2022 tiene 8 meses de antiguedad, está cursando el segundo año de la maestria de la UBA, aún no tiene debajo de su brazo el título de Magister en Ciencia de Datos.
* El sector está formado por 21 personas, Juan Grande su jefe directo, 19 compañeros y usted. El sector existe desde hace más de una década, su creación es anterior al ingreso de Juan Grande.
* En el sector hay data engineers, data scientists y data analysts, de distintas edades y grado de experiencia. Algunos de ellos son egresados de maestrías de ciencia de datos, hay varios actuarios, algunos han aprendido por su cuenta,
* Decididamente **usted NO es la persona con mas experiencia** en ciencia de datos el sector y el sector era completamente funcional antes de su ingreso al Banco.
* El Banco es una empresa **multinacional**, de capitales extranjeros, presente en decenas de países. No es una universidad publica, tampoco privada, no es el Conicet, ni tampoco se maneja como una repartición estatal.


* Juan Grande _fomenta en el sector el uso de scripts_ que ya están hechos y que comparten los integrantes del equipo de ciencia de datos (serían los scripts que la materia le proveyó), la reutilización de software es vital para Juan y el mantener alta la productividad del sector.
    * usted pasó _los primeros meses en el sector accediendo a los repos y entendiendo scripts_ que ya estaban, la estética con la que codean y documentan, leyendo informes de otros proyectos similares al que le iban a encargar, documentación sobre el datawarehouse, leyendo la prolija wiki interna del sector, etc


* Juan Grande, actuario, está siempre **muy preocupado por la validez estadística** de las conclusiones a las que llegan los modelos. Está muy al tanto de https://journals.plos.org/plosmedicine/article?id=10.1371/journal.pmed.0020124 el "sesgo de publicacón" también conocido como " file-drawer effect"
* Juan obliga a todo su sector a que en los reportes de cada proyecto dejen formalmente asentado todas las alternativas que probaron y que no funcionaron (o no funcionaron tan bien), y cada vez que alguien encara un proyecto debe leer esos experimentos fallidos.
* Juan ve con buenos ojos que usted diga "creí que este camino era bueno, hice estos experimentos, pero ninguno dio buenos resultados"
    * Juan ve con **pésimos ojos que todo lo que usted prueba sea un fracaso**, a algo le tiene que acertar ... sino lo va a devolver a su trabajo anterior...
* Es muy importante que en su video presentación a Juan Grande incluya experimentos que no funcionaron, y explique con total claridad la cantidad de experimentos realizados. Piense por ejemplo en todas las pruebas que está haciendo @Antonio Velazquez Bustamante , es muy probable que alguna de ellas, por mera suerte, temine muy arriba en el Public Leaderboard, pero sea patética en el Private.
    * **Cantidad de experimentos**
* Ni se le ocurra en los últimos días antes de la entrega solo probar cosas para "rellenar" . Juan no es tonto ... y el Private Leaderboard aún menos ...


* en el sector todo el mundo sabe no se puede medir la ganancia en training, no lo mencione en el video. 
* en el sector nadie utiliza grid search para la optimización de hiperparámetros, todos utilizan Bayesian Optimization y saben que es  superior al grid, no comente este hecho en el video.
* en el sector usted no probó ni arboles de decisión, lo que utilizan para datos estructurados es XGBoost o LightGBM, sería una novedad utilizar Random Forest o Deep Learning.
* en el sector desde hace años prueban la metodología de canaritos para reducir variables; no lo cuente como un invento suyo en el video; si hizo experimentos con esta metodología narre los resultados, si le dio alguna "vuelta de tuerca" interesante, cuéntela.
* en el sector ya utilizan previo a su ingreso la técnica "semillerio" = ensamblar modelos cambiando únicamente la semilla aleatoria; no lo cuente como un invento suyo en el video.
* no gaste valiosos segundos del video mostrando la derivación matemática que 0.025 es la probabilidad de corte óptima dada la fórmula de ganancia


* Intente mostrar claramente un descubrimiento exitoso, algo que sea muy interesante, algo que sus compañeros de sector jamas se animaron a probar, que siempre hicieron de la misma forma, y que llegó usted al sector, "el nuevo", con la "Ingenuidad de Richard Feynman" y dio vuelta. 
* recuerde siempre, se espera knowledge Discovery
* Juan quiere saber si usted si usted es un inventor o un mantenedor, para saber en que posición del equipo lo pone a jugar.
* Sorprenda a Juan Grande al contarle que cosas cambió, que uso no tradicional hizo de los scripts del sector
* Sorprenda a Juan con algún Feature Engineering que funcionó bien y cuéntele en el video la génesis de esa idea, las peripecias que pasó hasta que encontró algo que funcionara bien, las intuiciones que fue teniendo además de los experimentos.
    * experimentos con la metodología correcta cualquier persona suficientemente educada lleva a cabo... generar intuiciones poderosas no.
