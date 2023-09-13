//4.-TLD (Top Level Design) relojContadorMuxDisp7SegVHDL:
//Este codigo sirve para unir los 3 modulos anteriores y poder realizar el decodificador binario a hexadecimal y 
//mostrar en los 4 displays de 7 segmentos diferentes valores por medio del divisorDeReloj, el contadorSelector, el 
//Multiplexor y el Decodificador Binario a Hexadecimal.

//Las entradas y salidas en este modulo son las que van a entrar y salir del diagrama de bloques global.
module relojContadorMuxDisp7SegTLD(
    input [15:0] numBinario,
    input Reset,
    input clkNexys2,
    output [6:0] numHexadecimal,
    output puntoDisplay,
    output [4:0] anodoComun
    );

	//WIRE: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
	//existe durante la ejecucion del cdigo, sirve para poder usar algun valor internamente cuando este no va a ser
	//utilizado dentro de un condicional o bucle y se le asignan valores con el simbolo =
	wire reloj;             //Reloj con frecuencia menor a 50MHz.
	wire [1:0] selector;    //Contador/selector para encender cada display de 7 segmentos.
	
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
	
	//INSTANCIA DEL MODULO divisorDeReloj para obtener la frecuencia en la que quiero que se cree el contador/selector.
	divisorDeReloj frecuencia_Reloj(
			.relojNexys2(clkNexys2),
			//La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clkNexys2 de este modulo.
			.rst(Reset),
			//La entrada rst del divisorDeReloj se asigna a la entrada Reset de este modulo.
			.salidaReloj(reloj)
			//La salida salidaReloj del divisorDeReloj se asigna al wire reloj de este modulo.
		);
	//INSTANCIA DEL MODULO contadorSelector para obtener el contador/selector que prender cada display individualmente.
	contadorSelector selector_Display(
			.frecuenciaReloj(reloj),
			//A la entrada frecuenciaReloj del contadorSelector se le asigna el valor de la wire reloj de este modulo.
			.contador(selector)
			//La salida contador del contadorSelector se asigna al wire selector de este modulo.
		);
	//INSTANCIA DEL MODULO decodBinHex para cambiar de sistema numerico binario a hexadecimal, recibir el selector del 
	//contador y prender cada uno de los 4 displays dependiendo del numero binario que este recibiendo y con la 
	//frecuencia del selector, prender y apagar los 4 displays tan rapido que para el ojo humano parezca que todos estan 
	//encendidos al mismo tiempo con valores diferentes.
	decodificadorBinHex binario_A_hexadecimal(
			.binario(numBinario),
			//La entrada binario de decodificadorBinHex se asigna a la entrada numBinario de este modulo.
			.selectorMUX(selector),
			//A la entrada selectorMUX de decodificadorBinHex se le asigna el valor de la wire selector de este modulo.
			.prenderDisplay(anodoComun),
			//La salida anodoComun de decodificadorBinHex se asigna a la salida anodoComun de este modulo.
			.ledsAhastaG(numHexadecimal),
			//La salida ledsAhastaG de decodificadorBinHex se asigna a la salida numHexadecimal de este modulo.
			.DP(puntoDisplay)
			//La salida DP de decodBinHex se asigna a la salida puntoDislpay de este modulo.
		);
endmodule
