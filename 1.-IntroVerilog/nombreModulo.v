//El lenguaje Verilog si distingue entre mayusculas y minusculas
module nombreModulo(
	 //Dentro del parentesis se declaran las entradas (input) y 
	 //salidas (output), todas separadas por una coma, menos la ultima
    input a,
    input b,
    input c,
    output salidaAND,
    output salidaOR,
    output salidaNOTa,
    output salidaNAND,
    output salidaNOR,
    output salidaXOR,
    output salidaXNOR
    );

//Fuera del parentesis del modulo se declaran las acciones que ejecutaran 
//las entradas y salidas previamente mencionadas.
and(salidaAND,a,b,c);	//Compuerta AND de 3 entradas.
or(salidaOR,a,b,c);		//Compuerta OR de 3 entradas.
not(salidaNOTa,a);		//Compuerta NOT de 1 entrada.
nand(salidaNAND,a,b,c);	//Compuerta NAND de 3 entradas, NAND = NOT AND.
nor(salidaNOR,a,b,c);	//Compuerta NOR de 3 entradas, NOR = NOT OR.
xor(salidaXOR,a,b,c);	//Compuerta XOR de 3 entradas.
xnor(salidaXNOR,a,b,c);	//Compuerta XNOR de 3 entradas, XNOR = NOT XOR.

endmodule
