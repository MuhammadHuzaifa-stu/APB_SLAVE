class apb_monitor extends uvm_monitor;

    `uvm_component_utils(apb_monitor)

    virtual apb_if vif;
    uvm_analysis_port #(apb_seq_item) apb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
        apb = new("apb", this);
    endfunction 

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if (!uvm_config_db #(virtual apb_if)::get(this, "", "vif", vif))
            `uvm_fatal("NOVIF", "Virtual interface not set for monitor")
    endfunction

    task run_phase(uvm_phase phase);
        apb_seq_item tr;
        forever begin
            @(posedge vif.pclk);
            if (vif.pready) begin
                tr = apb_seq_item::type_id::create("tr", this);
                tr.data = vif.prdata;
                apb.write(tr);
                `uvm_info("MON", $sformatf("Monitored data = %0d", tr.data), UVM_LOW)
            end
        end
    endtask
endclass //apb_monitor extends uvm_monitor