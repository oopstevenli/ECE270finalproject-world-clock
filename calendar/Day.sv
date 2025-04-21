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