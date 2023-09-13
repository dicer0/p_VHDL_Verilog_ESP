//5.-MUX DISPLAY 7 SEGMENTOS:
//Este codigo sirve para mostrar 4 numeros decimales diferentes en los 4 displays de 7 segmentos, esto por si solo
//no se puede lograr porque los displays de 7 segmentos solo pueden mostrar un solo numero a la vez en todos los 
//displays de la NEXYS 2, para lograrlo debemos usar un Multiplexor, un Divisor de Reloj y un Contador/Selector.

module display7Seg(
    input [3:0] unidades, //Codigo BCD que representa las unidades.
    input [3:0] decenas, //Codigo BCD que representa las decenas.
    input [3:0] centenas, //Codigo BCD que representa las centenas.
    input [1:0] selectorMUX, //Selector proveniente del modulo contadorSelector.
    output reg [3:0] prenderDisplay, //Vector de nodos comunes para prender cada display.
    output reg [7:0] ledsAhastaDP //Vector con los leds A,B,C,D,E,F,G y DP.
    );
	
	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =
	reg [3:0] digito;
	
	//MULTIPLEXOR: Existen muchas entradas y una salida.
	//ENDENDIDO DE CADA DISPLAY PARA MOSTRAR UNIDADES, DECENAS Y CENTENAS.
	always@(selectorMUX or unidades or decenas or centenas or digito)
	begin : digitoDisplay //El nombre del always@() es digitoDisplay.
		case(selectorMUX)
			//En el vector de entrada binario el bit mas significativo se encuentra en la posicion 15 y el menos 
			//significativo en la posicion 0.
			2'b00 : begin //UNIDADES
			//Cuando el selector valga 00, la salida de 4 bits llamada prenderDisplay encendera solo el 3er display,
			//mandando un 0 logico a su nodo comun.
				prenderDisplay = 4'b1101; 
				digito = unidades;
			end
			
			2'b01 : begin //DECENAS
			//Cuando el selector valga 01, la salida de 4 bits llamada prenderDisplay encendera solo el 2do display, 
			//mandando un 0 logico a su nodo comun.
				prenderDisplay = 4'b1011; 
				digito = decenas;
			end
			
			2'b10 : begin //CENTENAS
			//Cuando el selector valga 01, la salida de 4 bits llamada prenderDisplay encendera solo el 1er display,
			//mandando un 0 logico a su nodo comun.
				prenderDisplay = 4'b0111; 
				digito = centenas;
			end
			default : begin //La ultima posibilidad de un case se pone como default
			//Cuando el selector valga 11 no se prendera ningun display.
				prenderDisplay = 4'b1111; 
				digito = 4'b1111;
		   end
		endcase
	end
	
	
	//DECODIFICADOR: Transforma un codigo de pocos bits a uno de muchos bits, este en particular convierte de codigo 
	//hexadecimal a codigo display 7 segmentos, los bits que mandamos al display de 7 segmentos se consideran como 
	//codigo porque cada combinacion de unos y ceros representa una letra o numero.
	always@(digito)
	begin : HEXtoDISP7SEG //El nombre del always@() es HEXtoDISP7SEG
		//NUMEROS HEXADECIMALES EN Verilog: 1 digito hexadecimal equivale a 4 bits en binario, esto nos podra servir 
		//para poner un numero binario grande sin tener la necesidad de poner un valor de muchos bits, como cuando debo 
		//llenar un vector de puros ceros. Pero en Verilog esto no se puede aplicar porque el programa se confunde con 
		//el tipo de dato que debe almacenar, por lo que crea una copia del dato y se hace un desastre, por eso es mejor
		//indicar los digitos hexadecimales con su equivalente binario en el case.
		case(digito)
			4'b0000 : ledsAhastaDP = 8'b00000011;
			//Pasa de 0 hexadecimal, osea 0000 a 0 en codigo display 7 segmentos.
			4'b0001 : ledsAhastaDP = 8'b10011111;
			//Pasa de 1 hexadecimal, osea 0001 a 1 en codigo display 7 segmentos.
			4'b0010 : ledsAhastaDP = 8'b00100101;
			//Pasa de 2 hexadecimal, osea 0010 a 2 en codigo display 7 segmentos.
			4'b0011 : ledsAhastaDP = 8'b00001101;
			//Pasa de 3 hexadecimal, osea 0011 a 3 en codigo display 7 segmentos.
			4'b0100 : ledsAhastaDP = 8'b10011001;
			//Pasa de 4 hexadecimal, osea 0100 a 4 en codigo display 7 segmentos.
			4'b0101 : ledsAhastaDP = 8'b01001001;
			//Pasa de 5 hexadecimal, osea 0101 a 5 en codigo display 7 segmentos.
			4'b0110 : ledsAhastaDP = 8'b01000001;
			//Pasa de 6 hexadecimal, osea 0110 a 6 en codigo display 7 segmentos.
			4'b0111 : ledsAhastaDP = 8'b00011011;
			//Pasa de 7 hexadecimal, osea 0111 a 7 en codigo display 7 segmentos.
			4'b1000 : ledsAhastaDP = 8'b00000001;
			//Pasa de 8 hexadecimal, osea 1000 a 8 en codigo display 7 segmentos.
			4'b1001 : ledsAhastaDP = 8'b00001001;
			//Pasa de 9 hexadecimal, osea 1001 a 9 en codigo display 7 segmentos.
			default : ledsAhastaDP = 8'b11111111;
			//Cuando digito valga algun numero binario que no sea una de mis condiciones, no se prendera ningun display.
		endcase
	end
endmodule
