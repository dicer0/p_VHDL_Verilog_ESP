//3.-TLD (Top Level Design) MotorAPasosBipolarPasosTLD:
//Este codigo sirve para unir los 2 modulos anteriores y poder aplicar las 5 configuraciones de pasos a un motor 
//bipolar de tipo NEMA 17, para ello primero se ejecuta un divisorDeReloj, del cual se obtiene la frecuencia con la que 
//se encienden y apagan las 2 bobinas A y B del motor, esto indicara su velocidad por medio del pin STEP, adoptando 
//valores de 1 a 1000 Hz, luego en el modulo controlMotor se indica el sentido de giro usando un switch y mandando ese 
//bit al pin DIR del controlador, despues por medio de switches se elige una secuencia, ya sea de paso completo, 1/2 paso
//1/4 de paso, 1/8 de paso o 1/16 de paso, los 3 bits que sirven para elegir el paso se asignan a los pines de micro 
//stepping MS1, MS2 y MS3, dirigidas al controlador A4988.

module MotorAPasosBipolarPasosTLD(
	 //Declaramos como entradas y salidas solo los pines que salgan del diagrama de bloques global en mi TLD, esto 
	 //se ve en el documento 12.-Motor a Pasos.
	 input clk,
    input rst,
	 input direcc,
	 input [2:0] secuenciaPasos,
    output [2:0] microStepping,
	 output [2:0] ledsMicroStepping,
	 output ledDirecc,
	 output STEP,
	 output dirPin
    );
	
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
			.relojNexys2(clk),
			//La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clk de este modulo.
			.reset(rst),
			//La entrada reset del divisorDeReloj se asigna a la entrada rst de este modulo.
			.salidaReloj(STEP)
			//La salida salidaReloj del divisorDeReloj se asigna a la salida STEP de este modulo.
		);
	
	//INSTANCIA DEL MODULO controlPasosMotor
	controlPasosMotor motorNEMA17(
			.direccionGiro(direcc),
			//La entrada direccionGiro del controlPasosMotor se asigna a la entrada direcc de este modulo.
			.selectPaso(secuenciaPasos),
			//La entrada selectPaso del controlPasosMotor se asigna a la entrada secuenciaPasos de este modulo.
			.MS(microStepping),
			//La salida MS del controlPasosMotor se asigna a la salida microStepping de este modulo.
			.ledMS(ledsMicroStepping),
			//La salida ledMS del controlPasosMotor se asigna a la salida ledsMicroStepping de este modulo.
			.DIR(dirPin),
			//La salida DIR del controlPasosMotor se asigna a la salida dirPin de este modulo.
			.ledDireccion(ledDirecc)
			//La salida ledDireccion del controlPasosMotor se asigna a la salida ledDirecc de este modulo.
		);
endmodule
