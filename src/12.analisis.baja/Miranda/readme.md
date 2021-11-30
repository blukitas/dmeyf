# Miranda

Miranda Wintour, argentina, 48 años, dos hijas gemelas pre adolescentes, es la directora comercial de la compañía desde hace dos años y medio, y en su meteórica carrera se pronostica que llegará a la gerencia general en dos años más.

Ambos padres de Miranda son nacidos fuera de Argentina dedicados en su momento a la actividad consular. Miranda de joven emigró, concluyó sus estudios secundarios en el UWC Atlantic College en Gales, se graduó con honores en Ciencias Políticas en la Sorbonne Université de París y cursó una maestría en economía en la London School of Economics and Political Science.

Miranda practica yachting desde su infancia, actividad fomentada por su padre quien le inculcó el trabajo en equipo y la competitividad. En su juventud participó de varias competencias internacionales, siendo un punto de inflexión en su vida la accidentada carrera de 1998 54th Sydney to Hobart Yacht Race. En su oficina posee un cuadro de muy importantes dimensiones con una fotografía de esa carrera en donde se aprecia a una joven Miranda formando parte de un numeroso equipo sobre una embarcación, al pie del cuadro reza una enorme leyenda **"Las regatas se ganan en tierra"**.

Miranda se unió desde muy joven a la compañía en Europa, estuvo a cargo del área Fintech europea y la convencieron de hacerse cargo en argentina de una transformación radical. Su primera tarea fue desarticular el anquilosado club de amigos que había formado su antecesor.

Aunque va con una sonrisa y su tono de voz es muy bajo y sereno, _todos tienen una especie de temor_ hacia ella. Se dice cuando luego de una exposición Miranda le dice al disertante "buen trabajo" sonriendo, antes de los tres meses esa persona ya no está más en la compañía.

Usted jamás ha participado en una reunión con ella y esta será su gran oportunidad de ser conocido y que lo empiece a tener en el radar, ya que rumores dicen que Miranda no está del todo convencida de la _manifiesta aversión de Juan Grande a tomar riesgos_.

Un total de 2500 personas dependen indirectamente de Miranda, estando el grueso en la red de sucursales, telemarketing y atención al cliente

Usted debe realizar un video presentación a Miranda que no puede exceder 5 minutos en **donde le explique los motivos por los que se dan de baja los clientes de paquete premium y proponga acciones para revertirlo**. Miranda no sabe (ni le interesa saber) sobre Ciencia de Datos pero si está absolutamente convencida de las posibilidades que brinda la tecnología para tratar uno a uno a los clientes.

## Tips

* En la consigna dice claramente "Usted debe realizar un video presentación a Miranda que no puede exceder 5 minutos en donde le explique los motivos por los que se dan de baja los clientes de paquete premium y proponga acciones para revertirlo."
* por favor entienda que NO se le está pidiendo que le explique a Miranda lo mismo que a Juan pero con otras palabras.
* La presentación que usted debe hacer a Miranda es totalmente diferente a la que hizo a Juan Grande.
* Juan Grande en su reunion mensual uno a uno con Miranda Wintour , ya le explico el status de las campañas de adquisición, cross selling, up selling, y attrition realizadas por el equipo. Allí fue donde Miranda le dijo "quiero alguien de tu equipo me cuenta la razon por la que se estan dando de baja los clientes"
* Atencion, NO se le está solicitando que le explique a Miranda la campaña de retención de clientes desde el punto de vista de negocios, a Miranda no le interesa que usted le va a hacer ganar 22 millones de pesos al banco, ella multiplica esa cifra por 1000 mensualmente. Juan ya se lo contó

