//Top Level Design (TLD): Sumador completo usando dos medios sumadores y una compuerta OR
module SumadorCompleto(
    input A,
    input B,
    input Cin,
    output Sum,
    output Cout
	 //Las entradas y salidas de este modulo son solo las que van a entrar y salir del sumador completo
    );
	
	//WIRE: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
	//existe durante la ejecucion del codigo y sirve para poder usar algun valor internamente, su sintaxis es la 
	//siguiente:
	//wire nombreWire1; si es de 1 bit		o 		wire [n:0]nombreWire1; si es un vector de n+1 bits
	wire s1;//Esta suma sale de un medio sumador hacia el otro sumador.
	wire c1;//Este acarreo sale de un medio sumador hacia la compuerta OR.
	wire c2;//Este es el otro acarreo que sale de un medio sumador hacia la compuerta OR.

	//INSTANCIAS:
	//Debo darle un nombre a cada instancia que cree, indicar el nombre del modulo que quiero instanciar y dentro de 
	//un parentesis asignarle a todas las entradas y salidas del modulo instanciado una entrada, salida o wire de este 
	//modulo, separadas por comas una de la otra, esto hara que lo que entre o salga del otro modulo, entre, salga o se 
	//guarde en este. La sintaxis que debemos usar es la siguiente:
	
	//Nombre_Del_Modulo_Que_Queremos_Instanciar		NombreInstancia  		(
	//		.Nombre_De_La_Entrada_Del_Modulo_Instanciado(Entrada_En_Este_Modulo),
	//		.Nombre_De_La_Salida_Del_Modulo_Instanciado(Salida_En_Este_Modulo),
	
	//		.Nombre_De_La_Entrada_Del_Modulo_Instanciado(Salida_En_Este_Modulo),
	//		.Nombre_De_La_Salida_Del_Modulo_Instanciado(Entrada_En_Este_Modulo),
	
	//		.Nombre_De_La_Entrada_Del_Modulo_Instanciado(Signal_En_Este_Modulo),
	//		.Nombre_De_La_Salida_Del_Modulo_Instanciado(Signal_En_Este_Modulo)
	//);
	
	//INSTANCIAS DEL MODULO MedioSumador
	//1er Medio Sumador o Half Adder 1 (HA1)
	MedioSumador HA1(
		.aMedSum(A),     //La entrada A del 1er medio sumador se asigna a la entrada A del sumador completo.
		.bMedSum(B),     //La entrada B del 1er medio sumador se asigna a la entrada B del sumador completo.
		//Se asigna un wire cuando la salida o entrada de la instancia se usa solo internamente y no sale del 
		//diagrama de bloques que describe el TLD (Top Level Desing).
		.sumMedSum(s1),  //La salida Suma del 1er medio sumador se guarda en la singal s1 de este modulo.
		.coutMedSum(c1)  //El acarreo de salida del 1er medio sumador se guarda en la singal c1 de este modulo.
	);
	//2do Medio Sumador o Half Adder 1 (HA1)
	MedioSumador HA2(
		.aMedSum(s1),    //La entrada A del 2do medio sumador se asigna a la salida s1 de HA1 guardada en un wire.
		.bMedSum(Cin),   //La entrada B del 2do medio sumador se asigna a la entrada Cin del sumador completo.
		.sumMedSum(Sum), //La salida Suma del 2do medio sumador se asigna a la salida Sum del sumador completo.
		.coutMedSum(c2)  //El acarreo de salida del 2do medio sumador se guarda en la wire c2 de este modulo.
	);
	//INSTANCIA DEL MODULO CompuertaOR.
	//Compuerta OR que une los dos medios sumadores HA1 y HA2.
	CompuertaOR COMPUERTA_OR(
		.C1(c1),         //La entrada C1 de la compuerta OR se asigna a la salida c1 de HA1 guardada en una signal.
		.C2(c2),         //La entrada C2 de la compuerta OR se asigna a la salida c2 de HA2 guardada en una signal.
		.SalidaOR(Cout)  //La salida de la compuerta OR se asigna a la salida Cout del sumador completo.
	);
endmodule
