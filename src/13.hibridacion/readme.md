script para hacer hibridacion de semillerios, que consiste en combinar dos modelos de semillerios

intenten combinar semillerios robustos de 200 semillas cada uno
en el script muestro como se combinan un semillerio de 200 y otro de 70 semillas, unicamente con fines pedegógicos y por si alguien salta a decir "pero me quedan pocas horas, tengo un datase de 999 variables y no voy a llegar a las 200 semillas, estoy desesperado, ¿qué hago profesor?"
la hibridacion es simplemente un experimento más, que hay que correr y comparar con lo que ya se tiene. No hay garantia que la hibridación sea siempre superior.
la hibridacion necesita 8GB de RAM y 2 vCPU, y corre en 15 segundos
https://github.com/dmecoyfin/dmeyf/tree/master/src/hibridacion

------------------------

Gustavo Denicolay12:29
No lloren más.
Escribí el script de hibridación de cero, hibridando dos modelos, el único experimento de hibridación que he hecho fue buscando los dos ultimos experimentos no fallidos que tenia:

el de las 200 semillas estaba en la posicion 26 del actual Private ( este era uno solo con las 159 variables originales del dataset )
el de las 70 semillas estaba en al posicion 15 del actual Private ( este era uno donde intencionalmente habia fijado el feature_fractrion en 0.50 para solo tener tres hiperparámetros en la B.O. )
el hibrido queda en posición 1 del Private.
pido discupas por no haber tenido mas tiempo para probar más que un solo experimento.
¿Que prentenden de mi? ¿Que escriba una tesis sobre hibridación de semillerios de aca al miercoles a la noche?


-----------------------

si ambos tienen 200 semillas , pone 200 a ambos

si, se estan pesando
si, para nuestro ranking es lo mismo hacer
a + b
200a + 200b