TOP_TB       = top_tb
FLIST        = flist.f
BUILD_DIR    = run
SNAPSHOT     = top_tb_snapshot
SIM_TIME     = 1us
UVM_VERBOSITY= UVM_MEDIUM
SEED         = 1

# Vivado sim logs
SIM_LOG      = -log $(BUILD_DIR)/simulate.log
ELAB_LOG     = -log $(BUILD_DIR)/elaborate.log
XVLOG_LOG    = -log $(BUILD_DIR)/xvlog.log

.PHONY: all compile elaborate run clean

all: run

compile: clean
	@mkdir -p $(BUILD_DIR)
	xvlog -sv -f $(FLIST) -L uvm $(XVLOG_LOG)

elaborate: compile
	xelab $(TOP_TB) -s $(SNAPSHOT) -timescale 1ns/1ns -L uvm $(ELAB_LOG)

run: elaborate
	xsim $(SNAPSHOT) --sv_seed $(SEED) \
	    -testplusarg UVM_VERBOSITY=$(UVM_VERBOSITY) \
	    -runall $(SIM_LOG)

clean:
	rm -rf $(BUILD_DIR) xsim.dir *.jou *.log *.pb *.wdb
