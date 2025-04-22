`default_nettype none
module changeClock (
	input  logic clock,
	input  logic reset,
	input  logic hour_increment,
	input  logic min_increment,
	output logic [4:0] offset_hours,
	output logic [5:0] offset_mins,
	output logic [4:0] london_hours,
	output logic [5:0] london_mins
	);

	logic prev_min;
	logic prev_hour;
	logic hour_edge;
	logic min_edge;
	logic prev_reset;
	logic reset_edge;
	always_ff @(posedge clock) begin
		prev_hour <= hour_increment;
		prev_min <= min_increment;

	end

	always_ff @(posedge clock or posedge reset) begin
		if (reset) begin
			offset_hours <= 5'd0;
			offset_mins <= 6'd0;
			london_hours <= 5'd5;
			london_mins <= 6'd0;
		end
		else begin
			if (min_edge) begin
				offset_mins <= (offset_mins == 6'd59 ? 6'd0 : offset_mins + 6'd1);
				london_mins <= (london_mins == 6'd59 ? 6'd0 : london_mins + 6'd1);
            end
            else begin
                offset_mins <= 6'd0;
                london_mins <= 6'd0;
            end
			if (hour_edge) begin
				offset_hours <= (offset_hours == 5'd23 ? 5'd0 : offset_hours + 5'd1);
				//if (london_hours == 5'd0) begin
				//    london_hours <= 5'd5;
				//end
				//else begin 
				    london_hours <= (london_hours == 5'd23 ? 5'd0 : london_hours + 5'd1);
                //end
           end
            else begin
                offset_hours <= 5'd0;
                london_hours <= 5'd0;
            end
		end 
	end
	
	assign hour_edge = hour_increment && !prev_hour;
	assign min_edge = min_increment && !prev_min;

	
endmodule
