//2.-CONTROL DE MOTOR A PASOS:
//Modulo que usa el divisor de reloj para prender y apagar las 4 bobinas A, B, C y D del motor a pasos unipolar 
//28BYJ-48, este motor cuenta con un sistema de engranes que tiene una reduccion de 1/64, esto significa que 
//para que el eje final de una vuelta, el eje original debe dar 64 vueltas, aunado a esto para que el rotor 
//principal de una vuelta, se deben cumplir 8 ciclos de la secuencia de pasos que se este utilizando. 
//Se cuenta con 3 secuencias de pasos principales: Paso simple, paso doble y paso medio.
//A continuacion se describen las caracteristicas de cada una.

//PASO SIMPLE O WAVE DRIVE: En este paso solo se activa una fase a la vez, su secuencia consta de 4 acciones 
//por lo cual se necesitan 32 pasos (8 ciclos de 4 secuencias) para que el rotor original de una vuelta 
//completa, en total se necesitan 64 vueltas de 32 pasos cada una, osea 2048 pasos para que el eje final de 
//una vuelta, como resultado la rotacion no es muy suave y se tiene un torque mediocre, que soporta 63 gramos.

//PASO DOBLE O COMPLETO: En este paso se activan dos fases a la vez, su secuencia consta de 4 acciones por lo 
//cual se necesitan 32 pasos (8 ciclos de 4 secuencias) para que el rotor original de una vuelta completa, en 
//total se necesitan 64 vueltas de 32 pasos cada una, osea 2048 pasos para que el eje final de una vuelta, como 
//resultado la rotacion no es muy suave, pero se obtiene el maximo torque, que soporta 126 gramos.

//PASO MEDIO O MEDIO PASO: En este paso primero se activa una fase y luego dos a la vez, por lo cual su 
//secuencia consta de 8 acciones y se necesitan 64 pasos (8 ciclos de 8 secuencias) para que el rotor original 
//de una vuelta completa, en total se necesitan 64 vueltas de 64 pasos cada una, osea 4096 pasos para que el 
//eje final de una vuelta, como resultado la rotacion es muy suave, obteniendo la maxima precision, pero se 
//tiene un torque mediocre, que soporta 63 gramos aproximadamente, no se puede saber a ciencia cierta, porque 
//este motor no esta hecho para soportar este paso.

module controlPasosMotor(
    input frecuencia,
	 input direccionGiro,
    output reg [3:0] salidaMotor, //Las salidas usadas dentro de un condicional o bucle se declaran como reg.
	 output reg ledDireccion 
    );
	
	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o 
	//bucle, solo sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta 
	//de desarrollo y se le asignan valores con el simbolo =
	reg [2:0] paso = 3'b000; //Se le da un valor inicial de 0 al vector.
	//3'b000 esta indicando que el valor es de tres (3) numeros (') binarios (b) con valor (000), se usa este 
	//numero porque el paso simple tiene 8 acciones, por eso se cuenta del 0 al 7 en binario: 
	//000, 001, 010, 011, 100, 101, 110, 111.
	
	//always@() sirve para hacer operaciones matematicas, condicionales o bucles, dentro de su parentesis se 
	//deben poner las entradas que usara y ademas tiene su propio begin y end.
	always@(posedge(frecuencia))
	//La instruccion posedge() hace que este condicional se ejecute solamente cuando ocurra un flanco de subida 
	//en la entrada frecuencia, osea cuando pase de valer 0 logico a valer 1 logico, ademas la instruccion 
	//posedge() hara que el codigo se ejecute por si solo, sin que yo directamente tenga que indicarlo con una 
	//operacion logica.
	begin
		if(direccionGiro == 1'b1) begin
			ledDireccion = 1'b1;
			//CONDICIONAL CASE: Se usa para evaluar los diferentes valores de la variable que tenga en su 
			//parentesis y asignar una salida correspondiente a cada caso.
			case(paso)
				//Rotacion con direccion en el sentido de las manecillas del reloj si el motor a pasos esta boca 
				//arriba.
				3'b000 : salidaMotor = 4'b1000;
				3'b001 : salidaMotor = 4'b1100;
				3'b010 : salidaMotor = 4'b0100;
				3'b011 : salidaMotor = 4'b0110;
				3'b100 : salidaMotor = 4'b0010;
				3'b101 : salidaMotor = 4'b0011;
				3'b110 : salidaMotor = 4'b0001;
				3'b111 : salidaMotor = 4'b1001;
				//Si quiero que se ejecute algo cuando no se cumpla ninguna de las dos condiciones anteriores uso 
				//default.
				default : salidaMotor = 4'b0000;
			endcase
		end else begin
			ledDireccion = 1'b0;
			//CONDICIONAL CASE: Se usa para evaluar los diferentes valores de la variable que tenga en su 
			//parentesis y asignar una salida correspondiente a cada caso.
			case(paso)
				//Rotacion con direccion contraria al sentido de las manecillas del reloj si el motor a pasos esta 
				//boca arriba.
				3'b000 : salidaMotor = 4'b0001;
				3'b001 : salidaMotor = 4'b0011;
				3'b010 : salidaMotor = 4'b0010;
				3'b011 : salidaMotor = 4'b0110;
				3'b100 : salidaMotor = 4'b0100;
				3'b101 : salidaMotor = 4'b1100;
				3'b110 : salidaMotor = 4'b1000;
				3'b111 : salidaMotor = 4'b1001;
				//Si quiero que se ejecute algo cuando no se cumpla ninguna de las dos condiciones anteriores uso 
				//default.
				default : salidaMotor = 4'b0000;
			endcase
		end
		paso = paso + 3'b001;
	end
endmodule
