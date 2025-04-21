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
