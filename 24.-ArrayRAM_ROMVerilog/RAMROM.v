//1.-Memorias RAM y ROM: A la informacin guardada en una memoria se le llama datos (data). Cuando escribimos 
//en una memoria, la accin es de escritura (write) y cuando obtenemos informacin de una memoria lo que 
//hacemos es leerla (read). Para acceder a la informacin requerimos de una direccin (address).
//A las memorias ROM (Read Only Memory) solo se les puede leer sus datos, mientras que a las memorias RAM
//(Random Access Memory) se les puede leer o escribir datos cuando sea.
//En este caso se creara una memoria de 8 registros (filas) con 8 celdas (columnas) cada uno, por lo que tendra 
//una capacidad de 8x8 = 64 bits = 8 bytes, por lo que necesitara un memory adress de 3 bits para que pueda 
//contar de 0 a 8.

module memoriaRAM_ROM(
	 input clk,						//Reloj de 50MHz proporcionado por la NEXYS 2 en el puerto B8.
	 //Las acciones de la memoria pueden ser sincronas: Siguen el paso de la senal de reloj.
	 //O pueden ser asincronas: Se ejecutan en cualquier momento no importando la senal de reloj.
	 input [2:0] adressBus,		//Direccion de memoria.
	 input RW,						//Switch RW (Read/Write) para escribir o leer la memoria RAM.
	 //Con RW = 1 se puede leer el contenido de ambas memorias, con RW = 0 se escribe en la RAM.
    input [7:0] dataInRAM,		//Bus de datos ingresados a la memoria RAM.
	 input CS,						//CS (Chip Selector) para saber si la salida es de la RAM o ROM.
	 //Con CS = 1 se elige leer el contenido de la ROM, con CS = 0 se lee el contenido de la RAM.
    output reg [7:0] dataBus	//Bus de datos extraidos de la memoria RAM.
	 //En Verilog todas las salidas que se vaya a usar en los condicionales debo declararlas como reg, osea 
	 //Register, los tipos de salidas reg lo que van a hacer es almacenar valores temporalmente.
    );
	
	//Antes del always pero dentro del modulo es donde se declaran las variables de tipo 
	//reg e integer que interactuan con los condicionales o bucles.
	//Con una unica linea de codigo se puede declarar un array tipo matriz de 8 elementos, cada uno con 
	//longitud de 8 bits, hay que tomar en cuenta que los bits se cuentan de 7 a 0, pero las posiciones del 
	//array se cuentan de 1 a 8, esto se realiza con la siguiente nomenclatura:
	//tipoDeDato	[tamanoElementos] nombreTipoDeDato	[numeroDeElementos];
	reg [7:0] ROM [1:8];
	initial begin
	  ROM[1] <= 8'b00000000;
	  ROM[2] <= 8'b00000001;
	  ROM[3] <= 8'b00000010;
	  ROM[4] <= 8'b00000011;
	  ROM[5] <= 8'b00000100;
	  ROM[6] <= 8'b00000101;
	  ROM[7] <= 8'b00000110;
	  ROM[8] <= 8'b00000111;
	end
	//REG: No es ni una entrada ni una salida porque no puede estar vinculada a ningun puerto de la NEXYS 2, 
	//solo existe durante la ejecucion del codigo y sirve para poder almacenar algun valor de forma temporal.
	//En las memorias RAM, como se les puede escribir o leer datos, se declara como signal.
	//No hay una forma de declarar un array constante para la ROM, por eso igual se declara como reg.
	reg [7:0] RAM [1:8];
	initial begin
	  ROM[1] <= 8'b00000000;
	  ROM[2] <= 8'b10000001;
	  ROM[3] <= 8'b01000010;
	  ROM[4] <= 8'b11000011;
	  ROM[5] <= 8'b00100100;
	  ROM[6] <= 8'b10100101;
	  ROM[7] <= 8'b01100110;
	  ROM[8] <= 8'b11100111;
	end
	//Se usan reg adicionales para guardar temporalmente el contenido de las memorias.
	reg [7:0] dataOutROM;	//Bus de datos extraidos de la memoria ROM.
	reg [7:0] dataOutRAM; 	//Bus de datos extraidos de la memoria RAM.
	
	//La obtencion de datos de la memoria ROM es sincrona porque depende de la senal de reloj, no es asi en
	//todas las memorias RAM o ROM, puede ser como sea, pero aqui se hace asi para mostrar sus diferencias.
	//always@ se usa para poder usar condicionales o bucles y tiene su propio begin y end.
	//POSEDGE: La instruccion posedge() solo puede tener una entrada o reg dentro de su parentesis 
	//y a fuerza se debe declarar en el parentesis del always@(), ademas hace que los condicionales 
	//o bucles que esten dentro del always@() se ejecuten por si solos cuando ocurra un flanco de 
	//subida en la entrada que tiene posedge() dentro de su parentesis, el flanco de subida ocurre 
	//cuando la entrada pasa de valer 0 logico a valer 1 logico y el hecho de que la instruccion 
	//posedge() haga que el codigo se ejecute por si solo significa que yo directamente no debo 
	//indicarlo con una operacion logica en el parentesis de los condicionales o bucles, si lo hago 
	//el programa me arrojara error, aunque si quiero que se ejecute una accion en especifico cuando 
	//se de el flanco de subida en solo una de las entradas que usan posedge(), debo meter el nombre 
	//de esa entrada en el parentesis del condicional o bucle, tambien si uso un posedge, todas las 
	//entradas deben ser activadas igual por un posedge.
	//Si se quisiera ejecutar esta accion con el flanco de bajada de la senal de reloj se debe 
	//usar la instruccion negedge().
	always@(posedge(clk)) begin
		//La instruccion posedge() hace que este condicional solo se ejecute cuando ocurra un flanco de 
		//subida en la senal de reloj clk proveniente de la NEXYS 2.
		//$unsigned(): Metodo que convierte un numero binario en uno entero. Ademas, cabe mencionar que
		//a esta conversion se le suma un 1 porque para acceder a las posiciones de un array se cuenta 
		//desde 1, no desde 0.
		dataOutROM = ROM[$unsigned(adressBus)+1];		//Lectura de la memoria ROM.
	end
	
	//La lectura y escritura de datos en la memoria RAM es asincrona porque NO depende de la senal de reloj.
	always@(RW or dataInRAM or adressBus) begin
		//Si el switch RW esta en 1 logico, la memoria es de lectura, sino es de escritura.
		if (RW == 1'b1) begin
			dataOutRAM = RAM[$unsigned(adressBus)+1];	//Lectura de la memoria RAM.
		end else begin
			RAM[$unsigned(adressBus)+1] = dataInRAM;	//Escritura de la memoria RAM.
			dataOutRAM = RAM[$unsigned(adressBus)+1];	//Lectura de la memoria RAM.
		end
	end
	
	always@(CS or dataOutROM or dataOutRAM) begin
		//Si el switch RW esta en 1 logico, el data bus muestra la salida de la memoria ROM, sino muestra la 
		//salida de la memoria RAM.
		if (CS == 1'b1)
		//Para asignar el valor de un reg a una salida se usa la palabra reservada assign.
			dataBus = dataOutROM;
		else 
			dataBus = dataOutRAM;
	end
endmodule
