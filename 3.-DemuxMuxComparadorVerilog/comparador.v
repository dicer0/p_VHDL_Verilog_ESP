//COMPARADOR: PARA HACER UN COMPARADOR DEBO HACER USO DE CONDICIONALES IF.

//De esta manera se ponen comentarios en Verilog.
//Verilog es un lenguaje case sensitive que distingue entre mayusculas y minusculas.

//Dentro de module va todo el codigo de Verilog.
module comparador(
//Dentro del parentesis del modulo se declaran las entradas y salidas que usa mi programa.
	 //Las entradas se declaran con la palabra reservada input.
	 //Cuando la entrada o salida se declara con corchetes es un vector de varios bits,
	 //los vectores son numeros binarios completos que cuentan con un # determinado de bits.
    input [2:0] A, 
	 //El tamano de este vector es de 2,1,0 osea de 3 bits, su bit mas significativo esta en la coordenada 2 y el menos 
	 //significativo en la coordenada 0.
    input [0:2] B, 
	 //El tamano de este vector es de 0,1,2 osea de 3 bits, su bit mas significativo esta en la coordenada 0 y el menos 
	 //significativo en la coordenada 2.
	 
	 //Las salidas se declaran con la palabra reservada output.
	 //En Verilog todas las salidas que vaya a usar en el condicional if debo declararlas como reg, osea Register
	 //los tipos de salidas reg lo que van a hacer es almacenar valores temporalmente.
    output reg igual,  //Las salidas se declaran con la palabra reservada output.
    output reg menor,  //Cuando la entrada o salida se declara sin corchetes es de un solo bit.
    output reg mayor
    );

//CONDICIONAL IF
always@(A,B)//always se usa para poder usar los condicionales y tiene su propio begin y end.
	//always@(dentro de su parntesis debo poner las entradas que vaya a usar en el condicional) 
	//las entradas se pueden separar entre s por or o por comas.
	begin
	igual = 0;
	menor = 0;
	mayor = 0;
	//Es recomendable siempre inicializar mis salidas con algun valor.
		if(A == B) 
			begin
				igual = 1; //La primera condicion siempre va acompanada de un if.
			end//Condicional igual que
		if(A > B)
			begin 
				menor = 1;
			end//Condicional mayor que
		if(A < B) 
			begin 
				mayor = 1;
			end//Condicional menor que
	end//Al final del always@ se pone la instruccion end
endmodule//Al final del modulo se pone la instruccion endmodule
