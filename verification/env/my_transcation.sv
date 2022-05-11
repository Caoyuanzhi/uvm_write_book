class my_transcation extends uvm_sequence_item;
	rand bit[47:0]	dest_mac	;
	rand bit[47:0]	src_mac		;
	rand bit[15:0]	ether_type	;
	rand byte		payload[]	;
	rand bit[31:0]	crc 		;

	constraint payload_cons{
			payload.size >= 46	;
			payload.size <= 1500;
	}

	function bit[31:0] cal_crc();
		return 32'h0;
	endfunction

	function void post_randomize();
		crc = cal_crc();
	endfunction 

	`uvm_object_utils(my_transcation)

	function new(string name = "my_transcation");
		super.new(name);
	endfunction 

endclass 
