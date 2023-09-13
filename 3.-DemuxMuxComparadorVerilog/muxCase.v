//MULTIPLEXOR DE 6 ENTRADAS USANDO EL CONDICIONAL CASE
//Los multiplexores reciben varias senales de entrada (en este caso de un solo bit) y por medio de otra entrada 
//llamada selector se elige una de ellas para que sea la salida, cambiando el selector se puede elegir otra 
//senal para que sea la nueva salida

//El tamano del numero binario del selector se calcula de la siguiente manera: 
//#entradas = 2 ^(#bits del selector)
//8 = 2 ^(3)
//Por lo tanto, si tengo 8, 7, 6 o 5 entradas, el # de bits del selector debe ser de 3, osea [2:0]

//Dentro de module va todo el codigo de Verilog
module muxCase(
    //Senales de entrada
	 input A,
    input B,
    input C,
    input D,
    input E,
    input F,
	 //El selector tambien es una senal de entrada, pero es de tipo vector
    input [2:0] selector,
    //En Verilog todas las salidas que vaya a usar en los condicionales debo declararlas como reg, osea Register
	 //los tipos de salidas reg lo que van a hacer es almacenar valores temporalmente
	 output reg salida
	 //La salida ser determinada por el selector
    );

	//CONDICIONAL CASE, es parecido al condicional switch case
	always@(A or B or C or D or E or F)//always se usa para poder usar los condicionales, tiene su propio begin y end
		//always@(entradas que vaya a usar dentro del case) las entradas se pueden separar entre s por or o por comas
		begin
			case(selector)//CASE se usa para evaluar los diferentes valores de la variable que tenga en su parentesis
				//El selector deber adoptar diferentes numeros que abarquen todas las posibles salidas del mux
				//El numero binario del selector puede contar de uno a uno empezando en cero hasta #entradas-1
				3'b000:salida = A;   //selector con valor decimal 0 = salida A
				//La instruccion 3'b000 esta diciendo que si el selector tiene tres(3) numeros(') binarios(b) con valor 
				//cero cero cero(000) el multiplexor asignar a la salida la entrada A.
				3'b001:salida = B;   //selector con valor decimal 1 = salida B
				3'b010:salida = E;   //selector con valor decimal 2 = salida C
				3'b011:salida = D;   //selector con valor decimal 3 = salida D
				3'b011:salida = E;   //selector con valor decimal 4 = salida E
				3'b100:salida = F;   //selector con valor decimal 5 = salida F
				//Me faltan los casos para el valor decimal 6 y 7 del selector
				//Para la ultima condicion (o ultimas condiciones en este caso) siempre debo usar la instruccion 
				//default, perteneciente al condicional case.
				default:salida = 1'bz;  //selector con valor decimal 6 o 7 = salida Z
				//El valor Z significa alta impedancia y lo que va a hacer es asignar un valor de voltaje que se 
				//encuentre entre el 0 logico y el 1 logico, por lo que en la salida no habra nada.
			endcase
		end
endmodule
