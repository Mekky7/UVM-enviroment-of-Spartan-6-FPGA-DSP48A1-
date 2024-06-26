package squence_pkg;
import uvm_pkg::*;
import sequence_item_pkg::*;
`include "uvm_macros.svh"
class reset_seq extends uvm_sequence;
    `uvm_object_utils(reset_seq);
     dsp_seq_item item;
    function new(string name ="reset_seq");
        super.new(name);
        endfunction
task body ;
 item=dsp_seq_item::type_id::create("item");
 start_item(item);
item.A=0;
item.B=0;
item.C=0;
item.C=0;
item.CARRYIN=0;
item.BCIN=0;
item.RSTA=1;
item.RSTB=1;
item.RSTM=1;
item.RSTP=1;
item.RSTC=1;
item.RSTD=1;
item.RSTCARRYIN=1;
item.RSTOPMODE=1;
item.CEA=1;
item.CEB=1;
item.CEM=1;
item.CEP=1;
item.CEC=1;
item.CED=1;
item.CECARRYIN=1;
item.CEOPMODE=1;
 finish_item(item);   
endtask //=
endclass //className extends superClass
class dsp_main_sequence extends uvm_sequence;
  `uvm_object_utils(dsp_main_sequence);
  dsp_seq_item item;
function new(string name = "dsp_main_sequence");
super.new(name);
endfunction
task body();
repeat(100000)
begin
    item=dsp_seq_item::type_id::create("item");
    item.combinational.constraint_mode(0);
    start_item(item);
    assert(item.randomize());
    finish_item(item);
end
endtask
endclass
///
class dsp_comb_sequence extends uvm_sequence;
  `uvm_object_utils(dsp_comb_sequence);
  dsp_seq_item item;
function new(string name = "dsp_comb_sequence");
super.new(name);
endfunction
task body();
repeat(1000)
begin
    item=dsp_seq_item::type_id::create("item");
    start_item(item);
    assert(item.randomize());
    finish_item(item);
end
endtask
endclass
endpackage