package squencer_pkg;
import uvm_pkg::*;
import sequence_item_pkg::*;
`include "uvm_macros.svh"
  class dsp_squencer extends uvm_sequencer #(dsp_seq_item);
`uvm_component_utils(dsp_squencer); 
function  new(string name = "dsp_squencer",uvm_component parent =null);
super.new(name,parent);    
endfunction   
  endclass  
endpackage