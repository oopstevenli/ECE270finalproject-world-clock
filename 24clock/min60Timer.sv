`default_nettype none
module min60Timer(
    input logic clk, en, reset,
    input logic [5:0] offset,
    output logic cycle,
    output logic [5:0] mins
);
logic [5:0] Q, nextQ;
always_ff @(posedge clk or posedge reset) begin
    if (reset) 
        Q <= 6'd0;
    else
        Q <= nextQ;
end
always_comb begin
    nextQ = Q + offset + en;
    if(nextQ > 6'd59) begin
        nextQ = 6'd0;
        cycle = 1'b1;
    end
    else begin
        cycle = 1'b0;
    end
end
assign mins = Q;
endmodule