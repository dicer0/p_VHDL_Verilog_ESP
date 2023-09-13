//6.-TLD (Top Level Design) relojContadorAritmeticaMuxDisp7SegVHDL:
//Este codigo sirve para unir los 3 modulos anteriores y poder realizar la suma, resta o multiplicacion de numeros 
//binarios, para ello primero se realizan operaciones matematicas precargadas que se aplican al unico numero binario 
//que ingresa al programa, luego se aplica el decodificador binario a codigo BCD y finalmente su resultado se muestra 
//en los 4 displays de 7 segmentos, mostrando asi diferentes valores por medio del divisorDeReloj, el contadorSelector, 
//el Multiplexor y el Decodificador Binario a BCD.

module relojContadorAritmeticaMuxDisp7SegTLD(
    input [3:0] numBinario,
    input [1:0] seleccionarOperacion,
    input clkNexys2,
    input Reset,
    output [3:0] leds,
    output [7:0] ledsDisplay,
    output [3:0] anodoComun
    );
	 
	 assign leds = numBinario;
	
	//WIRE: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo 
	//existe durante la ejecucion del codigo, sirve para poder usar algun valor internamente cuando este no va a ser 
	//utilizado dentro de un condicional o bucle y se le asignan valores con el simbolo =
	wire reloj;//Reloj con frecuencia menor a 50MHz.
	wire [1:0] selector;//Contador/selector para encender cada display de 7 segmentos.
	wire [7:0] resultado;//Almacena el resultado de la operacion matematica y encender sus leds en el display.
	wire [3:0] CENTENAS;//Almacena los 4 bits del codigo BCD que denotan las centenas.
	wire [3:0] DECENAS;//Almacena los 4 bits del codigo BCD que denotan las decenas.
	wire [3:0] UNIDADES;//Almacena los 4 bits del codigo BCD que denotan las unidades.
	
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
	divisorDeReloj frecuenciaReloj(
			.relojNexys2(clkNexys2),  
			//La entrada relojNexys2 del divisorDeReloj se asigna a la entrada clkNexys2 de este modulo.
			.rst(Reset),
			//La entrada rst del divisorDeReloj se asigna a la entrada Reset de este modulo.
			.salidaReloj(reloj)
			//La salida salidaReloj del divisorDeReloj se asigna a la wire reloj de este modulo.
		);
	//INSTANCIA DEL MODULO contadorSelector para obtener el contador/selector que prender cada display individualmente.
	contadorSelector selectorDisplay(
			.frecuenciaReloj(reloj),
			//A la entrada frecuenciaReloj del contadorSelector se le asigna el valor de la signal reloj de este modulo.
			.contador(selector)
			//La salida contador del contadorSelector se asigna a la wire selector de este modulo.
		);
	//INSTANCIA DEL MODULO sumadorRestadorMultiplicador para aplicar las funciones matematicas al numero binario.
	funcionMatematica seleccionarFuncion(
			.binario(numBinario),
			//A la entrada binario del sumadorRestadorMultiplicador se le asigna el valor de la entrada numBinario de 
			//este modulo.
			.selectorOperacion(seleccionarOperacion),
			//A la entrada selectorOperacion del sumadorRestadorMultiplicador se le asigna el valor de la entrada 
			//seleccionarOperacion de este modulo.
			.Result(resultado)
			//La salida Result del selectorOperacion se asigna a la wire resultado de este modulo.
		);
	//INSTANCIA DEL MODULO DecodificadorBinBCD para cambiar de sistema numerico binario a codigo BCD por medio del 
	//metodo Shift Add-3.
	decodificadorBinBCD ShiftAdd_3(
			.numBinario(resultado),
			//A la entrada numBinario de DecodificadorBinBCD se le asigna el valor de la signal resultado de este modulo.
			.centenasBCD(CENTENAS),
			//La salida centenasBCD de DecodificadorBinBCD se asigna a la wire centena de este modulo.
			.decenasBCD(DECENAS),
			//La salida decenasBCD de DecodificadorBinBCD se asigna a la wire decena de este modulo.
			.unidadesBCD(UNIDADES)
			//La salida unidadesBCD de DecodificadorBinBCD se asigna a la wire unidad de este modulo.
		);
	//INSTANCIA DEL MODULO display7Seg para recibir el selector del contador y prender cada uno de los 4 displays 
	//dependiendo del codigo BCD que esta recibiendo, y con la frecuencia del selector, prender y apagar los 4 displays 
	//tan rapido que al ojo humano parezca que todos esten encendidos al mismo tiempo con valores diferentes.
	display7Seg mostrarDigito(
			.unidades(UNIDADES),
			//A la entrada unidades de display7Seg se le asigna el valor de la wire UNIDADES de este modulo.
			.decenas(DECENAS),
			//A la entrada decenas de display7Seg se le asigna el valor de la wire DECENAS de este modulo.
			.centenas(CENTENAS),
			//A la entrada centenas de display7Seg se le asigna el valor de la wire CENTENAS de este modulo.
			.selectorMUX(selector),  
			//A la entrada selectorMUX de display7Seg se le asigna el valor de la wire selector de este modulo.
			.prenderDisplay(anodoComun),  
			//La salida prenderDisplay de display7Seg se asigna a la salida anodoComun de este modulo.
			.ledsAhastaDP(ledsDisplay)
			//La salida ledsAhastaG de display7Seg se asigna a la salida numHexadecimal de este modulo.
		);
endmodule
