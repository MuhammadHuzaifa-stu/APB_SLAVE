# Makefile with run directory
UVM_HOME ?= $(shell dirname $(shell which vcs))/../uvm-1.2
VCS_OPTS = -full64 -sverilog +incdir+$(UVM_HOME)/src \
           +incdir+./rtl +incdir+./tb +incdir+./uvm_env \
           -ntb_opts uvm-1.2 -timescale=1ns/1ps

FLIST = flist.f
BUILD_DIR = run

comp:
	mkdir -p $(BUILD_DIR)
	vcs $(VCS_OPTS) -f $(FLIST) -o $(BUILD_DIR)/simv

run:
	cd $(BUILD_DIR) && ./simv +UVM_VERBOSITY=UVM_MEDIUM | tee sim.log

rerun: clean comp run

clean:
	rm -rf $(BUILD_DIR) csrc ucli.key simv simv.daidir *.log
