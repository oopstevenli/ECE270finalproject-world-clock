`default_nettype none
// Empty top module

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

  // Your code goes here...
  logic calendar_en;
  wire enable_dummy;
  wire [6:0] maxDaydummy;
	or(calendar_en, pb[8], SYNTHESIZED_WIRE_18);
	logic [6:0] SYNTHESIZED_WIRE_0;
	logic [6:0] SYNTHESIZED_WIRE_1;
	logic [6:0] SYNTHESIZED_WIRE_2;
	logic [6:0] SYNTHESIZED_WIRE_3;
	logic [6:0] SYNTHESIZED_WIRE_4;
	logic [6:0] SYNTHESIZED_WIRE_5;
	logic [6:0] SYNTHESIZED_WIRE_6;
	logic [6:0] SYNTHESIZED_WIRE_7;
	logic [6:0] SYNTHESIZED_WIRE_8;
	logic [6:0] SYNTHESIZED_WIRE_9;
	logic [6:0] SYNTHESIZED_WIRE_10;
	logic [6:0] SYNTHESIZED_WIRE_11;
	logic SYNTHESIZED_WIRE_21;
	logic [4:0] SYNTHESIZED_WIRE_13;
	logic [5:0] SYNTHESIZED_WIRE_14;
	logic [4:0] SYNTHESIZED_WIRE_16;
	logic [5:0] SYNTHESIZED_WIRE_17;
	logic SYNTHESIZED_WIRE_18;
	muxModule b2v_inst0(
		.select(~pb[1]),
		.day(SYNTHESIZED_WIRE_0),
		.hour_1(SYNTHESIZED_WIRE_1),
		.hour_2(SYNTHESIZED_WIRE_2),
		.min_1(SYNTHESIZED_WIRE_3),
		.min_2(SYNTHESIZED_WIRE_4),
		.month(SYNTHESIZED_WIRE_5),
		.year_1(SYNTHESIZED_WIRE_6),
		.year_2(SYNTHESIZED_WIRE_7),
		.out_1(SYNTHESIZED_WIRE_8),
		.out_2(SYNTHESIZED_WIRE_9),
		.out_3(SYNTHESIZED_WIRE_10),
		.out_4(SYNTHESIZED_WIRE_11)
	);
	digit2Display b2v_inst1(
		.value(SYNTHESIZED_WIRE_8),
		.left(ss7),
		.right(ss6)
	);
	digit2Display b2v_inst2(
		.value(SYNTHESIZED_WIRE_9),
		.left(ss5),
		.right(ss4)
	);
	digit2Display b2v_inst3(
		.value(SYNTHESIZED_WIRE_10),
		.left(ss3),
		.right(ss2)
	);
	digit2Display b2v_inst4(
		.value(SYNTHESIZED_WIRE_11),
		.left(ss1),
		.right(ss0)
	);
	clock24 b2v_inst5(
		.clk(SYNTHESIZED_WIRE_21),
		.reset(pb[0]),
		.offset_hours(SYNTHESIZED_WIRE_13),
		.offset_mins(SYNTHESIZED_WIRE_14),
		.cycle(SYNTHESIZED_WIRE_18),
		.seconds(left[6:0]),
		.hours(SYNTHESIZED_WIRE_1),
		.minutes(SYNTHESIZED_WIRE_3)
	);
	clock24 b2v_inst6(
		.clk(SYNTHESIZED_WIRE_21),
		.reset(pb[0]),
		.cycle(enable_dummy),
		.offset_hours(SYNTHESIZED_WIRE_16),
		.offset_mins(SYNTHESIZED_WIRE_17),
		.hours(SYNTHESIZED_WIRE_2),
		.seconds(right[6:0]),
		.minutes(SYNTHESIZED_WIRE_4)
	);
	calendar b2v_inst7(
		.hour_enable(calendar_en),
		.clock(hz100),
		.reset(pb[0]),
		.day_increment(pb[2]),
		.year_increment(pb[3]),
		.month_increment(pb[4]),
		.day_binary(SYNTHESIZED_WIRE_0),
		.LeftYear(SYNTHESIZED_WIRE_6),
		.maxDay_binary(maxDaydummy),
		.month_binary(SYNTHESIZED_WIRE_5),
		.RightYear(SYNTHESIZED_WIRE_7)
	);
	changeClock b2v_inst8(
		.clock(SYNTHESIZED_WIRE_21),
		.reset(pb[0]),
		.hour_increment(pb[5]),
		.min_increment(pb[6]),
		.london_hours(SYNTHESIZED_WIRE_16),
		.london_mins(SYNTHESIZED_WIRE_17),
		.offset_hours(SYNTHESIZED_WIRE_13),
		.offset_mins(SYNTHESIZED_WIRE_14)
	);
	clk100HzTo1Hz b2v_inst9(
		.clk100hz(hz100),
		.reset(pb[0]),
		.clk1hz(SYNTHESIZED_WIRE_21)
	);
endmodule

// Add more modules down here...
`default_nettype none
module muxModule(
    input logic select,
    input logic [6:0] hour_1,
    input logic [6:0] min_1,
    input logic [6:0] hour_2,
    input logic [6:0] min_2,
    input logic [6:0] day,
    input logic [6:0] month,
    input logic [6:0] year_1,
    input logic [6:0] year_2,
    output logic [6:0] out_1,
    output logic [6:0] out_2,
    output logic [6:0] out_3,
    output logic [6:0] out_4
);
assign out_1 = select ? hour_1 : day;
assign out_2 = select ? min_1 : month;
assign out_3 = select ? hour_2 : year_1;
assign out_4 = select ? min_2 : year_2;
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
            if (counting == 49) begin
                counting <= 0;
                clk1hz <= ~clk1hz;
            end else begin
                counting <= counting + 1;
        end
    end
