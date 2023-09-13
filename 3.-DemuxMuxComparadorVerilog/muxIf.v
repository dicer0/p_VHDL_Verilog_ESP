//MULTIPLEXOR DE 4 ENTRADAS USANDO EL CONDICIONAL IF
//Los multiplexores reciben varias senales de entrada (en este caso de un solo bit) y por medio de otra entrada 
//llamada selector se elige una de ellas para que sea la salida, cambiando el selector se puede elegir otra 
//senal para que sea la nueva salida.

//El tamano del numero binario del selector se calcula de la siguiente manera: 
//#entradas = 2 ^(#bits del selector)
//4 = 2 ^(2)
//Por lo tanto, si tengo 4 o 3 entradas, el # de bits del selector debe ser de 2, osea [1:0]

//Dentro de module va todo el codigo de Verilog
module muxIf(
    //Senales de entrada
	 input A,
    input B,
    input C,
    input D,
	 //El selector tambien es una senal de entrada, pero es de tipo vector
	 input [1:0] selector,
	 //En Verilog todas las salidas que vaya a usar en los condicionales debo declararlas como reg, osea Register
	 //los tipos de salidas reg lo que van a hacer es almacenar valores temporalmente
    output reg salida
	 //La salida ser determinada por el selector
    );
	
	//CONDICIONAL IF
	always@(A or B or C or D or selector)
	//always se usa para poder usar condicionales o bucles y tiene su propio begin y end
	//always@(entradas que vaya a usar dentro del if) las entradas se pueden separar entre s por or o por comas
	begin
		if(selector == 2'b00) salida = A;       //selector con valor decimal 0 = salida A
		//La instruccion 2'b00 est diciendo que si el selector tiene dos(2) numeros(') binarios(b) con valor cero 
		//cero(00) el multiplexor asignar a la salida la entrada A.
		else if(selector == 2'b01) salida = B;  //selector con valor decimal 1 = salida B
		else if(selector == 2'b10) salida = C;  //selector con valor decimal 2 = salida C
		//Los else if sirven para cuando tengo varias condiciones diferentes en el condicional if
		else salida = D;                      //selector con valor decimal 3 = salida D
		//Para la ultima condicion (o ultimas condiciones) siempre debo usar la instruccion else
		//O tambien se usa para cuando ninguna de las anteriores condiciones anteriores se cumpla
	end
endmodule
