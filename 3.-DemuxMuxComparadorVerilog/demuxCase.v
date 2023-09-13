//DEMULTIPLEXOR DE 5 SALIDAS USANDO EL CONDICIONAL CASE
//Los Demultiplexores reciben una senal de entrada (el selector) y pueden dar varias senales digitales de salida 
//diferentes en forma de vector, el vector es un numero binario con un numero de bits constante, cada bit funciona como 
//variable y puede adoptar cualquiera de los valores digitales, ya sea 1 logico, 0 logico o Z alta impedancia. 
//Del vector puedo extraer cada bit individualmente y mandarlos por medio de un BUS al elemento electronico que yo 
//quiera.
//BUS es un conjunto de cables, en cada cable se transmiten individualmente los valores que vaya adoptando cada bit 
//de la senal digital de salida (osea el numero binario) y se podra elegir cualquiera de las senales de salida 
//disponibles por medio del selector. 
//El numero de salidas disponibles que tengo van en funcion del tamano del selector, si selector es de pocos bits 
//puedo elegir pocas posibles salidas y viceversa.

//El Demultiplexor puede recibir dos senales de entrada en vez de solo el selector, la segunda entrada se llama 
//enable y sirve para encender o apagar el demux, ya que, si el enable esta en cero, todos los bits de la salida 
//estaran en cero.

//El tamano del numero binario del selector se calcula de la siguiente manera: 
//#salidas = 2 ^(#bits del selector)
//8 = 2 ^(3)
//Por lo tanto, si tengo 8 bits en mi vector de salida, el # de bits del selector debe ser de 3, osea [2:0]
//Este mismo numero de bits en el selector funciona tambien para cuando tengo 7, 6 o 5 bits en el vector de salida 
//Este calculo es para que pueda abarcar todas las salidas posibles en funcion al numero de bits en mi vector.

//Dentro de module va todo el codigo de Verilog.
module demuxCase( 
    input [2:0] selector,
    input enable,
	 //En Verilog todas las salidas que se vaya a usar en los condicionales debo declararlas como reg, osea Register
	 //los tipos de salidas reg lo que van a hacer es almacenar valores temporalmente.
    output reg [4:0] salida
	 //La salida sera determinada por el selector.
    );

	//CONDICIONAL CASE, es parecido al condicional switch case.
	always@(selector, enable)//always se usa para poder usar los condicionales, tiene su propio begin y end.
	//always@(entradas que vaya a usar dentro del case) las entradas se pueden separar entre si por or o por comas.
	begin
		case(selector)//CASE se usa para evaluar los diferentes valores de la variable que tenga en su parentesis
			//El selector deber adoptar diferentes numeros binarios que abarquen todas las posibles salidas del 
			//demux, dependiendo del numero de bits que tenga, es el numero de posibilidades que puede aportar.
			//Las llaves {} se usan para concatenar variables con bits y se usa para darle uso al enable.
			3'b001:salida={enable, 4'b0000};      //selector con valor decimal 1 = salida 10000 de 5 bits.
			//La instruccion 3'b001 esta diciendo que si el selector tiene tres(3) numeros(') binarios(b) con 
			//valor cero cero uno(001) el demultiplexor asignara a la salida un vector con valor 10000 o 00000 
			//dependiendo del valor de la entrada enable.
			3'b010:salida={1'b0, enable, 3'b000}; //selector con valor decimal 2 = salida 01000 de 5 bits.
			3'b011:salida={2'b00, enable, 2'b00}; //selector con valor decimal 3 = salida 00100 de 5 bits.
			3'b100:salida={3'b000, enable, 1'b0}; //selector con valor decimal 4 = salida 00010 de 5 bits.
			3'b101:salida={4'b0000, enable};      //selector con valor decimal 5 = salida 00001 de 5 bits.
			//Me faltan los casos para el valor decimal 0, 6 y 7 del selector.
			//Para mi ultima condicion (o ultimas condiciones en este caso) siempre debo usar la instruccion 
			//default perteneciente al condicional case.
			default:salida=4'bzzzz;               //selector con valor decimal 0, 6 o 7 = salida ZZZZZ de 5 bits 
			//El valor Z significa alta impedancia y lo que va a hacer es asignar un valor de voltaje que se 
			//encuentre entre el 0 logico y el 1 logico, por lo que en la salida no habra nada.
		endcase
	end
	//El deMux funciona porque en el ucf voy a tomar cada bit del vector de salida como si fuera una salida individual
	//y la voy a asignar a diferentes leds, al display de 7 segmentos, a un BUS que se dirige a un motor a pasos o  
	//cualquier otro dispositivo electronico.
endmodule
