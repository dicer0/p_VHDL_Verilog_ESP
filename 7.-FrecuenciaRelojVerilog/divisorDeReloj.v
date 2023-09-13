//DIVISOR DE RELOJ: Este proceso sirve para dictarle al reloj en que frecuencia quiero que opere.

//En este caso quiero obtener una senal de reloj con frecuencia de 1Hz, osea que cada 1s se repita su ciclo.
//Para poder obtener una senal de reloj con esta frecuencia debo crear el vector divisorDeReloj de 24 bits, crear el 
//condicional que establezca sus frecuencias e irme a la tabla para ver (despues del condicional if) que coordenada 
//del vector me entrega una frecuencia cercana a la que quiero, la tabla mencionada se encuentra en el documento 
//8.1.-Senal de reloj CLK en Verilog o VHDL.

//Todas las entradas y salidas del reloj son de 1 bit
module divisorDeReloj(
    input clkNexys2,   //Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
    input Reset,       //Boton de reset.
    output salidaReloj //Reloj que quiero con frecuencia de 1Hz.
    );

	//reg: Este tipo de dato sirve para almacenar valores que solo sobreviviran durante la ejecucion del codigo y que 
	//ademas se puedan usar dentro de un condicional o bucle.
	reg [24:0]divisorDeReloj;

	//POSEDGE: La instruccion posedge() solo puede tener una entrada o reg dentro de su parentesis y a fuerza se debe 
	//declarar en el parentesis del always@(), ademas hace que los condicionales o bucles que esten dentro del always@() 
	//se ejecuten por si solos cuando ocurra un flanco de subida en la entrada que tiene posedge() dentro de su parentesis, 
	//el flanco de subida ocurre cuando la entrada pasa de valer 0 logico a valer 1 logico y el hecho de que la instruccion 
	//posedge() haga que el codigo se ejecute por si solo significa que yo directamente no debo indicarlo con una operacion 
	//logica en el parentesis de los condicionales o bucles, si lo hago me dara error, aunque si quiero que se ejecute una 
	//accion en especfico cuando se de el flanco de subida en solo una de las entradas que usan posedge(), debo meter el 
	//nombre de esa entrada en el parentesis del condicional o bucle, tambien si uso un posedge, todas las entradas deben
	//ser activadas igual por un posedge.
	always@(posedge(clkNexys2),posedge(Reset))
	begin
		if(Reset)//Este condicional solo se ejecutara cuando exista un flanco de subida solo en el boton de reset.
			divisorDeReloj = 25'b0000000000000000000000000;
		else//No debo poner el caso cuando if(clkNexys2) porque eso ya lo esta haciendo la instruccion always@(posedge()).
			divisorDeReloj = divisorDeReloj + 1;
	end

	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign.
	assign salidaReloj = divisorDeReloj[24];
endmodule
