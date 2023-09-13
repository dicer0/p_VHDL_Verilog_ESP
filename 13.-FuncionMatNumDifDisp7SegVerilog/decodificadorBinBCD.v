//4.-DECODIFICADOR BINARIO a BCD: MTODO SHIFT ADD-3
//Este metodo sirve para convertir numeros binarios a codigo BCD, el codigo BCD sirve para que las maquinas nos puedan
//ensenar numeros a traves de displays de 7 segmentos, donde cada 4 bits representan un digito decimal.

module decodificadorBinBCD(
    input [7:0] numBinario,//Resultado del modulo anterior que le realizo una funcion matematica a un numero binario.
    output [3:0] centenasBCD,
    output [3:0] decenasBCD,
    output [3:0] unidadesBCD
	 //El codigo BCD describe cada digito decimal con 4 bits que indican sus unidades, decenas y centenas.
    );

	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =
	reg [11:0] codigoBCDcompleto;
	reg [19:0] posiciones;
	
	integer ciclos;
	integer i;
	
	//Dentro de always@() se va a poner el algoritmo para ejecutar el metodo Shift Add-3, para entender el procedimiento
	//debo meterme al documento 11.-Sum, Res, Mult, Decod BCD y 4 valores Disp 7 Seg.
	always@(numBinario)
	begin
		//LLENAR DE CEROS TODAS LAS POSICIONES POSIBLES (OSEA LAS COLUMNAS) DE LA TABLA SHIFT ADD-3
		for(ciclos=0; ciclos<=19; ciclos=ciclos+1) begin
			//Este bucle se va a repetir 20 veces y lo que hara es limpiar todos los bits de la variable posiciones .
			posiciones[ciclos] = 1'b0;//Con limpiar nos referimos a llenar de ceros el vector.
		end
		
		//METER EL NUMERO BINARIO EN LA VARIABLE POSICIONES PARA QUE ENTRE A LA TABLA DEL MTODO SHIFT ADD-3
		posiciones[7:0] = numBinario[7:0];
		//Con esta instruccion metemos el valor de la entrada llamada binario a las posiciones 0,1,2,3,4,
		//5,6 y 7 del vector posiciones, esto se hace para que este en la posicion inicial de la tabla.
	
		//METODO SHIFT ADD-3 A LAS COLUMNAS: UNIDADES, DECENAS Y CENTENAS
		for(i=0; i<=7; i=i+1) begin
			//Este bucle se va a repetir 8 veces y lo que hara es ejecutar las operaciones SHIFT1, SHIFT2, SHIFT3, 
			//SHIFT4, SHIFT5, SHIFT6, SHIFT7 y SHIFT8, ya que estas son todas las veces que se puede recorrer el numero 
			//binario a la izquierda en la tabla del metodo SHIFT ADD-3, aplicado a un numero binario de maximo 8 bits, 
			//durante estos recorrimientos se debe analizar cada columna de Unidades, Decenas y Centenas.
			
			//COLUMNA DE UNIDADES: ADD-3
			if(posiciones[11:8]>4'b0100) begin
				//Cada columna la puedo analizar individualmente si analizo las coordenadas del vector posiciones que 
				//las abarcan, las posiciones 11, 10, 9 y 8 abarcan la columna de Unidades.
				posiciones[11:8] = posiciones[11:8] + 4'b0011; //Add3
				//Si el numero binario contenido en estas coordenadas del vector posiciones es mayor a 4, osea 100 se 
				//le suma el numero decimal 3, osea 011.
			end
			
			//COLUMNA DE DECENAS: ADD-3
			if(posiciones[15:12]>4'b0100) begin
				//Las posiciones 15, 14, 13 y 12 abarcan la columna de Decenas.
				posiciones[15:12] = posiciones[15:12] + 4'b0011; //Add3
				//Si el numero binario contenido en estas coordenadas del vector posiciones es mayor a 4, osea 100 se 
				//le suma el numero decimal 3, osea 011.
			end
			
			//COLUMNA DE CENTENAS: ADD-3
			if(posiciones[19:16]>4'b0100) begin
				//Las posiciones 19, 18, 17 y 16 abarcan la columna de Centenas.
				posiciones[19:16] = posiciones[19:16] + 4'b0011; //Add3
				//Si el numero binario contenido en estas coordenadas del vector posiciones es mayor a 4, osea 100 se 
				//le suma el numero decimal 3, osea 011.
			end
			
			//SHIFT: Este pedazo de codigo aplicara los SHIFT1,2,3,4,5,6,7 y SHIFT8.
			posiciones[19:1] = posiciones[18:0];
			//Esta operacion del bucle es la operacion SHIFT y es usada para mover un lugar a la izquierda todo el 
			//vector cuando ningun numero en ninguna columna sea mayor a 4, osea 100.
		end
		
		//GUARDO EL RESULTADO DEL METODO SHIFT ADD-3 EN EL REG
		codigoBCDcompleto = posiciones[19:8];
		//Las posiciones 19 downto 8 son todas las que abarca el codigo BCD al terminar de ejecutarse el metodo 
		//SHIFT ADD-3 porque ya no debe quedar ningun bit en la columna BINARIO.
	end
	
	//SEPARAR EL RESULTADO DEL MTODO SHIFT ADD-3, OSEA AL CODIGO BCD EN UNIDADES, DECENAS Y CENTENAS
	//A las salidas les asigno valores usando la palabra reservada assign y lo puedo hacer en cualquier lugar del codigo.
	assign centenasBCD = codigoBCDcompleto[11:8];//4 bits del codigo BCD representan un digito decimal, osea 1 centena
	assign decenasBCD  = codigoBCDcompleto[7:4];//4 bits del codigo BCD representan un digito decimal, osea 1 decena
	assign unidadesBCD = codigoBCDcompleto[3:0];//4 bits del codigo BCD representan un digito decimal, osea 1 unidad
endmodule
