//Antirrebotes: Una de las aplicaciones del registro de corrimiento, que es resultado de una 
//conexion en serie de varios flip flops (usualmente de Tipo D), donde simplemente se conecta
//la entrada de un FF tipo D a la salida de otro siguiendo el paso marcado de una misma senal 
//de reloj, es la del codigo antirrebotes, que sirve para crear un pequeno retraso de tiempo en
//el programa, que deje pasar las falsas pulsaciones que se producen al presionar un boton.
module shiftRegisterAntirrebotes(
	 input clk, 			//Senal de reloj.
	 input clr, 			//Boton de clr para reiniciar el conteo del debounce.
	 //El codigo de un shift register se codifica como un flip flop tipo D, asignando de 
	 //forma temporal valores de forma directa a signals.
	 input entradaBoton, //Boton que genera los rebotes.
	 output salidaBoton	//Salida sin rebotes.
    );

	//Antes del always pero dentro del modulo es donde se declaran las variables de tipo reg e 
	//integer que no son ni entradas ni salidas, solo existen durante la ejecucion del programa 
	//e interactuan con el condicional o bucle de la instruccion process.
	reg delay_1;
	reg delay_2;
	reg delay_3;
	
	//always@ se usa para poder usar condicionales o bucles y tiene su propio begin y end.
	//POSEDGE: La instruccion posedge() solo puede tener una entrada o reg dentro de su parentesis 
	//y a fuerza se debe declarar en el parentesis del always@(), ademas hace que los condicionales 
	//o bucles que esten dentro del always@() se ejecuten por si solos cuando ocurra un flanco de 
	//subida en la entrada que tiene posedge() dentro de su parentesis, el flanco de subida ocurre 
	//cuando la entrada pasa de valer 0 logico a valer 1 logico y el hecho de que la instruccion 
	//posedge() haga que el codigo se ejecute por si solo significa que yo directamente no debo 
	//indicarlo con una operacion logica en el parentesis de los condicionales o bucles, si lo hago 
	//el programa me arrojara error, aunque si quiero que se ejecute una accion en especifico cuando 
	//se de el flanco de subida en solo una de las entradas que usan posedge(), debo meter el nombre 
	//de esa entrada en el parentesis del condicional o bucle, tambien si uso un posedge, todas las 
	//entradas deben ser activadas igual por un posedge.
	//Si se quisiera ejecutar esta accion con el flanco de bajada de la senal de reloj se debe 
	//usar la instruccion negedge().
	always@(posedge(clk), posedge(clr))
	begin
		if(clr) begin	//Si el boton clr es presionado el conteo del debounce se reinicia.
			delay_1 = 1'b0;
			delay_2 = 1'b0;
			delay_3 = 1'b0;
		end 
		//Cada que ocurra un flanco de subida en el reloj, se trasladaran los datos de entrada a la 
		//salida del registro de corrimiento, pero como pasa a traves de varias signal, esto es 
		//lo que ocasionara el retraso en tiempo, que genera el delay, este tiempo estara sujeto a 
		//la frecuencia de la senal de reloj, ya que cada que se perciba un flanco de subida, con el
		//diferente numero de signals, se estara esperando el tiempo calculado con la sig. ecuacion:
		//t_delay = periodoReloj * (#signals_delay - (1/2))
		//t_delay = 1/frecuenciaReloj * (#signals_delay - (1/2))
		//frecuenciaReloj = 1/t_delay * (#signals_delay - (1/2))
		//Si se quisiera ejecutar esta accion con el flanco de bajada de la senal de reloj se debe 
		//usar la instruccion negedge() dentro del always@() de arriba.
		//En el caso del antirrebotes, al momento de hacer la asignacion de valores se debe usar el 
		//simbolo <= en vez del =, esto se realiza porque:
		//		Asignacion sincrona bloqueante (=): Con este simbolo la asignacion del valor se realiza 
		//		siguiendo el orden del codigo de forma sincrona.
		//		Asignacion sincrona no bloqueante (<=): Con este simbolo la asignacion del valor se hace 
		//		al inicio del ciclo de reloj, sin importar el orden en el que aparece en el codigo.
		//El uso del operador no bloqueante se debe usar en el antirrebotes porque si no al programa 
		//no le da tiempo de ejecutar esta parte del codigo a tiempo en Verilog.
		else begin
			delay_1 <= entradaBoton;
			delay_2 <= delay_1;
			delay_3 <= delay_2;
		end
	end
	//Con el simbolo & se concatenan los valores de cada delay y de esta forma se estara 
	//dejando que pasen #signals_delay-1 = 2 ciclos de reloj para no captar los pulsos falsos al 
	//presionar el boton.
	//Para asignar el valor de un reg a una salida se usa la palabra reservada assign.
	assign salidaBoton = delay_1 & delay_2 & delay_3;
endmodule
