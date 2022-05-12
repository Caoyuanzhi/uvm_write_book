module dut(
	clk		,
	rst_n	,
	rxd		,
	rxd_v	,
	txd		,
	tx_en	,
	reg_value
);
	input	wire		clk			;
	input	wire		rst_n		;
	input	wire[7:0]	rxd			;
	input	wire		rxd_v		;
	output	reg[7:0]	txd			;
	output	reg			tx_en		;
	output	reg[63:0]	reg_value	;

	always@(posedge clk) begin
		if(! rst_n)begin
			txd 	<= 	8'b0	;
			tx_en	<= 	1'b0	;
		end
		else begin
			txd		<=	rxd		;
			tx_en 	<=	rxd_v	;
		end
	end

	always@(posedge clk) begin
		if(! rst_n)begin
			reg_value 	<= 	64'b0;
		end
		else begin
			reg_value 	<=	reg_value + 1'b1;
		end
	end
endmodule




	


