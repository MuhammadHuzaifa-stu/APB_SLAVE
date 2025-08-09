# APB Protocol Verification Using UVM

## Overview

This repository contains a UVM (Universal Verification Methodology) testbench environment developed to verify an APB (Advanced Peripheral Bus) memory module (`apb_mem`). The verification environment includes a fully parameterized APB agent with sequencer, driver, monitor, and scoreboard components designed for functional verification of APB transactions.

---

## Project Structure

```
./rtl/
    apb_mem.sv            # APB memory RTL module

./tb/
    interface.sv          # APB interface definition
    top_tb.sv             # Top-level testbench connecting RTL and UVM env

./uvm_env/
    apb_seq_item.sv       # Transaction item definition
    apb_sequence.sv       # Sequence generating APB transactions
    apb_sequencer.sv      # Sequencer to arbitrate sequences
    apb_driver.sv         # Driver that drives APB interface signals
    apb_monitor.sv        # Monitor to sample DUT signals and send analysis
    apb_agent.sv          # APB agent combining sequencer, driver, and monitor
    apb_scoreboard.sv     # Scoreboard for reference checks
    apb_env.sv            # UVM environment wrapping agent and scoreboard
    apb_test.sv           # Test class instantiating environment and sequence
```

---

## Prerequisites

* Vivado Simulator (xsim) or any other SystemVerilog simulator supporting UVM 1.2
* UVM 1.2 library (included with Vivado)
* GNU Make for running provided Makefile targets

---

## How to Run

1. **Configure parameters and interface in `top_tb.sv`**
   Set address and data width parameters using UVM configuration DB.

2. **Compile the design and testbench**

   ```bash
   make compile
   ```

3. **Elaborate the simulation**

   ```bash
   make elaborate
   ```

4. **Run simulation in batch mode**

   ```bash
   make sim_o
   ```

5. **Run simulation with waveform GUI**

   ```bash
   make gui
   ```

---

## Makefile Targets

* `make compile` — Compiles RTL and testbench files.
* `make elaborate` — Elaborates design for simulation with debug info.
* `make sim_o` — Runs simulation without GUI.
* `make gui` — Runs simulation with waveform GUI.
* `make run` — Performs compile, elaborate, and run all steps sequentially.
* `make clean` — Cleans generated files and directories.

---
