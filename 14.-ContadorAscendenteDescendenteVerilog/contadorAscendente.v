//2.-CONTADOR DE 2 BITS:
//En este c�digo el contador es de 2 bits, esto implica que contar� desde el cero hasta el 3 en forma binaria:
//00, 01, 10 y 11
//Estos n�meros binarios en el m�dulo siguiente representar�n al selector y el selector lo que har� es guardar en el 
//reg digito (del siguiente m�dulo tambi�n) 4 n�meros binarios que representen 1 d�gito hexadecimal, este barrido
//se debe hacer en �rden y con la frecuencia dictada por el divisorDeReloj para prender individualmente cada display 
//de 7 segmentos, se declara que el contador sea de 2 bits porque como en la NEXYS 2 hay 4 displays de 7 segmentos, lo 
//que yo quiero es que durante un ciclo de reloj todos los displays sean encendidos una vez, mostrando cada d�gito del 
//n�mero hexadecimal que corresponda al n�mero binario que est� introduciendo por medio de switches, puedo hacer esto 
//con 2 bits porque cuando el selector adopte los valores 00, 01, 10 y 11 prender� una vez cada d�gito en uno de los 
//4 displays de 7 segmentos durante cada ciclo de reloj

module contadorSelector(
    input clkNexys2, //Este es el reloj proveniente del m�dulo divisorDeReloj
	 input Reset, //Bot�n de reset
	 input Direccion, //Bot�n que fija si el contador es acendente o descendente
    output [3:0] contador //Contador de 4 bits, desde cero hasta el 15 en binario
    );

	//REG: Existe solo en Verilog y sirve para almacenar datos que se puedan usar dentro de un condicional o bucle, solo 
	//sobrevive durante la ejecuci�n del programa, no est� conectado a ning�n puerto de la tarjeta de desarrollo y se le 
	//asignan valores con el simbolo =
	reg [3:0] conteoAscendenteDescendente = 4'b0000; //Se le da un valor inicial de 0 al vector
	//4'b0000 est� indicando que el valor es de cuatro (4) n�meros (') binarios (b) con valor (0000)
	
	//always@() sirve para hacer operaciones matem�ticas, condicionales o bucles, dentro de su parpentesis se deben 
	//poner las entradas que usar� y adem�s tiene su propio begin y end
	always@(posedge(clkNexys2))
	//La instrucci�n posedge() hace que este condicional se ejecute solamente cuando ocurra un flanco de subida en la 
	//entrada clkNexys2, osea cuando pase de valer 0 l�gico a valer 1 l�gico, adem�s la instrucci�n posedge() 
	//har� que el c�digo se ejecute por s� solo sin que yo directamente tenga que indicarlo con una operaci�n l�gica
	begin
		//Cuando el push button reset est� presionado valdr� un 1 l�gico y reiniciar� el conteo de la signal 
		//conteoAscendenteDescendente, para poner una operaci�n l�gica de igualdad en Verilog se debe poner dos signos 
		//de igual ==
		if(Reset == 1'b1) begin
		//Si reset est� presionado el conteoAscendenteDescendente podr� adoptar dos posibles valores dependiendo de si
		//el switch de direcci�n vale 1 l�gico (est� encendido) o 0 l�gico (est� apagado)
			if(Direccion == 1'b0) begin
				conteoAscendenteDescendente = 4'b0000;
			end else begin
				conteoAscendenteDescendente = 4'b1111;
			end
		end else if (Direccion == 1'b1) begin
			//Si el switch de direcci�n est� encendido el conteo ser� ascendente
			conteoAscendente = conteoAscendente - 4'b1111;
		end else begin 
			//Si el switch de direcci�n est� apagado el conteo ser� descendente
			conteoAscendente = conteoAscendente + 4'b1111;
		end
	end
	
	//En Verilog para poder asignar el valor de un reg a una salida debo usar la palabra reservada assign
	assign contador = conteoAscendente;
	
endmodule
