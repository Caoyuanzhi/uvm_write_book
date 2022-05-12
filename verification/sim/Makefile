#-------------------------------------------------------------------------------------------------------
all: \
		vcs \
		sim \
		verdi

regone:vcs sim
#-------------------------------------------------------------------------------------------------------
run   :
	vcs  \
			  +incdir+$(UVM_HOME)/src $(UVM_HOME)/src/uvm.sv \
			  $(UVM_HOME)/src/dpi/uvm_dpi.cc -CFLAGS -DVCS \
			  +incdir+$(PROJECT_ROOT)/verification/harness\
			  +incdir+$(PROJECT_ROOT)/verification/env\
              -f file_list.f \
              -timescale=1ns/1ns \
              -fsdb  -full64  -R  +vc  +v2k  -sverilog \
		  	  -LDFLAGS -Wl,--no-as-needed \
              -P ${LD_LIBRARY_PATH}/novas.tab  ${LD_LIBRARY_PATH}/pli.a  \
              |tee vcs.log  
			  ./simv +TEST_NAME=TEST01 +force_rtl -l sim.log
#-------------------------------------------------------------------------------------------------------
sim	:
	./simv -l sim.log

#-------------------------------------------------------------------------------------------------------

verdi  :
	verdi -sv -f file_list.f -ssf tb.fsdb &
#-------------------------------------------------------------------------------------------------------
clean  :
	 rm  -rf  *~  core  csrc  simv*  vc_hdrs.h  ucli.key  urg* *.log  novas.* *.fsdb* verdiLog  64* DVEfiles *.vpd
#-------------------------------------------------------------------------------------------------------
