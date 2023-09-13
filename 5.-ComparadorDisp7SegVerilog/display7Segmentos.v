//Ver el codigo del archivo demuxMuxComparador porque aqui se va a hacer una comparacion.
module display7Segmentos(
    output reg [3:0] AN,
	 //El vector AN sirve para elegir cuales de los 4 displays de 7 segmentos que tiene la 
	 //FPGA se van a activar. Los displays se prenden mandando un 0 logico.
    output reg CA,
    output reg CB,
    output reg CC,
    output reg CD,
    output reg CE,
    output reg CF,
    output reg CG,//En verilog cuando use una salida en un condicional, lo debo declarar como reg
	 //Estas salidas lo que van a hacer es prender los mismos leds en todos los displays activados, 
	 //osea mostrar el mismo numero o letra.
    output reg DP,
	 //Esto va a prender el led del punto de todos los displays activados.
	 //Todos los leds de los displays se prenden mandando un 0 logico porque son de nodo comun.
    input [3:0] A,
    input [3:0] B
	 //Estos son los vectores con numeros binarios (o bits) que vamos a comparar y van a ser 
	 //entradas por medio de switches.
    );

//Dentro del always (que sirve para poder usar condicionales) debo poner las entradas que vaya a usar.
always@(A or B)
	begin//always tiene su propio begin y end.
		if(A>B) 
			begin//En los condicionales se pone begin y end cuando se vaya a dar valor a mas de una salida.
				AN=4'b1110;//Solo el 4to display esta encendido
				CA=1'b1;//Led A del display apagado
				CB=1'b1;//Led B del display apagado
				CC=1'b0;//Led C del display ENCENDIDO
				CD=1'b0;//Led D del display ENCENDIDO
				CE=1'b1;//Led E del display apagado
				CF=1'b1;//Led F del display apagado
				CG=1'b0;//Led G del display ENCENDIDO
				//Todos estos leds prendidos estan representando un signo de mayor que >.
				DP=1;//El punto del display esta apagado.
			end
		else if(A<B)
			begin
				AN=4'b0111;//Solo el 1er display esta encendido
				CA=1'b1;//Led A del display apagado
				CB=1'b1;//Led B del display apagado
				CC=1'b1;//Led C del display apagado
				CD=1'b0;//Led D del display ENCENDIDO
				CE=1'b0;//Led E del display ENCENDIDO
				CF=1'b1;//Led F del display apagado
				CG=1'b0;//Led G del display ENCENDIDO
				//Todos estos leds prendidos estan representando un signo de menor que <.
				DP=1'b1;//El punto del display esta apagado.
			end
		else if(A==B)
			begin
				AN=4'b1001;//El 2do y 3er display estan encendidos
				CA=1'b1;//Led A del display apagado
				CB=1'b1;//Led B del display apagado
				CC=1'b1;//Led C del display apagado
				CD=1'b0;//Led D del display ENCENDIDO
				CE=1'b1;//Led E del display apagado
				CF=1'b1;//Led F del display apagado
				CG=1'b0;//Led G del display ENCENDIDO
				//Todos estos leds prendidos estan representando dos signos de igual ==.
				DP=1'b1;//El punto del display esta apagado.
			end
		else if(A>=B)
			begin
				AN=4'b0111;//Solo el 1er display esta encendido
				CA=1'b0;//Led A del display ENCENDIDO
				CB=1'b1;//Led B del display apagado
				CC=1'b1;//Led C del display apagado
				CD=1'b0;//Led D del display ENCENDIDO
				CE=1'b1;//Led E del display apagado
				CF=1'b0;//Led F del display ENCENDIDO
				CG=1'b0;//Led G del display ENCENDIDO
				//Todos estos leds prendidos estan representando un signo de mayor o igual que >=.
				DP=1'b1;//El punto del display esta apagado.
			end
		else if(A!=B)
			begin
				AN=4'b0000;//Todos los displays estan encendidos
				CA=1'b1;//Led A del display apagado
				CB=1'b1;//Led B del display apagado
				CC=1'b0;//Led C del display ENCENDIDO
				CD=1'b1;//Led D del display apagado
				CE=1'b1;//Led E del display apagado
				CF=1'b0;//Led F del display ENCENDIDO
				CG=1'b0;//Led G del display ENCENDIDO
				//Todos estos leds prendidos estan representando un signo de diferente que !=.
				DP=1'b0;//El punto del display esta encendido.
			end
		else//La ultima condicion siempre debe ser un else			
			begin	
				AN=4'b1110;//Solo el 4to display esta encendido
				CA=1'b0;//Led A del display ENCENDIDO
				CB=1'b0;//Led B del display ENCENDIDO
				CC=1'b1;//Led C del display apagado
				CD=1'b0;//Led D del display ENCENDIDO
				CE=1'b1;//Led E del display apagado
				CF=1'b1;//Led F del display apagado
				CG=1'b0;//Led G del display ENCENDIDO
				//Todos estos leds prendidos estan representando un signo de menor o igual que <=.
				DP=1'b1;//El punto del display esta apagado.
			end
	end
endmodule
