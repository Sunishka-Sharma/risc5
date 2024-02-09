module Data_Memory (A, WD, clk, WE, RD,rst);

input [31:0] A, WD;
input clk, WE, rst;

output [31:0] RD;
reg [31:0] Data_MEM [1023:0];


//read
//assign RD = (WE == 1'b0) ? Data_MEM[A] : 32'h00000000;

//write
always @(posedge clk) begin
    if(WE)
        begin
            Data_MEM[A] <= WD;
        end

end
assign RD = (~rst) ? 32'd0 : Data_MEM[A];
initial begin
     Data_MEM[28]=32'h00000020;
     Data_MEM[40]=32'h00000002;
end
endmodule
