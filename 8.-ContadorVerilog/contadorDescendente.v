//CONTADOR DESCENDENTE
module contadorDescendente(
    input clkNexys2,//Reloj de 50MHz de la NEXYS 2.
    input reset,//Boton de Reset.
    output [3:0] contador//Contador de 4 bits, desde 15 hasta 0 en binario.
    );

	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =.
	reg [3:0] conteoDescendente = 4'b1111;//Se le da un valor inicial de 15 al vector.
	//4'b1111 esta indicando que el valor es de cuatro (4) numeros (') binarios (b) con valor (1111).

	//always@() sirve para hacer operaciones matematicas, condicionales o bucles, dentro de su parentesis se deben poner 
	//las entradas que usara y ademas tiene su propio begin y end.
	always@(posedge(clkNexys2), posedge(reset))
	//La instruccion posedge hace que este condicional se ejecute solo cuando ocurra un flanco de subida en las entradas 
	//clk o rst, osea cuando pasen de 0 logico a 1 logico, ademas la instruccion posedge() hara que el codigo se ejecute 
	//solo, sin que yo directamente tenga que indicarlo con una operacion logica o un selector, si quiero que se ejecute 
	//algo en especfico cuando se de el flanco de subida solo en una de las entradas del always, debo meter el nombre de 
	//esa entrada en el parentesis de un condicional o bucle.
	begin
		if(reset)//Este condicional se ejecutara cuando exista un flanco de subida solo en el boton de reset.
			//Aqui puedo usar un digito hexadecimal que equivale a 4 bits binarios, esto se usa para escribir menos.
			conteoDescendente = 1'hF;//Es un contador descendiente porque empieza a contar desde 15, osea F en hexadecimal.
			//1'hF esta indicando que el valor es de un (1) numero (') hexadecimal (h) con valor (F), pero como un digito 
			//hexadecimal equivale a 4 bits binarios, es como si pusiera el 15 decimal, osea 1111.
		else//No debo poner el caso cuando if(clkNexys2) porque eso ya lo esta haciendo la instruccion always@(posedge()).
			conteoDescendente = conteoDescendente - 4'b0001;
			//Aqui pude haber puesto 1'h1 en vez de poner 4'b0001, osea 0001.
			//Es un contador descendiente porque cuenta uno a uno desde 15.
	end
	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign.
	assign contador = conteoDescendente;
endmodule
