//3.-TLD (Top Level Design) controlMotorAPasosUnipolarPasoSImpleTLD:
//Este codigo sirve para unir los 2 modulos anteriores y poder aplicar la configuracion de paso simple a un motor a pasos
//unipolar modelo 28BYJ-48, para ello primero se ejecuta un divisorDeReloj, del cual se obtiene la frecuencia con la que 
//se encienden y apagan las 4 bobinas A, B, C y D del motor, esto indicara su velocidad, que estara siempre limitada por 
//el sistema de engranajes reductor que tiene en su salida, finalmente en el modulo controlMotor se inicia un contador en 
//donde se ejecutan las 4 acciones de la secuencia de paso simple y se asigna las senales pertinentes a las 4 salidas 
//dirigidas al motor a pasos. 

module MotorAPasosUnipolarPasoSImpleTLD(
	//Declaramos como entradas y salidas solo los pines que salgan del diagrama de bloques global en mi TLD, esto 
	 //se ve en el documento 12.-Motor a Pasos.
	 input direcc,
    input clk,
    input rst,
    output [3:0] bobinasMotor,
	 output ledDirecc
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
			.relojNexys2(clk),
			//La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clk de este modulo.
			.reset(rst),
			//La entrada reset del divisorDeReloj se asigna a la entrada rst de este modulo.
			.salidaReloj(alambre_int)
			//La salida salidaReloj del divisorDeReloj se asigna a la wire alambre_int de este modulo.
		);
	
	//INSTANCIA DEL MODULO controlPasosMotor
	controlPasosMotor motor28BYJ_48(
			.direccionGiro(direcc),
			//La entrada direccionGiro del controlPasosMotor se asigna a la entrada direcc de este modulo.
			.frecuencia(alambre_int),
			//La wire alambre_int de este modulo se asigna a la entrada frecuencia del modulo controlPasosMotor.
			.salidaMotor(bobinasMotor),
			//La salida salidaMotor del controlPasosMotor se asigna a la salida bobinasMotor de este modulo.
			.ledDireccion(ledDirecc)
			//La salida ledDireccion del controlPasosMotor se asigna a la salida ledDirecc de este modulo.
		);
endmodule
