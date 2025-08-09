`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_driver extends uvm_driver #(apb_seq_item);

    virtual apb_if vif;

    `uvm_component_utils(apb_driver)
    
    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "virtual interface not set")
    endfunction

    task run_phase(uvm_phase phase);
        forever 
        begin
            apb_seq_item req;
            // seq_item_port.get_next_item(req);

            `uvm_info("DRV", "Waiting for sequence item...", UVM_LOW)
            seq_item_port.get_next_item(req);
            `uvm_info("DRV", "Got sequence item", UVM_LOW)
            
            // Drive APB signals
            vif.psel    <= 1;
            vif.penable <= 0;
            vif.paddr   <= req.paddr;
            vif.pwrite  <= req.pwrite;
            vif.pwdata  <= req.pwrite ? req.pwdata : 'd0;

            @(posedge vif.pclk);
            vif.penable <= 1;

            @(posedge vif.pclk);
            vif.psel    <= 0;
            vif.penable <= 0;

            seq_item_port.item_done();
            `uvm_info("DRV", "sequence item_deon ...", UVM_LOW)
        end
    endtask
endclass //apb_driver extends uvm_driver #(apb_seq_item)