//2.-MAQUINA DE ESTADO FINITO TIPO MOORE: Las FSM (Finite State Machines) estan conformadas de 
//entradas, transiciones y estados, donde cada estado tiene asignada una o varias salidas. Este tipo 
//de programacion es excelente para detectar o ejecutar secuencias, todo siguiendo el paso de la 
//senal de reloj CLK. En la maquina de Moore sus salidas se generan solo cuando se alcanza un estado 
//especfico, por lo que su velocidad es mas lenta, eso es bueno cuando la secuencia es ingresada 
//manualmente, pero no cuando se ingresa por medios digitales, ya que la velocidad de la entrada 
//supera la de la deteccion.
//El estado se refiere a un concepto abstracto que indica como una FSM reacciona automaticamente 
//a una secuencia de entradas segun un flujo prestablecido. Donde un mismo sistema, si se 
//encuentra en diferente estado, podra reaccionar de forma distinta a una misma entrada.
module fsmMoore(
	 input clk, 	//Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
	 input boton, 	//Boton presionado para detectar la secuencia de 1011.
	 //Las salidas usadas dentro de un condicional o bucle las debo declarar como reg.
	 output reg ledSecuencia, 	//Led que indica cuando la secuencia se ha completado.
	 output reg [3:0] ledPasos	//Leds que indican los pasos de la secuencia.
	 );

	//PAREMETER: Con esta instruccion se crea una constante numerica global a traves de la siguiente 
	//nomenclatura:
	//parameter 	nombreConstanteGlobal	=	valor;
	//En Verilog con esta instruccion se declaran los estados de la FSM, porque estos deben estar 
	//asociados a fuerza a un numero binario, mostrado y nombrado dentro del diagrama de estados
	//del codigo importado del software Aldec, posteriormente para mandar a llamar estas constantes se
	//debe cambiar la siguiente instruccion del tipo de dato define al del parameter:
	//`nombreConstanteGlobal se cambia por solamente nombreConstanteGlobal.
	//Es importante mencionar que en el programa de Aldec estos estados ya tienen asignada una numeracion,
	//esta no debe ser cambiada, sino replicada y transformada a tipo parameter.
	parameter unoCero = 3'b000;			//Estado: unoCero 		= numero binario 000 = 0 decimal.
	parameter unoCeroUno = 3'b001; 		//Estado: unoCeroUno 	= numero binario 001 = 1 decimal.
	parameter unoCeroUnoUno = 3'b010;	//Estado: unoCeroUnoUno = numero binario 010 = 2 decimal.
	parameter Inicio = 3'b011;				//Estado: Inicio 			= numero binario 011 = 3 decimal.
	parameter uno = 3'b100;					//Estado: unoCeroUnoUno = numero binario 100 = 4 decimal.
	
	//REG: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la 
	//NEXYS 2, solo existe durante la ejecucion del codigo y sirve para poder almacenar algun valor de 
	//forma temporal, se declara dentro del modulo y antes de los always que ejecutan condicionales o 
	//bucles, a traves de la siguiente nomenclatura:
	//reg		nombreVariable		=	valor;
	//En Verilog con esta instruccion se guarda el estadoPresente y estadoFuturo de la maquina de 
	//estados, cabe mencionar que dentro del codigo proporcionado por el diagrama de estados de Aldec, el 
	//estado presente es nombrado como CurrState_Sreg0 y el futuro como NextState_Sreg0, ademas es 
	//importante mencionar que su tamano debe coincidir con el tamano de la numeracion de los estados
	//declarados previamente de tipo parameter.
	reg [2:0] estadoPresente;
	reg [2:0] estadoFuturo;
	//Divisor de Reloj: Este reg sirve para que podamos obtener una gran gama de frecuencias indicadas 
	//en la tabla del divisor de reloj, dependiendo de la coordenada que elijamos tomar del vector.
	reg [24:0] clkdiv;
	//Antirrebotes: Una de las aplicaciones del registro de corrimiento, que es resultado de una 
	//conexion en serie de varios flip flops (usualmente de Tipo D), donde simplemente se conecta
	//la entrada de un FF tipo D a la salida de otro siguiendo el paso marcado de una misma senal 
	//de reloj, es la del codigo antirrebotes, que sirve para crear un pequeno retraso de tiempo en
	//el programa, que deje pasar las falsas pulsaciones que se producen al presionar un boton.
	//El retraso en tiempo del antirrebotes estara sujeto a la frecuencia de la senal de reloj, ya que 
	//cada que se perciba un flanco de subida, con el diferente numero de delays, se estara esperando el 
	//tiempo calculado con la siguiente ecuacion:
	//t_delay = periodoReloj * (#signals_delay - (1/2))
	//t_delay = 1/frecuenciaReloj * (#signals_delay - (1/2))
	//frecuenciaReloj = 1/t_delay * (#signals_delay - (1/2))
	reg delay_1;
	reg delay_2;
	reg botonDebounce;	//Entrada del boton ya con el delay antirrebotes anadido.
	
	//Primero que nada, se anade el proceso del divisor de reloj, este no viene incluido en el codigo 
	//de Aldec. Se puede nombrar los always de la siguiente manera:
	//always@(entradas y signals separadas por la palabra reservada or) begin : nombreAlways
	//POSEDGE: La instruccion posedge() solo puede tener una entrada o reg dentro de su parentesis y a 
	//fuerza se debe declarar en el parentesis del always@(), ademas hace que los condicionales o bucles 
	//que esten dentro del always@() se ejecuten por si solos cuando ocurra un flanco de subida en la 
	//entrada que tiene el posedge() dentro de su parentesis. El flanco de subida ocurre cuando la 
	//entrada pasa de valer 0 logico a valer 1 logico y el hecho de que la instruccion posedge() haga 
	//que el codigo se ejecute por si solo significa que yo directamente no debo indicarlo con una 
	//operacion logica en el parentesis de los condicionales o bucles, si lo hago me dara error, aunque 
	//si quiero que se ejecute una accion en especfico cuando se de el flanco de subida en solo una de 
	//las entradas que usan posedge(), debo meter el nombre de dicha entrada en el parentesis de un 
	//condicional o bucle. Tambien si uso un posedge, todas las entradas deben ser activadas por ello.
	always@(posedge(clk)) begin : divisorDeReloj
		if(clk) begin
			clkdiv = clkdiv + 1;
		end
	end
	
	//Luego se anade el proceso del antirrebotes, este tampoco viene incluido en el codigo de Aldec.
	always@(posedge(clkdiv[17])) begin : antirrebotesBoton
		if(clkdiv[17]) begin
			//La instruccion posedge() hace que este condicional solo se ejecute cuando ocurra un flanco 
			//de subida en la senal del divisor de reloj clkdiv, en este caso esa accion es que se trasladen 
			//los datos de la entrada a la salida del registro, pero como pasa a traves de varias signal, esto 
			//es lo que ocasionara el retraso en tiempo, que genera el delay del antirrebotes, para obtener un
			//delay de antirrebotes de 8 milisegundos, que es lo suficientemente rapido para identificar una 
			//secuencia introducida manualmente usando una FSM tipo Moore; la frecuencia de la senal de reloj 
			//debe ser de 187.5 Hz.
			//frecuenciaReloj = 1/t_delay * (#signals_delay - (1/2)) = 1/0.008 * (2 - (1/2)) = 187.5 Hz.
			//La que mas se le acerca es la posicion 17 del divisor de reloj cuya frecuencia es f = 190.73 Hz.
			//En el caso del antirrebotes, al momento de hacer la asignacion de valores se debe usar el 
			//simbolo <= en vez del =, esto se realiza porque:
			//		Asignacion sincrona bloqueante (=): Con este simbolo la asignacion del valor se realiza 
			//		siguiendo el orden del codigo de forma sincrona.
			//		Asignacion sincrona no bloqueante (<=): Con este simbolo la asignacion del valor se hace 
			//		al inicio del ciclo de reloj, sin importar el orden en el que aparece en el codigo.
			//El operador no bloqueante se debe usar en el antirrebotes porque sino el programa no puede
			//ejecutar esta parte del codigo a tiempo en Verilog.
			delay_1 <= boton;
			delay_2 <= delay_1;
		end
		//Con el simbolo & se concatenan los valores de cada delay.
		botonDebounce <= delay_1 & delay_2;
	end
	
	//Las partes necesarias para implementar el codigo de una FSM son las siguientes:
	//Actualizacion del estado presente y futuro: En esta parte del codigo que se ejecuta cada que se 
	//perciba un flanco de subida en la senal de reloj, continuamente se asigna el valor del estado 
	//futuro al estado presente, para de esa forma actualizarlo.
	//La frecuencia ideal para identificar la secuencia en una FSM tipo Moore esta en la coordenada 
	//23 = 2.98Hz = 0.335 seg.
	//Esta parte a veces viene incluida hasta abajo del codigo proporcionado por Aldec, pero debe ser 
	//modificado para funcionar a traves de la senal del divisor de reloj.
	always@(posedge(clkdiv[23])) begin : actualizacionDeEstado
		if(clkdiv[23]) begin
			estadoPresente = estadoFuturo;
		end
	end
	
	//Logica de la maquina de estados: A traves de esta parte se lleva a cabo la funcion de la 
	//FSM, donde dependiendo de su tipo, ya sea Mealy o Moore, sus salidas se asignan a las transiciones 
	//de un estado a otro o al estado en si. Cabe mencionar que siempre que se cree una nueva FSM, esta 
	//es la parte que debera ser reemplazada en el codigo, lo demas se puede quedar igual y funcionaria de 
	//maravilla, pero hay que tener en cuenta cambiar el nombre de la entrada por el reg del antirrebotes, 
	//cambiar el nombre de CurrState_Sreg0 por estadoPresente y NextState_Sreg0 por el reg estadoFuturo y 
	//quitar la comilla que aparece antes del nombre de cada estado, ya que en el codigo original de Aldec
	//en Verilog, estos se declaran de tipo `define, no como parameter. 
	//Ademas, deberemos cambiar el nombre de los nuevos estados en la parte de arriba, en los paramater.
	//Aqui a traves de condicionales if y case se declaran los estados, entradas y transiciones.
	always @ (boton or estadoPresente) begin : maquinaDeEstados
		//Condiciones iniciales de la maquina de estados:
		estadoFuturo = estadoPresente;
		ledSecuencia = 1'b0;
		ledPasos = 4'b0000;
		//Condicional case: Lee el valor de la variable estado presente y dentro del case describe lo 
		//que hace cada estado.
		//FSM tipo Moore: LAS SALIDAS se declaran en LOS ESTADOS que describen los case.
		case(estadoPresente)
			unoCero:
			begin
				//SALIDAS DEL ESTADO unoCero:
				ledSecuencia = 1'b0;
				ledPasos = 4'b0100;
				//TRANSICIONES DEL ESTADO unoCero:
				case (botonDebounce)
					1'b1 :
						estadoFuturo = unoCeroUno;		//Transicion a unoCeroUno: Cuando la entrada boton = 0.
					1'b0 :
						estadoFuturo = unoCero;			//Transicion a unoCero: Cuando la entrada boton = 0.
				endcase
			end
			unoCeroUno:
			begin
				//SALIDAS DEL ESTADO unoCeroUno:
				ledSecuencia = 1'b0;
				ledPasos = 4'b0010;
				//TRANSICIONES DEL ESTADO unoCeroUno:
				case (botonDebounce)
					1'b0 :
						estadoFuturo = Inicio;			//Transicion a Inicio: Cuando la entrada boton = 0.
					1'b1 :
						estadoFuturo = unoCeroUnoUno;	//Transicion a unoCeroUnoUno: Cuando la entrada boton = 1.
				endcase
			end
			unoCeroUnoUno:
			begin
				//SALIDAS DEL ESTADO unoCeroUnoUno:
				ledSecuencia = 1'b1;
				ledPasos = 4'b0001;
				//TRANSICIONES DEL ESTADO unoCeroUnoUno:
				case (botonDebounce)
					1'b1 :
						estadoFuturo = Inicio;			//Transicion a Inicio: Cuando la entrada boton = 1.
					1'b0 :
						estadoFuturo = Inicio;			//Transicion a Inicio: Cuando la entrada boton = 0.
				endcase
			end
			Inicio:
			begin
				//SALIDAS DEL ESTADO Inicio:
				ledSecuencia = 1'b0;
				ledPasos = 4'b0000;
				//TRANSICIONES DEL ESTADO Inicio:
				case (botonDebounce)
					1'b1 :
						estadoFuturo = uno;				//Transicion a uno: Cuando la entrada boton = 1.
					1'b0 :
						estadoFuturo = Inicio;			//Transicion a Inicio: Cuando la entrada boton = 0.
				endcase
			end
			uno:
			begin
				//SALIDAS DEL ESTADO uno:
				ledSecuencia = 1'b0;
				ledPasos = 4'b1000;
				//TRANSICIONES DEL ESTADO uno:
				case (botonDebounce)
					1'b0 :
						estadoFuturo = unoCero;			//Transicion a unoCero: Cuando la entrada boton = 0.
					1'b1 :
						estadoFuturo = Inicio;			//Transicion a Inicio: Cuando la entrada boton = 1.
				endcase
			end
		endcase
	end
	//Fin de la logica de la maquina de estados.
endmodule