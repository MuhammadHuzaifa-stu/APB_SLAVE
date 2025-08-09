`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)

    virtual apb_if vif;

    uvm_analysis_port #(apb_seq_item) apb_port;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        apb_port = new("apb_port", this);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
    endfunction

    task run_phase(uvm_phase phase);
        apb_seq_item tr;
        forever 
        begin
            @(posedge vif.pclk);
            if (vif.pready && vif.penable && vif.pready) 
            begin
                tr = apb_seq_item::type_id::create("tr", this);
                
                tr.paddr  = vif.paddr;
                tr.pwrite = vif.pwrite;
                tr.pwdata = vif.pwdata;  // write data from master
                tr.prdata = vif.prdata;  // read data from slave
                
                apb_port.write(tr);
                `uvm_info("MON", $sformatf("APB MON: addr=0x%0h, write=%0b, rdata=0x%0h, wdata=0x%0h", tr.paddr, tr.pwrite, tr.prdata, tr.pwdata), UVM_LOW)
            end
        end
    endtask
endclass //apb_monitor extends uvm_monitor