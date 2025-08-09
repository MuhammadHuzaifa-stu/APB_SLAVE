`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(apb_scoreboard)

    // Analysis export to receive transactions from the monitor
    uvm_analysis_imp #(apb_seq_item, apb_scoreboard) analysis_export;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction

    // The monitor calls this when a transaction arrives
    function void write(apb_seq_item tr);
        `uvm_info("SB", $sformatf("Checking transaction: ADDR=0x%0h, WDATA=0x%0h, RDATA=0x%0h, PWRITE=%0b", tr.paddr, tr.pwdata, tr.prdata, tr.pwrite), UVM_LOW)

        // Example functional check:
        // In a real design, you'd compare against expected data from a reference model.
        // This is just a placeholder for now.
        // if (tr.pwrite == 0) begin
            // Read transaction check (assume prdata captured by monitor)
            // if (tr.prdata !== expected_value) ...
        // end
        // else begin
            // Write transaction check
            // Store in expected memory model, etc.
        // end
    endfunction

endclass
