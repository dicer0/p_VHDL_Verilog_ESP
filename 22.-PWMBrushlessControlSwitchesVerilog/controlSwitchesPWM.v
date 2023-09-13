//Control de velocidad de un motor brushless (BLDC) por medio de codigo, pero calibrando el porcentaje del duty cycle 
//de la senal PWM para adaptarla al motor sin escobillas: Para la conexion de este motor se usa un controlador 
//externo llamado ESC (Electronic Speed Controller), el cual es alimentado por una batera LiPo, misma que puede 
//alimentar dispositivos externos a traves del cable rojo del ESC llamado BEC (Battery ELiminator Controller) por medio 
//de su pin de 5V y GND, a la tierra del ESC igual se conectara el pin GND de la Nexys 2 y a traves del puerto JA1 se 
//controlara su velocidad de rotacion, por medio de una senal PWM con frecuencia de 50 Hz, que varie su duty cycle de 
//1 a 2ms. El control del BLDC es identico al del servomotor, pero la unica diferencia es que esa senal PWM controla la 
//posicion de 0 a 180 y la de este tipo de motor controla la velocidad de giro, pero su funcionamiento es el mismo, solo 
//que se debe calibrar.
//------------------------------------------------------------------------------------------------
//Motor brushless MT2204 que se alimenta con bateras LiPo de 2 a 3S, cuenta con una KV = 2300, por lo que el rango de 
//velocidades que abarca como maximo, alimentandolo con una batera de 3S es de:
//0 a KV * V_ESC [rpm] = 2300 * 3.7 * 3S = 25,530 [rpm].
//La cual es controlada por una senal PWM (Pulse Width Module) con una frecuencia de 50 Hz (20 [ms]).
//------------------------------------------------------------------------------------------------
//Motor brushless A2212 que se alimenta con bateras LiPo de 2 a 3S, cuenta con una KV = 1400, por lo que el rango de 
//velocidades que abarca como maximo, alimentandolo con una batera de 3S es de:
//0 a KV * V_ESC [rpm] = 1400 * 3.7 * 3S = 15,540 [rpm].
//La cual es controlada por una senal PWM (Pulse Width Module) con una frecuencia de 50 Hz (20 [ms]).

