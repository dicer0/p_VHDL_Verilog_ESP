//TLD: Parpadeo Led
module parpadeoLedTLD(
	 //Declaramos como entradas y salidas solo los pines que salgan del diagrama de bloques global en mi TLD, esto 
	 //se ve en el documento 8.1.-Senal de reloj CLK en Verilog o VHDL.
    input clk,
    input rst,
    output led_out
    );

	//wire: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
	//existe durante la ejecucion del codigo y sirve para poder usar algun valor internamente sin tener que estarlo 
	//actualizando como los datos tipo reg.
	wire alambre_int;

	//INSTANCIAS:
	//Debo darle un nombre a cada instancia que cree, indicar el nombre del modulo que quiero instanciar y dentro de 
	//un parentesis asignarle a todas las entradas y salidas del modulo instanciado una entrada, salida o wire de este 
	//modulo separadas por comas una de la otra, esto hara que lo que entre o salga del otro modulo, entre, salga o se 
	//guarde en este. La sintaxis que debemos usar es la siguiente:
	
	//Nombre_Del_Modulo_Que_Queremos_Instanciar		NombreInstancia  		(
	//		.Nombre_De_La_Entrada_Del_Modulo_Instanciado(Entrada_En_Este_Modulo),
	//		.Nombre_De_La_Salida_Del_Modulo_Instanciado(Salida_En_Este_Modulo),
	
	//		.Nombre_De_La_Entrada_Del_Modulo_Instanciado(Salida_En_Este_Modulo),
	//		.Nombre_De_La_Salida_Del_Modulo_Instanciado(Entrada_En_Este_Modulo),
	
	//		.Nombre_De_La_Entrada_Del_Modulo_Instanciado(Signal_En_Este_Modulo),
	//		.Nombre_De_La_Salida_Del_Modulo_Instanciado(Signal_En_Este_Modulo)
	//);
	
	//INSTANCIA DEL MODULO divisorDeReloj
	divisorDeReloj Divisor_frec(
			.clkNexys2(clk),
			.Reset(rst),
			.salidaReloj(alambre_int)
		);
	
	//INSTANCIA DEL MODULO encenderApagarLed
	endenderApagarLed LED(
			.entrada(alambre_int),
			.salida(led_out)
		);
endmodule
