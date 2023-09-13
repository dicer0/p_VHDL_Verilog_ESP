//SUMA, RESTA, MULTIPLICACION Y DIVISION DE NUMEROS BINARIOS DE 4 BITS
//En Verilog tengo la ventaja de que no tengo que usar libreras extra para poder hacer operaciones matematicas.
module operacionMath(
    input [3:0] Num1,
    input [3:0] Num2,
	 //Numeros binarios que se van a sumar, restar, multiplicar y dividir:
	 //Todas los resultados de operaciones deben ser output reg porque se van a usar dentro de always@().
    output reg [4:0] Suma,
	 //El resultado de la suma debe ser un bit mayor a los numeros sumados entre si.
    output reg [3:0] Resta,
	 //El resultado de la resta va a ser del mismo numero de bits que los numeros restados entre si.
    output reg [7:0] Multiplicacion
	 //El resultado de la multiplicacion va a tener el doble de bits que los numeros multiplicados entre si.
    //output reg [3:0] Division
	 //Verilog tiene problemas para hacer la division.
    );

//ALWAYS@ no solo se usa para crear condicionales o bucles, tambien puede servir para hacer operaciones matematicas.
always@(Num1 or Num2)
	begin//always@() tiene su propio begin y end.
		Suma = Num1+Num2;
		Resta = Num1-Num2;
		Multiplicacion = Num1*Num2;
		//Division = Num1 / Num2; Verilog no puede sintetizar la division de forma sencilla.
		//Todas las operaciones matematicas binarias se pueden realizar de manera muy sencilla, exceptuando a la 
		//division, esta necesita un proceso mas complejo.
	end
endmodule
