//1.-DIVISOR DE RELOJ:
//Este proceso sirve para dictarle al reloj en que frecuencia quiero que opere.

module divisorDeReloj(
    input relojNexys2, //Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
    output salidaReloj //Reloj que quiero con una frecuencia menor a 50MHz.
    );

	//REG: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, solo sirve 
	//para almacenar y usar valores que sobreviviran durante la ejecucion del codigo y que ademas se deben usar dentro 
	//de un condicional o bucle.
	reg [24:0]divisorDeReloj;
	//Este reg sirve para que podamos obtener una gran gama de frecuencias indicadas en la tabla del divisor de reloj,
	//dependiendo de la coordenada que elijamos tomar del vector para asignarsela a la salida.

	//POSEDGE: La instruccion posedge() solo puede tener una entrada o reg dentro de su parentesis y a fuerza se debe 
	//declarar en el parentesis del always@(), ademas hace que los condicionales o bucles que esten dentro del always@() 
	//se ejecuten por si solos cuando ocurra un flanco de subida en la entrada que tiene posedge() dentro de su 
	//parentesis, el flanco de subida ocurre cuando la entrada pasa de valer 0 logico a valer 1 logico y el hecho de 
	//que la instruccion posedge() haga que el codigo se ejecute por si solo, significa que yo directamente no debo 
	//indicarlo con una operacion logica en el parentesis de los condicionales o bucles, si lo hago me dara error, 
	//aunque si quiero que se ejecute una accion en especfico cuando se de el flanco de subida en solo una de las 
	//entradas que usan posedge(), debo meter el nombre de esa entrada en el parentesis del condicional o bucle. 
	//Si uso posedge() en el parentesis de un always@(), todas las entradas de ese always@() deben ser activadas igual 
	//por un posedge().
	always@(posedge(relojNexys2))
	begin
		//No debo poner el caso cuando if(relojNexys2) porque eso ya lo esta haciendo la instruccion 
		//always@(posedge(relojNexys2),...) por si sola.
		divisorDeReloj = divisorDeReloj + 1;
	end

	//Debo asignar el contenido de una coordenada de la signal divisorDeReloj a salidaReloj para obtener una frecuencia 
	//en especifico, cada coordenada del vector corresponde a una frecuencia en la tabla del divisor de reloj.
	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign.
	assign salidaReloj = divisorDeReloj[24];
	//En la tabla de frecuencias podemos ver que la coordenada 24 proporciona una frecuencia de 1.49Hz.

endmodule
