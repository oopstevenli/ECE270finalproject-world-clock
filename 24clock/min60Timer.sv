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
