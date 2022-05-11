
class my_driver extends uvm_driver;
	//factory:
	`uvm_component_utils(my_driver)
	
	virtual my_if vif;

	function new(string name = "my_driver", uvm_component parent = null);
		super.new(name, parent);
		`uvm_info("my_driver","new_function is called",UVM_HIGH)
	endfunction
		
	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		`uvm_info("my_driver","build_phase is called",UVM_HIGH)
		if(!uvm_config_db#(virtual my_if)::get(this,"","vif",vif))
			`uvm_fatal("my_driver","virtual interface is not set for vif !")
	endfunction

	extern virtual task main_phase(uvm_phase phase);

endclass



task my_driver::main_phase(uvm_phase phase);	
	phase.raise_objection(this);
	`uvm_info("my_driver","main_phase is called",UVM_HIGH)
	//top_tb.rxd   <= 8'b0;
	//top_tb.rxd_v <= 1'b0;
	vif.data  <= 8'b0;
	vif.valid <= 1'b0;
	while(!vif.rst_n)
		@(posedge vif.clk);

	for(int i = 0; i < 256; i++)begin
		@(posedge vif.clk);
		vif.data   <= $urandom_range(0,255);
		//$display("driver data\n");
		`uvm_info("my_driver", $sformatf("rxd = %h",vif.data), UVM_HIGH)
		vif.valid <= 1'b1;
		`uvm_info("my_driver", "data is drived", UVM_LOW)
	end
	@(posedge vif.clk);
		vif.valid <= 1'b0;
	phase.drop_objection(this);
endtask

