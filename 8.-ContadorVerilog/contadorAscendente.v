//CONTADOR ASCENDENTE
module contadorAscendente(
    input clk,//Reloj de 50MHz de la NEXYS 2.
    input rst,//Boton de Reset.
    output [3:0] contador//Contador de 4 bits, desde 0 hasta 15 en binario.
    );

	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =.
	reg [3:0] conteoAscendente = 4'b0000;//Se le da un valor inicial de 0 al vector
	//4'b0000 esta indicando que el valor es de cuatro (4) numeros (') binarios (b) con valor (0000).

	//always@() sirve para hacer operaciones matematicas, condicionales o bucles, dentro de su parentesis se deben poner 
	//las entradas que usar y ademas tiene su propio begin y end.
	always@(posedge(clk), posedge(rst))
	//La instruccion posedge hace que este condicional se ejecute solo cuando ocurra un flanco de subida en las entradas 
	//clk o rst, osea cuando pasen de 0 logico a 1 logico, ademas la instruccion posedge() hara que el codigo se ejecute 
	//solo, sin que yo directamente tenga que indicarlo con una operacion logica o un selector, si quiero que se ejecute 
	//algo en especfico cuando se de el flanco de subida solo en una de las entradas del always, debo meter el nombre de 
	//esa entrada en el parentesis de un condicional o bucle.
	begin
		if(rst)//Este condicional se ejecutara cuando exista un flanco de subida solo en el boton de reset.
			//Aqui puedo usar un digito hexadecimal que equivale a 4 bits binarios, esto se usa para escribir menos.
			conteoAscendente = 1'h0;//Es un contador ascendente porque empieza a contar desde cero.
			//1'h0 esta indicando que el valor es un (1) numero (') hexadecimal (h) con valor (0), pero como un digito 
			//hexadecimal equivale a 4 bits binarios, es como si pusiera 0000.
		else//No debo poner el caso cuando if(clkNexys2) porque eso ya lo esta haciendo la instruccion always@(posedge())
			conteoAscendente = conteoAscendente + 4'b0001;
			//Aqui pude haber puesto 1'h1 en vez de poner 4'b0001, osea 0001.
			//Es un contador ascendente porque cuenta uno a uno desde cero.
	end

	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign.
	assign contador = conteoAscendente;
endmodule
