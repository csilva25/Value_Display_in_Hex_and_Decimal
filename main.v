
module main (input [17:0] SW, output [6:0] HEX7, HEX6, HEX5, HEX4, HEX3, HEX2, HEX1, HEX0);
wire [8:0]sum_output;
wire [3:0] a,b,c,d,hun_o,ten_o,one_o;

	hex_converter hex (.a(SW[12:9]), .hex(a));
	converter_7s seven_seg_display1 (.a(a), .display(HEX6));
	hex_converter hex1(.a(SW[16:13]), .hex(b));
	converter_7s seven_seg_display2(.a(b), .display(HEX7));
	hex_converter hex3 (.a(SW[3:0]), .hex(c));
	converter_7s seven_seg_display3 (.a(c), .display(HEX4));
	hex_converter hex4(.a(SW[7:4]), .hex(d));
	converter_7s seven_seg_display4(.a(d), .display(HEX5));

	
	adder_8b adder1(.a(SW[7:0]), .b(SW[16:9]),.carry_in(1'b00),.sum(sum_output[7:0]), .carry_out(sum_output[8]));
	bcd_converter converter(.value(sum_output[8:0]),  .hund(hun_o), .tens(ten_o), .ones(one_o));
	converter_7s seven_seg_display5 (.a(one_o), .display(HEX0));
	converter_7s seven_seg_display6(.a(ten_o), .display(HEX1));
	converter_7s seven_seg_display7 (.a(hun_o), .display(HEX2));
	converter_7s seven_seg_display8 (.a(4'b0000), .display(HEX3));
	
	
endmodule

module converter_7s(input [3:0] a , output reg [6:0] display );
	always@(a) begin
		case (a)
			4'b0000 : display = 7'b1000000; //0
			4'b0001 : display = 7'b1111001; //1
			4'b0010 : display = 7'b0100100; //2
			4'b0011 : display = 7'b0110000; //3
			4'b0100 : display = 7'b0011001; //4
			4'b0101 : display = 7'b0010010; //5
			4'b0110 : display = 7'b0000010; //6
			4'b0111 : display = 7'b1111000; //7
			4'b1000 : display = 7'b0000000; //8
			4'b1001 : display = 7'b0010000; //9
			4'b1010 : display = 7'b0001000; //10 / A
			4'b1011 : display = 7'b0000011; //11 / B
			4'b1100 : display = 7'b1000110; //12 / C
			4'b1101 : display = 7'b0100001; //13 / D
			4'b1110 : display = 7'b0000110; //14 / E
			4'b1111 : display = 7'b0001110; //15 / F
		endcase
	end
endmodule

module hex_converter (input [3:0] a, output reg [3:0]  hex);

	always @(a) begin
		case (a)
			4'b0000 : hex = 4'h0;
			4'b0001 : hex = 4'h1;
			4'b0010 : hex = 4'h2;
			4'b0011 : hex = 4'h3;
			4'b0100 : hex = 4'h4;
			4'b0101 : hex = 4'h5;
			4'b0110 : hex = 4'h6;
			4'b0111 : hex = 4'h7;
			4'b1000 : hex = 4'h8;
			4'b1001 : hex = 4'h9;
			4'b1010 : hex = 4'hA;
			4'b1011 : hex = 4'hB;
			4'b1100 : hex = 4'hC;
			4'b1101 : hex = 4'hD;
			4'b1110 : hex = 4'hE;
			4'b1111 : hex = 4'hF;
		endcase
	end
endmodule
	
