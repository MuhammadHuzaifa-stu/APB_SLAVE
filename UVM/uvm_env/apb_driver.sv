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
        forever begin
            apb_seq_item req;
            seq_item_port.get_next_item(req);

            // Drive APB signals
            vif.psel    <= 'd1;
            vif.penable <= 'd0;
            vif.paddr   <= req.addr;
            vif.pwrite  <= req.write;
            vif.pwdata  <= req.write ? req.data : 'd0;

            @(posedge vif.pclk);
            vif.penable <= 'd1;

            // waite for pready
            wait(vif.pready);

            @(posedge vif.pclk);
            vif.psel    <= 'd0;
            vif.penable <= 'd0;

            seq_item_port.item_done();
        end
    endtask
endclass //apb_driver extends uvm_driver #(apb_seq_item)