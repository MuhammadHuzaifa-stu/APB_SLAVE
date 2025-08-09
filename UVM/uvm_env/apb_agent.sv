`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_agent extends uvm_agent;

    `uvm_component_utils(apb_agent)
    
    virtual apb_if vif;

    apb_driver    drv;
    apb_sequencer seqr;
    apb_monitor   mon;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);

        if (!uvm_config_db#(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set for agent")

        if (is_active == UVM_ACTIVE) 
        begin
            drv  = apb_driver::type_id::create("drv", this);        
            seqr = apb_sequencer::type_id::create("seqr", this);
        end
        
        mon = apb_monitor::type_id::create("mon", this);

        if (is_active == UVM_ACTIVE) 
        begin
            uvm_config_db#(virtual apb_if)::set(this, "drv", "vif", vif);
        end
        uvm_config_db#(virtual apb_if)::set(this, "mon", "vif", vif);
    endfunction

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        if (is_active == UVM_ACTIVE) 
        begin
            drv.seq_item_port.connect(seqr.seq_item_export);
        end
    endfunction
endclass
