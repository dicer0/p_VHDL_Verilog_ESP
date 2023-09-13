//SENAL PWM CON FRECUENCIA DE 50HZ PARA CONTROL DE SERVOMOTOR:
//Este proceso sirve para primero crear un divisor de reloj, donde se puede dictar al reloj en que frecuencia 
//quiero que opere el servomotor, indicando asi su velocidad de rotacion, en este mismo proceso del divisor de reloj 
//se crea un contador que creara la frecuencia de 50 Hz para la senal PWM, despues lo que se hace es usar ese reloj 
//modificado para crear otro contador que declare los pasos del estado en alto de la senal PWM, que durara de 1 a 2 ms 
//para asi mover el servomotor hacia varias posiciones donde debe parar durante una secuencia, que abarca posiciones de 
//0 a 180 grados.

module divisorDeRelojPWM(
    input relojNexys2,	//Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
    input rst,       	//Boton de reset.
	 //Las salidas usadas dentro de un condicional o bucle se declaran como reg.
    output reg PWM 	  	//Reloj que quiero con una frecuencia menor a 50MHz.
    );

	//REG: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo sirve 
	//para almacenar y usar valores que sobreviviran durante la ejecucion del codigo y que ademas se deben usar dentro de 
	//un condicional o bucle.
	reg [25:0]divisorDeReloj;			//Vector con el que se obtiene el divisor de reloj.
	//Este reg sirve para que podamos obtener una gran gama de frecuencias indicadas en la tabla del divisor de reloj,
	//dependiendo de la coordenada que elijamos tomar del vector, para asignarsela al contador que dicta la velocidad del 
	//servomotor cuando va de una posicion a otra.
	integer conteoFrecuenciaPWM = 1;	//Integer para el contador de uno a 1,000,000.
	//Variable que obtiene un conteo para obtener la senal de 50 Hz que manda pulsos al servomotor con el fin de que 
	//llegue a posiciones de 0 a 180 grados, esta tiene un periodo de T = 1/50 = 0.02s = 2ms, aunque despues de mandar 
	//estos pulsos, puede tener un tiempo de espera antes de mandar el otro y eso es lo que dicta la velocidad de rotacion 
	//que lleva al llegar de una posicion a otra. 
	//El valor del conteo se obtiene al dividir el periodo de 20ms sobre el periodo de la senal de 50MHz proveniente del 
	//reloj de la Nexys 2: T50Mz = 1/50,000,000 = 20e-9s = 20ns. Por lo tanto, al realizar la operacion se obtiene que:
	//T50Hz = 0.02s = 2ms; T50Mz = 20e-9s = 20ns; ConteoFrecuenciaPWM = T50Hz/T50Mz = 2ms/20ns = 2e-3/2e-9 = 1,000,000.
	integer selectorDutyCycle = 1;	//Integer para el selector de posiciones de la senal PWM.
	//La signal selectorDutyCycle cuenta de 0 a 2 porque crea una secuencia de 3 posiciones para el servomotor, que en este 
	//caso lo posiciona en 0, 90 y 180 grados consecutivamente, haciendo avanzar el estado en alto de la senal PWM de 1ms 
	//a 1.5ms y finalmente a 2ms.
	integer DutyCycle_1a2ms;			//Integer para crear el pulso en alto para la secuencia de 1 a 2ms.
	//Guarda el valor del contador selectorDutyCycle que creara una secuencia de posiciones y lo multiplica por cierto 
	//numero de pasos, que en teoria son 50,000 para alcanzar un maximo de 1ms en el estado alto del duty cycle. El numero 
	//de pasos necesario para la multiplicacion se obtiene al dividir el tiempo de duracion del pulso en alto entre el 
	//periodo de la senal de 50MHz obtenida del reloj de la Nexys 2, la operacion es la siguiente:
	//T1ms = 1ms; T50Mz = 20e-9s = 20ns; ConteoDutyCycleEnAlto = T1ms /T50Mz = 1e-3/2e-9 = 50,000.

	//POSEDGE: La instruccion posedge() solo puede tener una entrada o reg dentro de su parentesis y a fuerza se debe 
	//declarar en el parentesis del always@(), ademas hace que los condicionales o bucles que esten dentro del always@() 
	//se ejecuten por si solos cuando ocurra un flanco de subida en la entrada que tiene posedge() dentro de su 
	//parentesis, el flanco de subida ocurre cuando la entrada pasa de valer 0 logico a valer 1 logico y el hecho de 
	//que la instruccion posedge() haga que el codigo se ejecute por si solo, significa que yo directamente no debo 
	//indicarlo con una operacion logica en el parentesis de los condicionales o bucles, si lo hago me dara error, 
	//aunque si quiero que se ejecute una accion en especifico cuando se de el flanco de subida en solo una de las 
	//entradas que usan posedge(), debo meter el nombre de esa entrada en el parentesis del condicional o bucle. 
	//Si uso posedge() en el parentesis de un always@(), todas las entradas de ese always@() deben ser activadas igual 
	//por un posedge().
	always@(posedge(relojNexys2), posedge(rst))
	begin : clkdiv //El nombre del always@() es clkdiv.
		if(rst) begin
			//En VHDL se puede declarar a un numero hexadecimal para evitar poner muchos bits de un numero binario grande,
			//pero en Verilog si hago esto el programa se confunde en el tipo de dato que esta recibiendo y como 
			//consecuencia obtendremos un error.
			divisorDeReloj = 26'b00000000000000000000000000;
		end else if(conteoFrecuenciaPWM > 1000000) begin
			conteoFrecuenciaPWM = 1;
		end else begin
			divisorDeReloj = divisorDeReloj + 1;				//Esto crea al divisor de reloj.
			conteoFrecuenciaPWM = conteoFrecuenciaPWM + 1;	//Esto crea la frecuencia de 50 Hz para la senal PWM.
		end
	end
	
	//Debo asignar el contenido de una coordenada de la signal divisorDeReloj a salidaReloj para obtener una 
	//frecuencia en especifico, cada coordenada del vector corresponde a una frecuencia en la tabla del divisor de 
	//reloj y asignara cierta velocidad de rotacion al servomotor cuando se dirige de una posicion a otra.
	//El servomotor SG90 (chiquito azul) puede recibir una frecuencia minima de 0.4 Hz y maxima de 2.8Hz, esto nos da 
	//la posibilidad de elegir de la coordenada 24 (1.49 Hz) a la coordenada 26 (0.3725 Hz) que ya no esta incluida en 
	//la tabla del divisor de reloj. La frecuencia minima no esta tan definida, puede ser la que sea, aqui esta limitada 
	//por la tabla del divisor.
	always@(posedge(divisorDeReloj[24]))
	begin : highDutyCyclePWM //El nombre del always@() es highDutyCyclePWM.
		//La instruccion rising_edge() hace que este condicional solo se ejecute cuando ocurra un flanco de subida 
		//en la senal del divisorDeReloj en su coordenada 24, que proporciona una frecuencia de 1.49Hz.
		if(selectorDutyCycle == 2) begin
			//Cuando el conteo del duty cycle en estado activo (1 logico), que se da con una frecuencia de 1.49Hz, 
			//valga 2, se reiniciara el conteo, regresando el selector y servomotor a su posicion inicial, ya que en
			//este caso se eligen los tiempos de 0, 0.5 y 1 ms, correspondientes a las posiciones 0, 90 y 180 grados.
			selectorDutyCycle = 0;
		end else begin//Esto se ejecutara cuando no se cumpla la condicion anterior.
			//Crea el conteo del estado en alto de la senal PWM con frecuencia de 50 Hz para que alcance las 
			//duraciones de 1 a 2ms, paulatinamente, creando una secuencia de posiciones que va de 0 a 90 grados, luego 
			//de 90 a 180 y regresa despues a la de 0 grados.
			selectorDutyCycle = selectorDutyCycle + 1;
		end
		//Con la variable DutyCycle_1a2ms se realiza el avance del pulso en la senal PWM de 1 a 2ms de forma paulatina, 
		//creando la secuencia de posiciones, esto se hace multiplicando el numero del selector por un numero de pasos, 
		//para ello se toma en cuenta que el numero de pasos necesario para la multiplicacion se obtiene al dividir el 
		//tiempo de duracion del pulso en alto entre el periodo de la senal de 50MHz obtenida del reloj de la Nexys 2, la 
		//operacion es la siguiente:
		//T1ms = 1ms; T50Mz = 20e-9s = 20ns; ConteoDutyCycleEnAlto = T1ms /T50Mz = 1e-3/2e-9 = 50,000.
		//Esta es la teoria, pero los pasos del servomotor no siempre siguen esto al pie de la letra, por lo que se debe 
		//calibrar el servomotor, viendo por cada numero de pasos, la posicion que alcanza.
		//AL REALIZAR LA CALIBRACION DEL SERVOMOTOR SE OBTIENE LO SIGUIENTE:
		//El servomotor SG90 (chiquito azul) realiza un giro de 0 a 180 grados con un paso de 92,109.
		//El servomotor SG90 (chiquito azul) realiza un giro de 0, 90 y 180 grados con un paso de 41,868.
		//Al realizar la operacion de 92109/2 = 46054, podemos ver que las posiciones no son completamente lineales, o
		//al menos no tienen una pendiente de m = 1.
		//Este es un codigo de ejemplo, pero si en verdad se quisiera hacer una secuencia con un control super preciso 
		//Se tendria que ver el paso exacto que se debe dar para cada posicion y luego crear un bucle case que lleve a 
		//cada posicion dicha secuencia.
		DutyCycle_1a2ms = 46054 * selectorDutyCycle ; //25,000*0 = 0ms; 25,000*1 = 0.5ms; 25,000*2 = 50,000 = 1ms;
		//Se debe tomar en cuenta que, al realizar diferentes secuencias, se debe cambiar de igual manera el numero de 
		//pasos, dividiendo el numero de pasos que llega de 0 a 180 grados, osea 89,550, entre el numero de acciones 
		//de la secuencia, considerando ademas que, al terminar la secuencia, el motor vuelve a su posicion inicial de 
		//0 grados.
	end
	
	//Para mantener el estado alto de la senal PWM de 1 a 2 ms con el fin de mover el servomotor de 0 a 180 grados, se 
	//debe realizar un conteo como el que se realizo para crear la frecuencia de 50 Hz en la senal PWM, para ello se 
	//realiza el siguiente calculo:
	//T1ms = 1ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1ms/20ns   = 1e-3/20e-9   = 50,000;  0 grados servo.
	//T1ms = 1.5ms; T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1.5ms/20ns = 1.5e-3/20e-9 = 75,000;  90 grados servo.
	//T1ms = 2ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 2ms/20ns   = 2e-3/20e-9   = 100,000; 180 grados servo.
	//Con este calculo podemos saber que, para que el pulso en alto abarque un rango inicial de 1ms se debe usar 50e3 
	//pasos, a este ancho inicial de pulso se le debe sumar el valor de la signal DutyCycle_1a2ms para que el pulso 
	//paulatinamente vaya aumentando de 1 a 2ms, creando asi la secuencia que va a las posiciones 0, 90 y 180 grados.
	//Pero recordemos que esta es la teoria, para alcanzar dichas posiciones se debe realizar una calibracion, donde 
	//veremos el numero de pasos reales para alcanzar cada posicion.
	//AL REALIZAR LA CALIBRACION DEL SERVOMOTOR SE OBTIENE LO SIGUIENTE:
	//El servomotor SG90 alcanza un rango de 1ms con un paso inicial de 26e3.
	always@(conteoFrecuenciaPWM, DutyCycle_1a2ms)
	begin : pwmSignal //El nombre del always@() es pwmSignal.
		if(conteoFrecuenciaPWM <= (26000 + DutyCycle_1a2ms)) begin
			PWM = 1'b1;
		end else begin
			PWM = 1'b0;
		end
	end
endmodule
