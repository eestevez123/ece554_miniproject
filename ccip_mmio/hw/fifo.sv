// fifo.sv
// Implements delay buffer (fifo)
// On reset all entries are set to 0
// Shift causes fifo to shift out oldest entry to q, shift in d

module fifo
  #(
  parameter DEPTH=8,
  parameter BITS=64
  )
  (
  input clk,rst_n,en,
  input [BITS-1:0] d,
  output [BITS-1:0] q
  );
  

reg [BITS-1:0] queue [DEPTH-1:0];

always_ff @(posedge clk) begin
	
	if (en) begin
		queue[DEPTH-1:1] <= queue[DEPTH-2:0];
		queue[0] <= d;
	end
	else if (!rst_n) begin
		for (integer i = 0; i < DEPTH; i++)
			queue[i] <= {BITS{1'b0}};
	end
end

assign q = queue[DEPTH-1];

endmodule // fifo
