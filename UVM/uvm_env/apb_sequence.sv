class apb_sequence extends uvm_sequence #(apb_seq_item);

    `uvm_object_utils(apb_sequence)


    function new(string name = "apb_sequence");
        super.new(name);
    endfunction 

    task body();
        repeat(2) begin
            apb_seq_item tx = apb_seq_item::type_id::create("tx");
            tx.randomize();
            start_item(tx);
            finish_item(tx);
        end
    endtask 
endclass //apb_sequence extends vm_sequence