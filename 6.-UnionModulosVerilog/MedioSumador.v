//MEDIO SUMADOR: Sumador de 2 bits
module MedioSumador(
    input aMedSum,
    input bMedSum,
    output sumMedSum,
    output coutMedSum
    );
	 
	//Las compuertas logicas en Verilog se aplican con la palabra reservada que las describe, osea and, or, not, nand, 
	//nor, xor y xnor. Despues debemos poner dentro de su parentesis primero la salida que almacenara el resultado de 
	//la operacion y luego las entradas a las que se les vaya a aplicar la compuerta logica separadas por comas.

	and(coutMedSum, aMedSum, bMedSum); //Acarreo del medio sumador.
	xor(sumMedSum, aMedSum, bMedSum);  //Resultado de la suma del medio sumador.
endmodule
