module main_tb();
	localparam STIMULUS_SIZE = 16; // Two 8-bit operands
	localparam RESULTS_SIZE = 8*7; // 8 7-segment displays
	localparam NUM_TEST_CASES = 100;

	reg [17:0] SW;
	wire [6:0] HEX [0:7];
	
	reg [STIMULUS_SIZE-1:0] stimulus [0:NUM_TEST_CASES-1];
	reg [RESULTS_SIZE-1:0] results [0:NUM_TEST_CASES-1];
	integer i, error_count;
	
	main dut (.SW(SW), .HEX7(HEX[7]), .HEX6(HEX[6]), .HEX5(HEX[5]), .HEX4(HEX[4]), .HEX3(HEX[3]), .HEX2(HEX[2]), .HEX1(HEX[1]), .HEX0(HEX[0]));

	// Task that provides the input to and verifies the output of the DUT for the test vector index i
	task perform_test(input integer i);
		reg [RESULTS_SIZE-1:0] output_vector;
		reg [6:0] out [0:7];
		integer j;
	begin
		SW = {1'b0, stimulus[i][STIMULUS_SIZE-1:STIMULUS_SIZE/2], 1'b0, stimulus[i][STIMULUS_SIZE/2-1:0]};
		#10;
		output_vector = {HEX[7], HEX[6], HEX[5], HEX[4], HEX[3], HEX[2], HEX[1], HEX[0]};
		if( output_vector !== results[i] ) begin
			error_count = error_count + 1;
			{out[7], out[6], out[5], out[4], out[3], out[2], out[1], out[0]} = results[i];
			$display("ERROR: Test %0d incorrect.", i);
			for( j = 0; j < 8; j = j + 1 ) begin
				if( out[j] !== HEX[j] ) begin
					$display("   HEX%0d: Expected %b and got %b", j, out[j], HEX[j]);
				end
			end
		end
	end
	endtask

	initial begin
		// Initialize variables
		SW = 0;
		error_count = 0;
	
		// Load the stimulus and result values
		$readmemh("lab2_stimulus.dat", stimulus);
		$readmemh("lab2_results.dat", results);

		$display("INFO: Starting tests.");

		// Run all test cases
		for( i = 0; i < NUM_TEST_CASES; i = i + 1 ) begin
			perform_test(i);
		end

		// Display test results
		if( error_count != 0 ) begin
			$display("SUMMARY: %d test cases had errors in simulation.", error_count);
		end
		else begin
			$display("SUMMARY: No errors detected in simulation.");
		end
		
		$display("SUMMARY: Simulation complete.");
		
		$stop;
	end
endmodule
