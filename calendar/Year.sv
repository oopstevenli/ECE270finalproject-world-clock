`default_nettype none
module Year (
	input  logic clk,
	input  logic reset,
	input  logic end_of_year,
	input  logic offset,
	output logic [15:0] year,
	output logic leap_year
	);
	logic prev_enable, enable_edge;
    logic prev_offset, offset_edge;
    always_ff @(posedge clk) begin
        prev_enable <= end_of_year;
        prev_offset <= offset;
    end
	always_ff @(posedge clk) begin
		if (reset) begin
			year <= 16'd2025;
		end
		else if (enable_edge || offset_edge) begin
		    if (year > 16'd9999) begin
		        year <= 16'd2025;
		    end
			else begin 
			    year <= year + 1;
			end
		end
	end
	always_comb  leap_year = (((year % 4) == 0) && ((year % 100) != 0)) || ((year % 400) == 0);
    assign enable_edge = end_of_year & ~prev_enable;
    assign offset_edge = offset & ~prev_offset;
endmodule