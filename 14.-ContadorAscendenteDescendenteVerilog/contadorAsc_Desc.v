//2.-CONTADOR DE 4 BITS:
//En este codigo el contador es de 4 bits, esto implica que contara desde cero hasta 15 en forma binaria.

module contadorAsc_Desc(
    input clkNexys2, //Este es el reloj de 50MHz proveniente del modulo divisorDeReloj.
	 input Reset, //Boton de Reset.
	 input Direccion, //Boton que fija si el contador es ascendente o descendente.
    output [3:0] Contador //Contador de 4 bits, desde cero hasta el 15 en binario.
    );

	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =
	reg [3:0] conteoAscendenteDescendente = 4'b0000; //Se le da un valor inicial de 0 al vector.
	//4'b0000 esta indicando que el valor es de dos (4) numeros (') binarios (b) con valor (0000).
	
	//always@() sirve para hacer operaciones matematicas, condicionales o bucles, dentro de su parentesis se deben 
	//poner las entradas que usara y ademas tiene su propio begin y end.
	always@(posedge(clkNexys2))
	//La instruccion posedge() hace que este condicional se ejecute solamente cuando ocurra un flanco de subida en la 
	//entrada frecuenciaReloj, osea cuando pase de valer 0 logico a valer 1 logico, ademas la instruccion posedge() 
	//hara que el codigo se ejecute por si solo, sin que yo directamente tenga que indicarlo con una operacion logica.
	begin
		if (Reset == 1'b0) begin 
		//Si el boton de reset esta en 0 logico, el vector conteoAscendenteDescendente puede adoptar dos posibles valores
			if (Direccion == 1'b0) begin
			//Si el switch de direccion no esta accionado, osea que vale cero, la direccion sera ascendente y al dar clic 
			//al reset se empezara el conteo desde 0000.
				conteoAscendenteDescendente = 4'b0000;
			end else begin 
			//Si el switch de direccion esta accionado, osea que vale 1 logico, la direccion sera descendente y al dar 
			//clic al reset se empezara el conteo desde F hexadecimal, osea 1111.
				conteoAscendenteDescendente = 4'b1111;
			end
		end else if (Direccion == 1'b1) begin
		//Si damos clic al boton dreccion, al register conteoAscendenteDescendente se le restara un 1 a lo que lleve 
		//almacenado hasta ese punto.
			conteoAscendenteDescendente = conteoAscendenteDescendente - 4'b0001;
		end else begin
		//Si no damos clic al boton dreccion, al register conteoAscendenteDescendente se le sumara un 1 a lo que lleve 
		//almacenado hasta ese punto.
			conteoAscendenteDescendente = conteoAscendenteDescendente + 4'b0001;
		end
	end
	
	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign.
	assign Contador = conteoAscendenteDescendente;
	
endmodule
