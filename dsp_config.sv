package dsp_config_pkg;
import uvm_pkg::*;
`include "uvm_macros.svh"
class dsp_config extends uvm_object;
`uvm_object_utils(dsp_config);
virtual dsp_if  dspif;;
    function new(string name ="dsp_config");
     super.new(name);   
    endfunction 
    endclass 
    
endpackage