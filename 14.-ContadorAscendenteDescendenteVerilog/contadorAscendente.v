//2.-CONTADOR DE 2 BITS:
//En este código el contador es de 2 bits, esto implica que contará desde el cero hasta el 3 en forma binaria:
//00, 01, 10 y 11
//Estos números binarios en el módulo siguiente representarán al selector y el selector lo que hará es guardar en el 
//reg digito (del siguiente módulo también) 4 números binarios que representen 1 dígito hexadecimal, este barrido
//se debe hacer en órden y con la frecuencia dictada por el divisorDeReloj para prender individualmente cada display 
//de 7 segmentos, se declara que el contador sea de 2 bits porque como en la NEXYS 2 hay 4 displays de 7 segmentos, lo 
//que yo quiero es que durante un ciclo de reloj todos los displays sean encendidos una vez, mostrando cada dígito del 
//número hexadecimal que corresponda al número binario que esté introduciendo por medio de switches, puedo hacer esto 
//con 2 bits porque cuando el selector adopte los valores 00, 01, 10 y 11 prenderá una vez cada dígito en uno de los 
//4 displays de 7 segmentos durante cada ciclo de reloj

module contadorSelector(
    input clkNexys2, //Este es el reloj proveniente del módulo divisorDeReloj
	 input Reset, //Botón de reset
	 input Direccion, //Botón que fija si el contador es acendente o descendente
    output [3:0] contador //Contador de 4 bits, desde cero hasta el 15 en binario
    );

	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecución del programa, no está conectado a ningún puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =
	reg [3:0] conteoAscendenteDescendente = 4'b0000; //Se le da un valor inicial de 0 al vector
	//4'b0000 está indicando que el valor es de cuatro (4) números (') binarios (b) con valor (0000)
	
	//always@() sirve para hacer operaciones matemáticas, condicionales o bucles, dentro de su parpentesis se deben 
	//poner las entradas que usará y además tiene su propio begin y end
	always@(posedge(clkNexys2))
	//La instrucción posedge() hace que este condicional se ejecute solamente cuando ocurra un flanco de subida en la 
	//entrada clkNexys2, osea cuando pase de valer 0 lógico a valer 1 lógico, además la instrucción posedge() 
	//hará que el código se ejecute por sí solo sin que yo directamente tenga que indicarlo con una operación lógica
	begin
		//Cuando el push button reset esté presionado valdrá un 1 lógico y reiniciará el conteo de la signal 
		//conteoAscendenteDescendente, para poner una operación lógica de igualdad en Verilog se debe poner dos signos 
		//de igual ==
		if(Reset == 1'b1) begin
		//Si reset está presionado el conteoAscendenteDescendente podrá adoptar dos posibles valores dependiendo de si
		//el switch de dirección vale 1 lógico (está encendido) o 0 lógico (está apagado)
			if(Direccion == 1'b0) begin
				conteoAscendenteDescendente = 4'b0000;
			end else begin
				conteoAscendenteDescendente = 4'b1111;
			end
		end else if (Direccion == 1'b1) begin
			//Si el switch de dirección está encendido el conteo será ascendente
			conteoAscendente = conteoAscendente - 4'b1111;
		end else begin 
			//Si el switch de dirección está apagado el conteo será descendente
			conteoAscendente = conteoAscendente + 4'b1111;
		end
	end
	
	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign
	assign contador = conteoAscendente;
	
endmodule
