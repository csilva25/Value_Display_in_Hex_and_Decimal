/*
 * Cristian Silva
 * Luis D. Avina
 * EECE 343, Fall 2016
 * Lab 2
 */
module bcd_converter_tb();
	wire [3:0] hund, tens, ones;
	integer error_count, i;

	 bcd_converter dut(.value(i[8:0]), .hund(hund), .tens(tens), .ones(ones));

	task perform_test(input integer i);
	reg [8:0] result;
	
	//Major part of testbench...............
	begin
	     #10;
		
	result= ones%10 + 10*(tens%10) + 100*(hund%10); 
		  
		  
		  
		if( i[8:0] !== result ) begin
			error_count = error_count + 1;
			$display("ERROR: Incorrect result for test %d ",i  );
			$display("Expected %b but results were %b",i[8:0] , result); 
		end
	end
	endtask

	initial begin
	
		error_count = 0;
		
		
		
		
		$display("INFO: Performing exhaustive input tests.");
		for( i = 0; i < 511; i = i + 1 ) begin
			
			perform_test(i);
		end
		
		if( error_count != 0 ) begin
			$display("SUMMARY: %d total errors in simulation.", error_count);
		end
		else begin
			$display("SUMMARY: No errors detected in simulation.");
		end
		
		$display("SUMMARY: Simulation complete.");
		
		$stop;
	end
endmodule
