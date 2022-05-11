module dut(
	clk		,
	rst_n		,
	rxd		,
	rxd_v		,
	txd		,
	tx_en	
);
	input	wire		clk		;
	input	wire		rst_n		;
	input	wire[7:0]	rxd		;
	input	wire		rxd_v		;
	output	reg[7:0]	txd		;
	output	reg			tx_en	;

	always@(posedge clk) begin
		if(! rst_n)begin
			txd 	<= 	8'b0	;
			tx_en	<= 	1'b0	;
		end
		else begin
			txd	<=	rxd	;
			tx_en 	<=	rxd_v	;
		end
	end

endmodule




	