end
endmodule

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


`default_nettype none
module clock24 (
	input  logic clk,
	input  logic reset,
	input  logic [4:0] offset_hours,
	input  logic [5:0] offset_mins,
	output logic cycle,
	output logic [6:0] hours,
	output logic [6:0] minutes,
	output logic [6:0] seconds
	);
	logic fullMin;
	logic fullHour;
	sec60Timer inst0(
		.clk(clk),
		.reset(reset),
		.cycle(fullMin),
		.seconds(seconds)
	);
	min60Timer inst1(
		.clk(clk),
		.en(fullMin),
		.reset(reset),
		.offset(offset_mins),
		.cycle(fullHour),
		.mins(minutes)
	);
	day24Timer inst2(
		.clk(clk),
		.en(fullHour),
		.reset(reset),
		.offset(offset_hours),
		.cycle(cycle),
		.hours(hours)
	);
endmodule

`default_nettype none
module day24Timer(
    input logic clk, en, reset,
    input logic [4:0] offset,
    output logic cycle,
    output logic [6:0] hours
);
logic [6:0] Q, nextQ;
always_ff @(posedge clk or posedge reset) begin
    if (reset) 
        Q <= 7'd0;
    else
        Q <= nextQ;
end
always_comb begin
    nextQ = Q + {2'b0, offset} + {6'b0, en};
    if(nextQ > 7'd24) begin
        nextQ = 7'd0;
        cycle = 1'b1;
    end
    else begin
        cycle = 1'b0;
    end
end
assign hours = Q;
endmodule


`default_nettype none
module min60Timer(
    input logic clk, en, reset,
    input logic [5:0] offset,
    output logic cycle,
    output logic [6:0] mins
);
logic [6:0] Q, nextQ;
always_ff @(posedge clk or posedge reset) begin
    if (reset) 
        Q <= 7'd0;
    else
        Q <= nextQ;
end
always_comb begin
    nextQ = Q + {1'b0, offset} + {6'b0, en};
    if(nextQ > 7'd59) begin
        nextQ = 7'd0;
        cycle = 1'b1;
    end
    else begin
        cycle = 1'b0;
    end
end
assign mins = Q;
endmodule


`default_nettype none
module sec60Timer(
    input logic clk, reset,
    output logic cycle,
    output logic [6:0] seconds
);
logic [6:0] Q, nextQ;
always_ff @(posedge clk or posedge reset) begin
    if(reset) 
        Q <= 7'd0;
    else
        Q <= nextQ;
end
always_comb begin
    if(Q == 7'd59) begin
        cycle = 1'b1;
        nextQ = 7'd0;
    end
    else begin
        nextQ = Q + 1;
        cycle = 1'd0;
    end
end
assign seconds = Q;
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