module controlSwitchesPWM(
    input relojNexys2,		//Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
    input rst,       		//Boton de reset.
	 input [2:0] selectPos,	//3 switches para elegir una velocidad de 0, media y maxima.
	 //Las salidas usadas dentro de un condicional o bucle se declaran como reg.
	 output reg [2:0] ledAngulo,
    output reg PWM 	  		//Reloj que quiero con una frecuencia menor a 50MHz.
    );

	//REG: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo sirve 
	//para almacenar y usar valores que sobreviviran durante la ejecucion del codigo y que ademas se deben usar dentro de 
	//un condicional o bucle.
	reg [25:0]divisorDeReloj;			//Vector con el que se obtiene el divisor de reloj.
	//Este reg sirve para que podamos obtener una gran gama de frecuencias indicadas en la tabla del divisor de reloj,
	//dependiendo de la coordenada que elijamos tomar del vector, se asignara al contador que dicta la velocidad del 
	//motor brushless para que se cree una secuencia entre dos o mas velocidades distintas.
	integer conteoFrecuenciaPWM = 1;	//Integer para el contador de uno a 1,000,000.
	//Variable que obtiene un conteo para obtener la senal de 50 Hz que manda pulsos al motor brushless con el fin de que 
	//llegue a velocidades de 0 a KV * V_ESC [rpm], esta tiene un periodo de T = 1/50 = 0.02s = 2ms.
	//El valor del conteo se obtiene al dividir el periodo de 20ms sobre el periodo de la senal de 50MHz proveniente del 
	//reloj de la Nexys 2: T50Mz = 1/50,000,000 = 20e-9s = 20ns. Por lo tanto, al realizar la operacion se obtiene que:
	//T50Hz = 0.02s = 2ms; T50Mz = 20e-9s = 20ns; ConteoFrecuenciaPWM = T50Hz/T50Mz = 2ms/20ns = 2e-3/2e-9 = 1,000,000.
	//AL realizar la calibracion, el valor real de los pasos para alcanzar la posicion 0 grados es de = 57000.
	integer posicion0Grados = 57000; //Integer que dicta los pasos para situar el eje del motor en 0 grados.
	//Variable asignada al integer conteoFrecuenciaPWM para situar el estado alto de la senal PWM en 1ms, posicionando al 
	//motor en una posicion de 0 grados inicialmente.
	integer movServo = 0; 				//Integer que dicta los pasos que debe dar el motor para llegar a una velocidad.
	//El valor del integer movServo sera modificado dependiendo del valor ingresado por los switches del vector 
	//conteoFrecuenciaPWM, para asi hacer girar el eje del motor a una velocidad especifica, para ello la variable 
	//selectorDutyCycle solo puede abarcar 1 valor.
	

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
	//reloj y asignara cierta velocidad de respuesta al control de velocidad por medio de switches.
	always@(posedge(divisorDeReloj[12])) 
	begin : highDutyCyclePWM //El nombre del always@() es highDutyCyclePWM.
		//Cuando el valor del selector sea distinto de cero, vera cual es la velocidad que le corresponde y la asignara 
		//a la variable movServo, que hara girar al motor en su velocidad 0, media y maxima.
		if(selectPos != 3'b000) begin
			case(selectPos)//CASE se usa para evaluar los diferentes valores de la variable que tenga en su parentesis
				//Los switches del selector se levantan para que el integer movimientoServo adopte diferentes numeros 
				//que muevan el motor sin escobillas a diferentes velocidades, que son las siguientes:
				3'b001 : begin 
					movServo = 0; 		//Bit menos significativo del selector = 0 = velocidad cero.
					ledAngulo = 3'b001;
				end
				3'b010 : begin 
					movServo = 25000; //Bit 2 del selector = movServo = 25,000 = velocidad media.
					ledAngulo = 3'b010;
				end
				3'b100 : begin
					movServo = 50000; //Bit mas significativo del selector = 50,000 = velocidad maxima = 25,530 [rpm].
					ledAngulo = 3'b100;
				end
				//Si no se ha seleccionado nada o se mete con los switches cualquier otra cosa, el BLDC se detiene.
				default: begin
					movServo = 0;
					ledAngulo = 3'b000;
				end
			endcase
		end
	end
	
	//Para mantener el estado alto de la senal PWM de 1 a 2 ms con el fin de mover el servomotor de 0 a 180 grados, se 
	//debe realizar un conteo como el que se realizo para crear la frecuencia de 50 Hz en la senal PWM, para ello se 
	//realiza el siguiente calculo:
	//T1ms = 1ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1ms/20ns   = 1e-3/20e-9   = 50,000;  velocidad 0.
	//T1ms = 1.5ms; T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 1.5ms/20ns = 1.5e-3/20e-9 = 75,000;  velocidad media.
	//T1ms = 2ms; 	 T50Mz = 20e-9s = 20ns; ConteoDutyCycleAlto = 2ms/20ns   = 2e-3/20e-9   = 100,000; velocidad maxima.
	//Con este calculo podemos saber que, para que el pulso en alto abarque un rango inicial de 1ms se debe usar 50e3 
	//pasos, a este ancho inicial de pulso se le debe sumar el valor de la signal DutyCycle_1a2ms para que el pulso 
	//paulatinamente vaya aumentando de 1 a 2ms, creando asi la secuencia de 3 velocidades.
	//Pero recordemos que esta es la teoria, para alcanzar dichas posiciones se debe realizar una calibracion, donde 
	//veremos el numero de pasos reales para alcanzar cada velocidad.
	//AL REALIZAR LA CALIBRACION DEL SERVOMOTOR SE OBTIENE LO SIGUIENTE:
	//El motor sin escobillas MT2204 alcanza un rango de 1ms con un paso inicial de 57e3.
	always@(conteoFrecuenciaPWM, posicion0Grados, movServo)
	begin : pwmSignal //El nombre del always@() es pwmSignal.
		if(conteoFrecuenciaPWM <= (posicion0Grados + movServo)) begin
			PWM = 1'b1;
		end else begin
			PWM = 1'b0;
		end
	end
endmodule
