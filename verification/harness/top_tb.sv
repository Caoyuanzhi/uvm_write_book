`timescale 1ns/1ps
`include "uvm_macros.svh"

import uvm_pkg::*;

`include "env_file.sv"

module top_tb;
	parameter SIMULATION_TIME = 2000000;	
	
	reg	  		clk		;
	reg	  		rst_n	;
	reg[7:0] 	rxd		;
	reg 	 	rxd_v	;
	wire[7:0]	txd		;
	wire		tx_en	;
	
	reg [63:0]	reg_value;
	
	//use interface
	my_if input_if(clk,rst_n);
	my_if output_if(clk,rst_n);
	
	dut my_dut(
		.clk	(clk	),
		.rst_n	(rst_n	),
		.rxd	(input_if.data	),
		.rxd_v 	(input_if.valid	),
		.txd	(output_if.data	),
		.tx_en 	(output_if.valid),
		.reg_value(reg_value)
	);
	
	initial begin
		clk = 0;
		forever begin
			#100 clk = ~clk;
		end 
	end 
	
	initial begin
		rst_n = 1'b0;
		#100;
		rst_n = 1'b1;
	end 



	//configure_db
	initial begin
		uvm_config_db#(virtual my_if)::set(null,"uvm_test_top","vif",input_if);
	end


	initial begin
		//my_driver drv;
		//drv = new("drv",null);
		//drv.main_phase(null);
		run_test("my_driver");

	end

	initial begin
      $fsdbDumpfile("tb.fsdb");
      $fsdbDumpvars;
  	end
  
  	initial begin
      $display("---------------SIMULATION START-----------------");
      #SIMULATION_TIME
      $display("---------------SIMULATION FINISH----------------");
      $finish;
  	end
	
	initial begin
		if($test$plusargs("force_rtl"))begin
			`include "rtl_force.sv"
		end
	end	


	reg [255:0] testname;
	final begin
		if($value$plusargs("TEST_NAME=%s",testname))begin
			$display("-----Run on TEST:%s",testname);	
		end
		
		uvm_top.print_topology();
	end

endmodule

