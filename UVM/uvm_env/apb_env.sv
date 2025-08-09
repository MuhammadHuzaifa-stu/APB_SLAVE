class apb_env extends uvm_env;
    
    `uvm_component_utils(apb_env)

    apb_agent agent;
    apb_scoreboard sb;

    function new(string name, uvm_component parent);
        super.new(name, parent);
    endfunction //new()

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        
        agent = apb_agent::type_id::create("agent", this);
        sb = apb_scoreboard::type_id::create("sb", this); 
    
    endfunction

    function void connect_phase(uvm_phase phase);
        agent.mon.apb.connect(sb.analysis_export);        
    endfunction
    
endclass //apb_env extends uvm_env