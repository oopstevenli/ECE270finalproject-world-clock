`default_nettype none
module clk_12m_1hz (
    input  logic clk12m,
    input  logic reset,
    output logic clk1hz
);
    parameter integer DIVISOR = 12_000_000;
    logic [$clog2(DIVISOR)-1:0] counter = 0;
    always_ff @(posedge clk12m or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk1hz  <= 0;
        end else begin
            if (counter == DIVISOR / 2 - 1) begin
                clk1hz <= ~clk1hz;
                counter <= 0;
            end else begin
                counter <= counter + 1;
            end
        end
    end
endmodule