//3.-DECODIFICADOR BINARIO A HEXADECIMAL PARA MOSTRARLO EN EL DISPLAY DE 7 SEGMENTOS:

module decodificadorBinHex(
	 input [3:0] digito,   				 //Numero binario de 4 bits proveniente del modulo contador.
    input enable,         				 //Switch de enable para prender o apagar el led donde se muestra el conteo.
    output reg [3:0] prenderDisplay, //Vector de nodos comunes para prender cada display.
	 //prenderDisplay es de tipo reg porque lo usar en un condicional if.
    output reg [6:0] ledsAhastaG,    //Vector con los leds A,B,C,D,E,F y G.
	 //prenderDisplay es de tipo reg porque lo usara en un condicional case.
    output DP                        //Puntito en los displays.
    );
	
	//INICIALIZACION DE VALORES: Si quiero hacer esto fuera de cualquier always@() debo usar la instruccion assign.
	assign DP = 1'b1;//El punto de todos los displays siempre estara apagado.
	//Los leds del display de 7 segmentos se prenden con 0 logico y se apagan con 1 logico.
	
	//PRENDER O APAGAR EL DISPLAY DE 7 SEGMENTOS CON LA ENTRADA ENABLE
	always@(enable)
	begin : encenderDisplay //El nombre del always@() es encenderDisplay.
		if(enable == 1'b1) begin//== en Verilog sirve para ver si hay igualdad entre valores.
			prenderDisplay = 4'b1110; //= en Verilog sirve para asignar un valor.
			//4'b0000 esta indicando que el valor es de cuatro (4) numeros (') binarios (b) con valor (1110), esto 
			//prendera solo un display de los 4 disponibles en la tarjeta de desarrollo NEXYS 2.
		end 
		else begin 
			prenderDisplay = 4'b1111;
			//Con esto apago todos los displays de 7 segmentos, si el switch de enable no esta activo.
		end
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
			//Pasa de 0 hexadecimal, osea 0000 a 0 en codigo display 7 segmentos/
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
endmodule
