class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)

    virtual apb_if vif;
    uvm_analysis_port #(apb_transaction) apb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        apb = new("apb", this)
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
    endfunction

    task run_phase(uvm_phase phase)
        apb_transaction tr;
        forever begin
            @(posedge vif.pclk);
            if (vif.pready) begin
                tr = apb_transaction::type_id::create("tr", this);
                tr = vif.prdata;
                apb.write(tr);
                `uvm_info("MON", $sformatf("Monitored data = %0d", tr.data), uvm_low)
            end
        end
    endtask
endclass //apb_monitor extends uvm_monitor