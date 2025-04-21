`default_nettype none
module changeClock(
    input logic clock, reset, hour_increment, min_increment,
    output logic [4:0] offset_hours, //0-23
    output logic [5:0] offset_mins, //0-59
    output logic [4:0] london_hours,
    output logic [5:0] london_mins); 
    logic prev_min, prev_hour, hour_edge, min_edge;
    always_ff @(posedge clock) begin
        prev_hour <= hour_increment;
        prev_min <= min_increment;
    end
    assign hour_edge = hour_increment && !prev_hour;
    assign min_edge = min_increment && !prev_min;
   
    always_ff @(posedge clock or posedge reset) begin
        if (reset) begin
            offset_hours <= 5'd0;
            offset_mins <= 6'd0;
        end
        else begin 
            if (min_edge) begin
                offset_mins <= (offset_mins == 59) ? 6'd0 : offset_mins + 1;
            end
            if (hour_edge) begin
                offset_hours <= (offset_hours == 23) ? 5'd0 : offset_hours + 1;
            end
        end
    end
    
    always_comb begin
        if (reset) begin
            london_hours = offset_hours + 5;
            london_mins = offset_mins;
        end
        if (min_edge) begin
            london_mins = offset_mins;
        end
        if (hour_edge) begin
            if (offset_hours < 19) begin //0 - 18(inclusive works)
                london_hours = offset_hours + 5;
            end
            else begin
                london_hours = offset_hours - 19; //19 - 23 from original time
            end
        end
    end
endmodule
