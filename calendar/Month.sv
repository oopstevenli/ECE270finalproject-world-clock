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