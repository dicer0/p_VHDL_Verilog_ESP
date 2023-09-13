//3.-DECODIFICADOR BINARIO A HEXADECIMAL CON MUX PARA MOSTRARLO EN LOS 4 DISPLAYS DE 7 SEGMENTOS A LA VEZ:
//Este codigo sirve para mostrar 4 numeros hexadecimales diferentes en los 4 displays de 7 segmentos, esto por si solo
//no se puede lograr porque los displays de 7 segmentos solo pueden mostrar un solo numero a la vez en todos los 
//displays de la NEXYS 2, para lograrlo debemos usar un Multiplexor, un Divisor de Reloj y un Contador/Selector.

module decodificadorBinHex(
	 input [15:0] binario,            //Entrada para meter un numero binario por medio de switches.
    input [1:0] selectorMUX,         //Selector proveniente del modulo contador.
    output reg [3:0] prenderDisplay, //Vector de nodos comunes para prender cada display.
	 //prenderDisplay es de tipo reg porque lo usar en un condicional if.
    output reg [6:0] ledsAhastaG,    //Vector con los leds A,B,C,D,E,F y G.
	 //prenderDisplay es de tipo reg porque lo usar en un condicional case.
    output DP                        //Puntito en los displays.
    );


	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =
	reg [3:0] anodoEncendido = 4'b1111;
	reg [3:0] digito;
	
	
	//INICIALIZACION DE VALORES: Si quiero hacer esto fuera de cualquier always@() debo usar la instruccion assign.
	assign DP = 1'b1;//El punto de todos los displays siempre estar apagado.
	
	
	//MULTIPLEXOR: Existen muchas entradas y una salida.
	always@(selectorMUX, binario)
	begin : MUX //El nombre del always@() es MUX.
		case(selectorMUX)
			//En el vector de entrada binario el bit mas significativo se encuentra en la posicion 15 y el menos 
			//significativo en la posicion 0.
			2'b00 : digito = binario [3:0];
			//Cuando el selector valga 00, el reg de 4 bits llamado digito se llenara de los ultimos 4 bits que haya 
			//en la entrada que recibe el numero binario, desde la posicion 3 hasta la 0.
			2'b01 : digito = binario [7:4];
			//Cuando el selector valga 01, digito se llenara de los 4 penultimos bits que haya en la entrada que recibe 
			//el numero binario, desde la posicion 7 hasta la 4.
			2'b10 : digito = binario [11:8];
			//Cuando el selector valga 10, digito se llenara de los 4 segundos bits que haya en la entrada que recibe 
			//el numero binario, desde la posicion 11 hasta la 8.
		 default : digito = binario [15:12]; //La ultima posibilidad de un case se pone como default.
		   //Cuando el selector valga 11, digito se llenara de los 4 primeros bits que haya en la entrada que recibe 
			//el numero binario, desde la posicion 15 hasta la 12.
		endcase
	end
	
	
	//DECODIFICADOR: Transforma un codigo de pocos bits a uno de muchos bits, este en particular convierte de codigo 
	//hexadecimal a codigo display 7 segmentos, los bits que mandamos al display de 7 segmentos se consideran como 
	//codigo porque cada combinacion de unos y ceros representa una letra o numero.
	always@(digito)
	begin : HEXtoDISP7SEG //El nombre del always@() es HEXtoDISP7SEG.
		//NUMEROS HEXADECIMALES EN Verilog: 1 digito hexadecimal equivale a 4 bits en binario, esto nos podra servir 
		//para poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits, como cuando debo 
		//llenar un vector de puros ceros. Pero en Verilog esto no se puede aplicar porque el programa se confunde con 
		//el tipo de dato que debe almacenar, por lo que crea una copia del dato y se hace un desastre, por eso es mejor
		//indicar los digitos hexadecimales con su equivalente binario en el case.
		case(digito)
			4'b0000 : ledsAhastaG = 7'b0000001;
			//Pasa de 0 hexadecimal, osea 0000 a 0 en codigo display 7 segmentos.
			4'b0001 : ledsAhastaG = 7'b1001111;
			//Pasa de 1 hexadecimal, osea 0001 a 1 en codigo display 7 segmentos.
			4'b0010 : ledsAhastaG = 7'b0010010;
			//Pasa de 2 hexadecimal, osea 0010 a 2 en codigo display 7 segmentos.
			4'b0011 : ledsAhastaG = 7'b0000110;
			//Pasa de 3 hexadecimal, osea 0011 a 3 en codigo display 7 segmentos.
			4'b0100 : ledsAhastaG = 7'b1001100;
			//Pasa de 4 hexadecimal, osea 0100 a 4 en codigo display 7 segmentos.
			4'b0101 : ledsAhastaG = 7'b0100100;
			//Pasa de 5 hexadecimal, osea 0101 a 5 en codigo display 7 segmentos.
			4'b0110 : ledsAhastaG = 7'b0100000;
			//Pasa de 6 hexadecimal, osea 0110 a 6 en codigo display 7 segmentos.
			4'b0111 : ledsAhastaG = 7'b0001101;
			//Pasa de 7 hexadecimal, osea 0111 a 7 en codigo display 7 segmentos.
			4'b1000 : ledsAhastaG = 7'b0000000;
			//Pasa de 8 hexadecimal, osea 1000 a 8 en codigo display 7 segmentos.
			4'b1001 : ledsAhastaG = 7'b0000100;
			//Pasa de 9 hexadecimal, osea 1001 a 9 en codigo display 7 segmentos.
			4'b1010 : ledsAhastaG = 7'b0001000;
			//Pasa de A hexadecimal, osea 10, osea 1010 a A en codigo display 7 segmentos.
			4'b1011 : ledsAhastaG = 7'b1100000;
			//Pasa de B hexadecimal, osea 11, osea 1011 a b en codigo display 7 segmentos.
			4'b1100 : ledsAhastaG = 7'b0110001;
			//Pasa de C hexadecimal, osea 12, osea 1100 a C en codigo display 7 segmentos.
			4'b1101 : ledsAhastaG = 7'b1000010;
			//Pasa de D hexadecimal, osea 13, osea 1101 a d en codigo display 7 segmentos.
			4'b1110 : ledsAhastaG = 7'b0110000;
			//Pasa de E hexadecimal, osea 14, osea 1110 a E en codigo display 7 segmentos.
			4'b1111 : ledsAhastaG = 7'b0111000;
			//Pasa de F hexadecimal, osea 15, osea 1111 a F en codigo display 7 segmentos.
		endcase
	end

	
	//ENCENDER CADA DISPLAY DE 7 SEGMENTOS PARA APARENTAR QUE CADA UNO TIENE UN VALOR DIFERENTE:
	//Como no podemos tener desplegados 4 valores diferentes en los display de 7 segmentos, lo que se hace es que por 
	//medio del selector proveniente del modulo contador con la frecuencia dictada por el divisorDeReloj, este codigo 
	//prenda cada display individualmente tan rapido (osea con una frecuencia tan alta) que nuestros ojos no lo puedan 
	//distinguir y veamos como si estuvieran prendidos al mismo tiempo con valores diferentes, cada display individual 
	//se encendera dependiendo del selector que haya entrado al programa, para luego asignara a la signal digito un valor 
	//determinado dependiendo de los switches que esten activados en la entrada hexadecimal y por ultimo prenda los 
	//leds A,B,C,D,E,F o G correspondientes en todos los displays, este process lo que hara es que acceder a la salida 
	//tipo vector llamada prenderDisplay y mandar un 0 logico al nodo comun del display que debe prender en ese 
	//momento, para que despues el selector cambie de valor y se ejecute nuevamente el codigo, pero ahora prendiendo 
	//diferentes leds y otro display de 7 segmentos.
	always@(selectorMUX, anodoEncendido)
	begin : elegirDisplay //El nombre del always@() es elegirDisplay.
		//En un inicio todos los displays de 7 segmentos estaran apagados.
		prenderDisplay = 4'b1111;
		//Al usar el nombre de un vector y poner entre corchetes una de sus coordenadas, estoy accediendo solo a ese bit 
		//del vector, en Verilog no se debe convertir manualmente lo que haya en el interior de su parentesis a su 
		//equivalente decimal, ya que el programa lo hace por si solo.
		if(anodoEncendido[selectorMUX] == 1'b1) begin//== en Verilog sirve para ver si hay igualdad entre valores.
			//Este condicional siempre sera cierto porque el vector anodoEncendido esta inicializado con valor 1111, por 
			//lo que cualquiera de sus coordenadas tiene un 1 logico, lo importante de este condicional es que el programa 
			//escrito en Verilog convierte por si solo al selector en su numero decimal para acceder a una coordenada de 
			//su vector y la coordenada que corresponda la cambia a un 0 logico en el vector prenderDisplay, que prende 
			//cada display dependiendo de los bits que existan en el signal digito en ese momento, determinados por el 
			//valor del mismo selector.
			prenderDisplay[selectorMUX] = 1'b0; //= en Verilog sirve para asignar un valor.
		end
	end
endmodule
