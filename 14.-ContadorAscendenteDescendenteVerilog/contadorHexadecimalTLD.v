//4.-TLD (Top Level Design) relojContadorMuxDisp7SegVHDL:
//Este codigo sirve para unir los 3 modulos anteriores y poder realizar el decodificador binario a hexadecimal y 
//mostrar en los 4 displays de 7 segmentos diferentes valores por medio del divisorDeReloj, el contador Ascendente 
//Descendente y el decodificador Binario a Hexadecimal.

//Las entradas y salidas en este modulo son las que van a entrar y salir del diagrama de bloques global.
module relojContadorMuxDisp7SegTLD(
    input Habilitacion,
	 input direcc,
    input Reset,
    input clkNexys2,
    output [3:0] anodoDisplay,
    output puntoDisplay,
    output [6:0] numHexadecimal
    );

	//WIRE: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
	//existe durante la ejecucion del codigo, sirve para poder usar algun valor internamente cuando este no va a ser 
	//utilizado dentro de un condicional o bucle y se le asignan valores con el simbolo =
	wire reloj;             //Reloj con frecuencia menor a 50MHz.
	wire [3:0] selector;    //Contador/Selector para encender cada uno de los 4 displays de 7 segmentos.
	
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
	
	//INSTANCIA DEL MODULO divisorDeReloj para obtener la frecuencia en la que quiero que se cree el contador/selector.
	divisorDeReloj frecuenciaReloj(
			.relojNexys2(clkNexys2),
			//La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clkNexys2 de este modulo.
			.salidaReloj(reloj)
			//La salida salidaReloj del divisorDeReloj se asigna al wire reloj de este modulo.
		);
	//INSTANCIA DEL MODULO contadorSelector para obtener el contador/selector que prendera cada display individualmente.
	contadorAsc_Desc selectorDisplay(
			.clkNexys2(reloj),
			//A la entrada clkNexys2 del contadorAsc_Desc se le asigna el valor de la wire reloj de este modulo.
			.Reset(Reset),
			//La entrada Reset del contadorAsc_Desc se asigna a la entrada Reset de este modulo.
			.Direccion(direcc),
			//La entrada Direccion del contadorAsc_Desc se asigna a la entrada Reset de este modulo.
			.Contador(selector)
			//La salida contador del contadorAsc_Desc se asigna a la wire selector de este modulo.
		);
	//INSTANCIA DEL MODULO decodBinHex para cambiar de sistema numerico binario a hexadecimal, recibira el selector del 
	//contador y prendera el display dependiendo del numero binario que este recibiendo y con la frecuencia del reloj, 
	//prendera y apagara los leds que esten en el display.
	decodificadorBinHex HexadecimalADisp7Seg(
			.digito(selector),
			//A la entrada digito de decodificadorBinHex se le asigna el valor del wire selector de este modulo.
			.enable(Habilitacion),
			//La entrada enable de decodificadorBinHex se asigna a la entrada Habilitacion de este modulo.
			.prenderDisplay(anodoDisplay),
			//La salida prenderDisplay de decodificadorBinHex se asigna a la salida anodoDisplay de este modulo.
			.ledsAhastaG(numHexadecimal),  
			//La salida ledsAhastaG de decodificadorBinHex se asigna a la salida numHexadecimal de este modulo.
			.DP(puntoDisplay)
			//La salida DP de decodBinHex se asigna a la salida puntoDislpay de este modulo.
		);
endmodule