Uso de la información
* A Miranda no le interesa la formula de ganancia , ella quiere entender los perfiles de los clientes que se van, y luego se juntará con Marketing , Ventas y Atención a Clientes diseñarán algo totalmente distinto a la pésima campaña que usted dispone hoy en dia que apenas retiene al 50% de los clientes que se iban a ir. Miranda está pensando en grande.
* Miranda quiere entender que perfiles tienen los clientes que se van a dar de baja y que se puede hacer con anticipación para evitar que eso suceda.
* No le explique a Miranda "antes de fallecer el 95% de los clientes pasa una temporada en terapia intensiva donde no consume con las tarjetas de crédito, no tiene dinero en la cuenta, no transacciona, está inconciente en coma, orina por una sonda y tiene pañales", eso ya es obvio para Miranda, tiene que explicarle como es que los clientes llegan a esa situación, quienes llegan a esa situación.

No le interesa
* A Miranda NO le interesan ni quiere escuchar absolutamente nada, ni una sola vez en los 5 minutos de su presentación:
* la Ciencia de Datos es buena, y contribuye a la rentabilidad del Banco
* los científicos de datos somos derechos y humanos, somos valiosos para la empresa, y el sector debería crecer
* El ROI del sector de Ciencia de Datos es xxxxx
* hay BAJA+1 , BAJA+2 y CONTINUA, por temas operativos no llegamos a las BAJA+1, por lo cual debemos focalizarnos en las BAJA+2
* ganancia = 48750* POS - 1250 * NEG
* en la campaña se envían 12000 estímulos al mes, se atrapan 800 bajas, y se ganan $ 21 M al mes
* overfitting, underfitting
* Gradient Boosting of Decision Trees, Lightgbm
* Bayesian Optimization
* los débiles canaritos ni la locura del semillerio. Miranda ya sabe que los canarios comen alpiste.
* apenas con USD 200 al mes gastados en Google Cloud mensualmente para reentrenar el modelo, logramos generarle una ganancia de 22 millones al Banco
* la personalizacion, el marketing uno a uno son rentables
* Miranda ya echó los primeros meses de su gestión a un grupo de gerentes "sanateros" carentes de profesionalismo, detecta a los que quieren congraciarse con ella al vuelo y odia las presentaciones llenas de humo. Justamente fue valorada toda su vida profesional el Europa por identificar los problemas y resolverlos directamente .

¿ qué contenido debo mostrar en el video a Miranda, mas allá de los tontos tips ?

En primer lugar analizaría las distintas enfermedades por las que mueren los clientes, los distintos clusters que hay entre los que van a darse de baja el próximo mes.
Crearía un dataset con los BAJA+1 de varios meses, solo con las variables más importatnes, y haría un Cluster Jerárquico utilizando Random Forest, nada del horrendo k-means ni ningún otro método de origen puramente matemático , sino que prefiero un origen del Machine Learning
La teoría de esto puede verse en https://www.researchgate.net/profile/Reem-Ibrahim-Hasan/publication/332910392_random_forest/links/5cd1a28692851c4eab896e9c/random-forest.pdf
Tambien pueden buscar la teoria bajo "unsupervised random forest"

Armó un script de clustering, unsupervised random forest

* ahora pasamos lo que haría en segundo lugar para el video de Miranda, luego de ver los resultados de lo anterior, quizas antes probaria el clustering con BAJA+2, o quien dice unos BAJA+3 o BAJA+4 para ver como son los clusters algunos meses antes de morir. ya detectamos los distintos tipos de enfermedades por las que mueren los clientes del banco pero en esta segunda etapa quiero hacer algo muy distinto .
    * oh, una lástima, no se si va a poder ser esta noche
    * no me alcanza el margen de Zulip "R scriptum mirabilem sane detexi. Hanc marginis exiguitas non caperet."
y para colmo al alba me debo batir a duelo con Pescheux d’Herbinville , y no llego a escribir los en detalle scripts ... "je n'ai pas le temps"


## Presentacion

* Podría ser una solución piola usar los radar plot para visualizar el perfil de cada cluster tomando la medida de cada variable.
* es un uso y costumbre asignarle un nombre significativo a los clusters
* algunas presentaciones muy buenas de marketing, hasta buscan una imagen de una persona representativa de ese cluster ( edad, sexo, vestimenta, lugar donde se encuentra, acciones que esta haciendo )