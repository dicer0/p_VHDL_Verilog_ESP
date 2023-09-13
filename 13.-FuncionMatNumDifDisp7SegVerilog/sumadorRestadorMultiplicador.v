//3.-MULTIPLEXOR PARA SELECCIONAR UNA FUNCION que sume o multiplique el numero binario entrante:
//Este proceso sirve para elegir que funcion se aplica al numero binario entrante, ademas para hacer 
//operaciones matematicas basicas, se pueden crear funciones con los circuitos logicos.

module funcionMatematica(
    input [3:0] binario,//Numero binario entrante al que le voy a aplicar 2 posibles funciones.
    input [1:0] selectorOperacion,//Este selector estara conectado a push buttons para elegir la funcion que quiera.
    output reg [7:0] Result//Aqui se guardara el resultado para mandarse al decodificador, que es el modulo siguiente.
    );

	//ELEGIR FUNCIONES
	always@(binario or selectorOperacion)
	//always@() sirve para hacer condicionales o bucles y dentro de su parentesis se deben indicar las entradas que van a
	//usar los condicionales o bucles que esten dentro del always.
	begin
		case(selectorOperacion)
			2'b01 : Result = 2*binario+2;
			//Cuando el selector valga 10, se realizara la funcion Y(x)=2*x+2.
			2'b10 : Result = binario*binario;
			//Cuando el selector valga 10, se realizara la funcion Y(x)=x*x, osea x al cuadrado.
			default : Result = 8'b00000000; 
			//Si quiero que se ejecute algo cuando no se cumpla ninguna de las dos condiciones anteriores uso default,
			//si ninguna condicion anterior se cumple, el vector Result se llenar de ceros.
		endcase
	end
endmodule
