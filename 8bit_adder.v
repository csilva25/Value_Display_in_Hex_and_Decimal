
module adder_8b( a, b, carry_in, sum, carry_out);

//Assign the inputs and outputs w/ range [7:0] for 8bits
input carry_in;
input [7:0] a;
input [7:0] b;
output [7:0] sum;
output carry_out; //Very las output "carry_out" wont have ranges [7:0]
wire [8:0] temp; //
	assign temp = a+b+carry_in; //Inputs only
	assign sum = temp [7:0];//
	assign carry_out = temp [8];//Assigns very last wire as carry_out
	

endmodule


