//2.-CONTADOR DE 2 BITS:
//En este codigo el contador es de 2 bits, esto implica que contar desde cero hasta 3 en forma binaria:
//00, 01, 10 y 11.
//Estos numeros binarios en el modulo siguiente representan al selector y el selector lo que hara es guardar en el 
//reg digito (del siguiente modulo tambien) 4 numeros binarios que representen 1 digito hexadecimal, este barrido
//se debe hacer en orden y con la frecuencia dictada por el divisorDeReloj para prender individualmente cada display 
//de 7 segmentos, se declara que el contador sea de 2 bits porque como en la NEXYS 2 hay 4 displays de 7 segmentos, lo 
//que yo quiero es que durante un ciclo de reloj todos los displays sean encendidos una vez, mostrando cada digito del 
//numero hexadecimal que corresponda al numero binario que se esta introduciendo por medio de switches, puedo hacer esto 
//con 2 bits porque cuando el selector adopte los valores 00, 01, 10 y 11 prendera una vez cada digito en uno de los 
//4 displays de 7 segmentos durante cada ciclo de reloj.

module contadorSelector(
    input frecuenciaReloj, //Este es el reloj proveniente del modulo divisorDeReloj
    output [1:0] contador
    );

	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecucion del programa, no esta conectado a ningun puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =
	reg [1:0] conteoAscendente = 2'b00; //Se le da un valor inicial de 0 al vector.
	//2'b00 esta indicando que el valor es de dos (2) numeros (') binarios (b) con valor (00).
	
	//always@() sirve para hacer operaciones matematicas, condicionales o bucles, dentro de su parentesis se deben 
	//poner las entradas que usara y ademas tiene su propio begin y end.
	always@(posedge(frecuenciaReloj))
	//La instruccion posedge() hace que este condicional se ejecute solamente cuando ocurra un flanco de subida en la 
	//entrada frecuenciaReloj, osea cuando pase de valer 0 logico a valer 1 logico, ademas la instruccion posedge() 
	//hara que el codigo se ejecute por si solo sin que yo directamente tenga que indicarlo con una operacion logica.
	begin
		//Es un contador ascendente porque cuenta uno a uno desde cero.
		conteoAscendente = conteoAscendente + 2'b01;
	end
	
	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign.
	assign contador = conteoAscendente;
endmodule
