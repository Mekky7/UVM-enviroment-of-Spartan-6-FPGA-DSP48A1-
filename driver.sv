package dsp_driver_pkg;
import uvm_pkg::*;
import dsp_config_pkg::*;
import sequence_item_pkg::*;
`include "uvm_macros.svh"
class dsp_driver extends uvm_driver #(dsp_seq_item);
    `uvm_component_utils(dsp_driver)
     virtual dsp_if dspif;
     dsp_seq_item stim_seq_item;
     function  new( string name="dsp_driver",uvm_component parent =null);
        super.new(name,parent);
     endfunction
    task run_phase(uvm_phase phase);
  super.run_phase(phase);
         forever begin
stim_seq_item=dsp_seq_item::type_id::create("stim_seq_item");
seq_item_port.get_next_item(stim_seq_item);
dspif.A=stim_seq_item.A;
dspif.B=stim_seq_item.B;
dspif.C=stim_seq_item.C;
dspif.D=stim_seq_item.D;
dspif.CARRYIN=stim_seq_item.CARRYIN;
dspif.BCIN=stim_seq_item.BCIN;
dspif.RSTA=stim_seq_item.RSTA;
dspif.RSTB=stim_seq_item.RSTB;
dspif.RSTM=stim_seq_item.RSTM;
dspif.RSTP=stim_seq_item.RSTP;
dspif.RSTC=stim_seq_item.RSTC;
dspif.RSTD=stim_seq_item.RSTD;
dspif.RSTOPMODE=stim_seq_item.RSTOPMODE;
dspif.RSTCARRYIN=stim_seq_item.RSTCARRYIN;
dspif.OPMODE=stim_seq_item.OPMODE;
dspif.CEA=stim_seq_item.CEA;
dspif.CEB=stim_seq_item.CEB;
dspif.CEM=stim_seq_item.CEM;
dspif.CEP=stim_seq_item.CEP;
dspif.CEC=stim_seq_item.CEC;
dspif.CED=stim_seq_item.CED;
dspif.CECARRYIN=stim_seq_item.CECARRYIN;
dspif.CEOPMODE=stim_seq_item.CEOPMODE;
dspif.PCIN=stim_seq_item.PCIN;
@(negedge dspif.clk);
seq_item_port.item_done();
         //   `uvm_info("run_phase",stim_seq_item.convert2string_stimulus(),UVM_HIGH)
         end
    endtask
endclass
    
endpackage