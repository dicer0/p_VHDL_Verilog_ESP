//DEMULTIPLEXOR DE 4 SALIDAS USANDO EL CONDICIONAL IF
//Los Demultiplexores reciben una senal de entrada (el selector) y pueden dar varias senales digitales de salida en 
//forma de vector, el vector es un numero binario con un numero de bits constante, cada bit funciona como variable y 
//puede adoptar cualquiera de los valores digitales ya sea 1 logico, 0 logico o Z alta impedancia. 
//Del vector puedo extraer cada bit individualmente y mandarlos por medio de un BUS al elemento electronico que yo 
//quiera.
//BUS es un conjunto de cables, en cada cable se transmiten individualmente los valores que vaya adoptando cada bit 
//de la salida digital y se podra elegir cualquiera de las senales de salida disponibles por medio del selector.

//El tamano del numero binario del selector se calcula de la siguiente manera: 
//#salidas = 2 ^(#bits del selector)
//4 = 2 ^(2)
//Por lo tanto, si tengo 4 bits en mi vector de salida, el # de bits del selector debe ser de 2, osea [1:0]
//Este mismo numero de bits en el selector funciona tambien para cuando tengo 7, 6 o 5 bits en el vector de salida y 
//este calculo es para que pueda abarcar todas las salidas posibles en funcion al numero de bits en mi vector

//Dentro de module va todo el codigo de Verilog
module demuxIf(
	 //Dentro del parentesis de module se declaran las entradas y salidas
    //Las entradas se declaran con la palabra reservada input y si no tienen corchetes son de un bit
	 input [1:0] selector,
	 //En Verilog todas las salidas que vaya a usar en los condicionales debo declararlas como reg, osea Register
	 //los tipos de salidas reg lo que van a hacer es almacenar valores temporalmente
	 //Las salidas se declaran con la palabra reservada output y si tienen corchetes son de tipo vector, varios bits
    output reg [3:0] salida
    );

	//CONDICIONAL IF
	always@(selector)//always se usa para poder usar los condicionales y tiene su propio begin y end
	//always@(entradas que vaya a usar dentro del if) las entradas se pueden separar entre si por or o por comas
	begin
		if(selector==2'b01) salida = 4'b0001;       //selector con valor decimal 1 = salida 0001 de 4 bits
		//La instruccion 2'b00 esta diciendo que si el selector tiene dos(2) numeros(') binarios(b) con valor cero 
		//cero (00) el demultiplexor asignar a la salida un vector con valor 0001
		else if(selector==2'b10) salida = 4'b0010; //selector con valor decimal 2 = salida 0010 de 4 bits
		else if(selector==2'b11) salida = 4'b0100;  //selector con valor decimal 3 = salida 0100 de 4 bits
		//Los else if sirven para cuando tengo varias condiciones diferentes en el condicional if
		else salida = 4'b1000;                      //selector con valor decimal 0 = salida 1000 de 4 bits
		//Para la ultima condicion (o ultimas condiciones) siempre debo usar la instruccion else, perteneciente al 
		//condicional if
		//O tambien se usa para cuando ninguna de las anteriores condiciones anteriores se cumpla
	end
	//El deMux funciona porque en el ucf voy a tomar cada bit del vector de salida como si fuera una salida individual
	//y la voy a asignar a diferentes leds, al display de 7 segmentos, a un BUS que se dirige a un motor a pasos o  
	//cualquier otro dispositivo electronico.
endmodule
