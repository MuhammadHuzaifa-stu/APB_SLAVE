`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_sequence extends uvm_sequence #(apb_seq_item);

    `uvm_object_utils(apb_sequence)


    function new(string name = "apb_sequence");
        super.new(name);
    endfunction 

    task body();
        repeat(20) begin
            apb_seq_item tx;

            tx = apb_seq_item::type_id::create("tx");
            
            start_item(tx);

            assert(tx.randomize()) else `uvm_error("SEQ", "Randomization failed");
            
            finish_item(tx);
        end
    endtask 
endclass //apb_sequence extends vm_sequence`include "uvm_macros.svh"
import uvm_pkg::*;

class apb_sequence extends uvm_sequence #(apb_seq_item);

    `uvm_object_utils(apb_sequence)


    function new(string name = "apb_sequence");
        super.new(name);
    endfunction 

    task body();
        repeat(20) begin
            apb_seq_item tx;

            tx = apb_seq_item::type_id::create("tx");
            
            start_item(tx);

            assert(tx.randomize()) else `uvm_error("SEQ", "Randomization failed");
            
            finish_item(tx);
        end
    endtask 
endclass //apb_sequence extends vm_sequence