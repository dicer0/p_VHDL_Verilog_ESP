//Compuerta OR, esta se usa para unir el acarreo de los dos medios sumadores para obtener el carry de salida del 
//sumador completo llamado Cout
module CompuertaOR(
    input C1,
    input C2,
    output SalidaOR
    );
	
	//Las compuertas logicas en Verilog se aplican con la palabra reservada que las describe, osea and, or, not, nand, 
	//nor, xor y xnor. Despues debemos poner dentro de su parentesis primero la salida que almacenar el resultado de 
	//la operacion y luego las entradas a las que se les vaya a aplicar la compuerta logica separadas por comas.
	
	or(SalidaOR, C1, C2);//Compuerta OR que recibe los dos acarreos de salida del medio sumador 1 y 2.
endmodule
