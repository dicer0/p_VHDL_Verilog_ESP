//DEMUX DE 1 ENTRADA Y 2 SALIDAS
//BUCLE FOR CON EL LENGUAJE VHDL: En VHDL para interactuar con un bucle for se necesita crear un 
//tipo de dato llamado variable, este puede ser de 1 bit, un vector (numero binario) o hasta puede 
//ser un valor numerico entero.

//Dentro de module va todo el codigo de Verilog
module demuxBucleFor(
    input entrada, //Entrada de 1 bit.
    output salidaBit, //Salida de 1 bit.
    output [4:0] salidaNumBinario //Salida tipo vector de 5 bits.
    );
	
	//Antes del always pero dentro del modulo es donde se declaran las variables de tipo 
	//reg e integer que interactuan con el bucle for.
	reg [5:0] varBucleFor;
	integer i;
	
	//BUCLE FOR: Bucle definido que se ejecuta varias veces.
	//always@ se usa para poder usar condicionales o bucles y tiene su propio begin y end
	always@(entrada)	
	begin
		//El bucle for se ejecutara varias veces para rellenar los bits de un vector de tipo 
		//reg con un 1 logico, se indica el punto de partida, el limite y su avance.
		for(i = 0; i <= 5; i = i + 1) begin
			//Ahora accederemos a las 6 posiciones de la variable varBucleFor.
			varBucleFor[i] = 1'b1;
		end
		
		//Reemplazo el numero 111111 del vector varBucleFor por el numero 010111, cambie solo sus 
		//coordenadas 5, 4 y 3.
		varBucleFor[5:3] = 3'b010;
	end
	//A las salidas les asigno valores usando la palabra reservada assign y lo puedo hacer en 
	//cualquier lugar del codigo
	//varBucleFor = 010111
	assign salidaNumBinario = varBucleFor[4:0];	//salidaNumBinario = 10111
	assign salidaBit = varBucleFor[5]; 				//salidaBit = 0
endmodule
