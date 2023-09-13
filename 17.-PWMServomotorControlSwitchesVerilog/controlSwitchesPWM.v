//SENAL PWM CON FRECUENCIA DE 50HZ PARA CONTROL DE SERVOMOTOR:
//Este proceso sirve para primero crear un divisor de reloj, donde se puede dictar al reloj en que frecuencia 
//quiero que opere el servomotor, indicando asi su velocidad de rotacion, en este mismo proceso del divisor de reloj 
//se crea un contador que creara la frecuencia de 50 Hz para la senal PWM, despues lo que se hace es usar ese reloj 
//modificado para monitorear los switches del selector y asi seleccionar una posicion, a donde el servomotor se ira
//y mantendra su posicion hasta que cense que haya ocurrido un cambio, siempre y cuando el valor del selector sea 
//distinto de cero.

module controlSwitchesPWM(
    input relojNexys2,		//Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
    input rst,       		//Boton de reset.
	 input [5:0] selectPos,	//6 switches para elegir una posicion de 30, 60, 90, 120, 150 o 180 grados.
	 //Las salidas usadas dentro de un condicional o bucle se declaran como reg.
	 output reg [5:0] ledAngulo,
    output reg PWM 	  		//Reloj que quiero con una frecuencia menor a 50MHz.
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
	//estos pulsos, puede tener un tiempo de espera antes de mandar el otro y eso es lo que dicta la velocidad de 
	//rotacion que lleva al llegar de una posicion a otra. 
	//El valor del conteo se obtiene al dividir el periodo de 20ms sobre el periodo de la senal de 50MHz proveniente del 
	//reloj de la Nexys 2: T50Mz = 1/50,000,000 = 20e-9s = 20ns. Por lo tanto, al realizar la operacion se obtiene que:
	//T50Hz = 0.02s = 2ms; T50Mz = 20e-9s = 20ns; ConteoFrecuenciaPWM = T50Hz/T50Mz = 2ms/20ns = 2e-3/2e-9 = 1,000,000.
	//AL realizar la calibracion, el valor real de los pasos para alcanzar la posicion 0 grados es de = 27000.
	integer posicion0Grados = 26000; //Integer que dicta los pasos para situar el eje del motor en 0 grados.
	//Variable asignada al integer conteoFrecuenciaPWM para situar el estado alto de la senal PWM en 1ms, posicionando al 
	//motor en una posicion de 0 grados inicialmente.
	integer movServo = 0; 				//Integer que dicta los pasos que debe dar el motor para llegar a una posicion.
	//EL valor del integer movServo sera modificado dependiendo del valor ingresado por los switches del vector 
	//conteoFrecuenciaPWM, para asi situar el eje del motor en una posicion especifica y dejarlo ahi, para ello la 
	//variable selectorDutyCycle solo puede abarcar 1 valor.
	

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
	//reloj y asignara cierta velocidad de respuesta al control de movimiento por medio de switches.
	always@(posedge(divisorDeReloj[12])) 
	begin : highDutyCyclePWM //El nombre del always@() es highDutyCyclePWM.
		//Cuando el valor del selector sea distinto de cero, vera cual es la posicion que le corresponde y la asignara 
		//a la variable movServo, que movera el servomotor a la posicion de 30, 60, 90, 120, 150 o 180 grados.
		if(selectPos != 6'b000000) begin
			case(selectPos)//CASE se usa para evaluar los diferentes valores de la variable que tenga en su parentesis
				//Los switches del selector se levantan para que el integer movimientoServo adopte diferentes numeros 
				//que muevan el servomotor a todas las posibles posiciones, que son las siguientes:
				6'b000001 : begin 
					movServo = 12329; //Bit menos significativo del selector = 12,329 = 30 grados.
					ledAngulo = 6'b000001;
				end
				6'b000010 : begin 
					movServo = 26419; //Bit 2 del selector = movServo = 26,419 = 60 grados.
					ledAngulo = 6'b000010;
				end
				6'b000100 : begin 
					movServo = 41868; //Bit 3 del selector = movServo = 41,868 = 90 grados.
					ledAngulo = 6'b000100;
				end
				6'b001000 : begin
					movServo = 57774; //Bit 4 del selector = movServo = 57,774 = 120 grados.
					ledAngulo = 6'b001000;
				end
				6'b010000 : begin
					movServo = 75633; //Bit 5 del selector = movServo = 75,633 = 150 grados.
					ledAngulo = 6'b010000;
				end
				6'b100000 : begin
					movServo = 92109; //Bit mas significativo del selector = 92,109 = 180 grados.
					ledAngulo = 6'b100000;
				end
				//Si no se ha seleccionado nada o se mete con los switches cualquier otra cosa, el servomotor se 
				//mueve a su posicion inicial.
				default: begin
					movServo = 0;
					ledAngulo = 6'b000000;
				end
			endcase
		end
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
	always@(conteoFrecuenciaPWM, posicion0Grados, movServo)
	begin : pwmSignal //El nombre del always@() es pwmSignal.
		if(conteoFrecuenciaPWM <= (posicion0Grados + movServo)) begin
			PWM = 1'b1;
		end else begin
			PWM = 1'b0;
		end
	end
endmodule
