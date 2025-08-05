# User-defined variables
TOP_MODULE = tb_apb_mem
WORK_LIB   = work
FLIST      = flist

# ModelSim commands (use full paths)
MODELSIM_BIN = ~/intelFPGA/20.1/modelsim_ase/bin
VLIB = $(MODELSIM_BIN)/vlib
VMAP = $(MODELSIM_BIN)/vmap
VLOG = $(MODELSIM_BIN)/vlog
VSIM = $(MODELSIM_BIN)/vsim

# Compile options
VLOG_OPTS = +acc=rn -sv -f $(FLIST)

# Sim options
VSIM_OPTS = -c -do "run -all; quit" $(TOP_MODULE)

all: compile simulate

compile:
	$(VLIB) $(WORK_LIB)
	$(VLOG) $(VLOG_OPTS)

simulate:
	$(VSIM) $(VSIM_OPTS)

gui:
	$(VSIM) $(TOP_MODULE)

clean:
	rm -rf transcript vsim.wlf work
