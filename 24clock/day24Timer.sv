`default_nettype none
module day24Timer(
    input logic clk, en, reset,
    input logic [4:0] offset,
    output logic cycle,
    output logic [4:0] hours
);
logic [5:0] Q, nextQ;
always_ff @(posedge clk or posedge reset) begin
    if (reset) 
        Q <= 5'd0;
    else
        Q <= nextQ;
end
always_comb begin
    nextQ = Q + offset + en;
    if(nextQ > 5'd24) begin
        nextQ = 5'd0;
        cycle = 1'b1;
    end
    else begin
        cycle = 1'b0;
    end
end
assign hours = Q;
endmodule