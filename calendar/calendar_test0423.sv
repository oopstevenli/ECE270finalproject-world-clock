`default_nettype none

// Top module
module top (
  // I/O ports
  input  logic hz100, reset,
  input  logic [20:0] pb,
  output logic [7:0] left, right,
         ss7, ss6, ss5, ss4, ss3, ss2, ss1, ss0,
  output logic red, green, blue,

  // UART ports
  output logic [7:0] txdata,
  input  logic [7:0] rxdata,
  output logic txclk, rxclk,
  input  logic txready, rxready
);
  //dummy wires
  wire [6:0] maxDay_binary_dummy;
  wire [6:0] LeftYear_dummy;
  // Internal signals
  logic clk1hz;
  logic [6:0] day_bin, month_bin, year_bin;

  // Submodule: calendar
  calendar u_calendar (
    .reset(pb[0]),
    .day_increment(pb[1]),
    .year_increment(pb[2]),
    .month_increment(pb[3]),
    .clock(hz100),
    .hour_enable(pb[4]),
    .maxDay_binary(maxDay_binary_dummy),
    .LeftYear(LeftYear_dummy),
    .day_binary(day_bin),
    .month_binary(month_bin),
    .RightYear(year_bin)
  );

  // Submodules: digit2Display for day, month, year
  digit2Display u_day_display (
    .value(day_bin),
    .left(ss5),
    .right(ss4)
  );

  digit2Display u_month_display (
    .value(month_bin),
    .left(ss3),
    .right(ss2)
  );

  digit2Display u_year_display (
    .value(year_bin),
    .left(ss1),
    .right(ss0)
  );

  // Submodule: clk100HzTo1Hz
  clk100HzTo1Hz u_clk_divider (
    .reset(pb[0]),
    .clk100hz(hz100),
    .clk1hz(clk1hz)
  );
  
  

endmodule
`default_nettype none
module calendar (
	input  logic hour_enable,
		input  logic clock,
	input  logic reset,
	input  logic day_increment,
	input  logic year_increment,
	input  logic month_increment,
	output logic [6:0] day_binary,
	output logic [6:0] maxDay_binary,
	output logic [6:0] month_binary,
	output logic [6:0] LeftYear,
	output logic [6:0] RightYear
	);
	logic [15:0] a;
	logic [3:0] b;
	logic [5:0] c;
	logic end_of_month;
	logic end_of_year;
	logic [5:0] l;
	logic SYNTHESIZED_WIRE_0;
	Day b2v_inst0(
		.clk(clock),
		.enable(hour_enable),
		.offset(day_increment),
		.leap_year(SYNTHESIZED_WIRE_0),
		.reset(reset),
		.month(b),
		.end_of_month(end_of_month),
		.day(c),
		.max_days(l)
	);
	Month b2v_inst1(
		.clk(clock),
		.reset(reset),
		.end_of_month(end_of_month),
		.offset(month_increment),
		.end_of_year(end_of_year),
		.month(b)
	);
	Year b2v_inst2(
		.clk(clock),
		.reset(reset),
		.end_of_year(end_of_year),
		.offset(year_increment),
		.leap_year(SYNTHESIZED_WIRE_0),
		.year(a)
	);
	splitYear b2v_inst3(
		.year_binary(a),
		.leftNum(LeftYear),
		.rightNum(RightYear)
	);
	assign day_binary = {1'b0, c};
	assign maxDay_binary = {1'b0, l};
	assign month_binary = {3'b000, b};
endmodule
`default_nettype none
module Day(
    input logic clk, enable, offset, leap_year, reset,
    input logic [3:0] month,
    output logic [5:0] day,
    output logic [5:0] max_days,
    output logic end_of_month);
    numDays daylook(.month(month), .leap_year(leap_year), .days(max_days));
    logic prev_enable, enable_edge;
    logic prev_offset, offset_edge;
    always_ff @(posedge clk) begin
        prev_enable <= enable;
        prev_offset <= offset;
    end
    always_ff @(posedge clk) begin
        if (reset) begin
            day <= 6'd1;
            end_of_month <= 0;
        end
        else if (enable_edge || offset_edge) begin
            if (day >= max_days) begin
                day <= 6'd1;
                end_of_month <= enable_edge;
            end
            else begin
                day <= day + 1;
                end_of_month <= 0;
            end
        end
    end
    assign enable_edge = enable & ~prev_enable;
    assign offset_edge = offset & ~prev_offset;
endmodule

`default_nettype none
module Month(
    input logic clk, reset, end_of_month, offset,
    output logic end_of_year,
    output logic [3:0] month);
     logic prev_enable, enable_edge;
    logic prev_offset, offset_edge;
    always_ff @(posedge clk) begin
        prev_enable <= end_of_month;
        prev_offset <= offset;
    end
    always_ff @(posedge clk) begin
        if (reset) begin
            month <= 4'd1; //January
            end_of_year <= 0;
        end
        else if (enable_edge || offset_edge) begin
            if (month >= 4'd12) begin
                month <= 4'd1; //Back to January
                end_of_year <= enable_edge;
            end
            else begin
                month <= month + 1;
                end_of_year <= 0;
            end
        end
    end
    assign enable_edge = end_of_month & ~prev_enable;
    assign offset_edge = offset & ~prev_offset;
endmodule

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

`default_nettype none
module numDays(
    input logic [3:0] month,
    input logic leap_year,
    output logic [5:0] days);
    always_comb begin
        case (month)
            4'd1:  days = 6'd31; // January
            4'd2:  days = leap_year ? 6'd29 : 6'd28; // February
            4'd3:  days = 6'd31; // March
            4'd4:  days = 6'd30; // April
            4'd5:  days = 6'd31; // May
            4'd6:  days = 6'd30; // June
            4'd7:  days = 6'd31; // July
            4'd8:  days = 6'd31; // August
            4'd9:  days = 6'd30; // September
            4'd10: days = 6'd31; // October
            4'd11: days = 6'd30; // November
            4'd12: days = 6'd31; // December
            default: days = 6'd0; // Invalid month
        endcase
    end
endmodule

`default_nettype none
module splitYear(
    input logic [15:0] year_binary,
    output logic [6:0] leftNum, rightNum);
    logic [15:0] temp_leftNum, temp_rightNum;
    always_comb begin
        temp_leftNum = (year_binary / 100);
        temp_rightNum = (year_binary % 100); //0-9
        leftNum = temp_leftNum[6:0];
        rightNum = temp_rightNum[6:0];
    end
endmodule

`default_nettype none
module digit2Display (
    input  logic [6:0] value,
    output logic [7:0] left,
    output logic [7:0] right
);
    logic [3:0] tens, ones;
    logic [6:0] temp_tens, temp_ones;
    always_comb begin
        temp_tens = value / 10;
        temp_ones = value % 10;
        tens = temp_tens[3:0];
        ones = temp_ones[3:0];
    end
    function automatic [7:0] seg_decode(input logic [3:0] digit);
        case (digit)
            4'd0: seg_decode = 8'b00111111;
            4'd1: seg_decode = 8'b00000110;
            4'd2: seg_decode = 8'b01011011;
            4'd3: seg_decode = 8'b01001111;
            4'd4: seg_decode = 8'b01100110;
            4'd5: seg_decode = 8'b01101101;
            4'd6: seg_decode = 8'b01111101;
            4'd7: seg_decode = 8'b00000111;
            4'd8: seg_decode = 8'b01111111;
            4'd9: seg_decode = 8'b01101111;
            default: seg_decode = 8'b00000000;
        endcase
    endfunction
    always_comb begin
        left  = seg_decode(tens);
        right = seg_decode(ones);
    end
endmodule

`default_nettype none
module clk100HzTo1Hz(
    input logic reset,
    input logic clk100hz,
    output logic clk1hz
);
    logic [6:0] counting;
    always_ff @(posedge clk100hz or posedge reset) begin
        if (reset) begin
            counting <= 0;
            clk1hz <= 0;
        end else begin
            if (counting == 99) begin
                counting <= 0;
                clk1hz <= ~clk1hz;
            end else begin
                counting <= counting + 1;
        end
    end
end
endmodule
