`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_scoreboard extends uvm_scoreboard;
    
    `uvm_component_utils(apb_scoreboard)
    
    uvm_analysis_imp #(apb_seq_item, apb_scoreboard) analysis_export;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        analysis_export = new("analysis_export", this);
    endfunction //new()

    function void write(apb_seq_item tr);
        `uvm_info("SB", $sformatf("Checking data = %0d", tr.data), UVM_LOW);
        // add further checks
    endfunction
endclass //apb_scoreboard extends uvm_scoreboard