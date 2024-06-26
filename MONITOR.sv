package monitor_pkg;
import sequence_item_pkg::*;
import uvm_pkg::*;
import shared_pkg::*;
`include "uvm_macros.svh"
class dsp_monitor extends uvm_monitor;
`uvm_component_utils(dsp_monitor)
virtual dsp_if dspif;
dsp_seq_item rsp_seq_item;
uvm_analysis_port #(dsp_seq_item) mon_ap;

    function new(string name ="dsp_monitor",uvm_component parent=null);
        super.new(name,parent);
        mon_ap=new("mon_ap",this);
    endfunction //new()
    task run_phase(uvm_phase phase);
    super.run_phase(phase);

        forever begin

@(negedge dspif.clk);
rsp_seq_item=dsp_seq_item::type_id::create("dsp_seq_item");
   rsp_seq_item.A=dspif.A;
   rsp_seq_item.B=dspif.B;
   rsp_seq_item.C=dspif.C;
   rsp_seq_item.D=dspif.D;
   rsp_seq_item.CARRYIN=dspif.CARRYIN;
   rsp_seq_item.OPMODE=dspif.OPMODE;
   rsp_seq_item.BCIN=dspif.BCIN;
   rsp_seq_item.RSTA=dspif.RSTA;
   rsp_seq_item.RSTB=dspif.RSTB;
   rsp_seq_item.RSTM=dspif.RSTM;
   rsp_seq_item.RSTP=dspif.RSTP;
   rsp_seq_item.RSTC=dspif.RSTC;
   rsp_seq_item.RSTD=dspif.RSTD;
   rsp_seq_item.RSTCARRYIN=dspif.RSTCARRYIN;
   rsp_seq_item.RSTOPMODE=dspif.RSTOPMODE;
   rsp_seq_item.CEA=dspif.CEA;
   rsp_seq_item.CEB=dspif.CEB;
   rsp_seq_item.CEM=dspif.CEM;
   rsp_seq_item.CEP=dspif.CEP;
   rsp_seq_item.CEC=dspif.CEC;
   rsp_seq_item.CED=dspif.CED;
   rsp_seq_item.CECARRYIN=dspif.CECARRYIN;
   rsp_seq_item.CEOPMODE=dspif.CEOPMODE;
   rsp_seq_item.PCIN=dspif.PCIN;
   rsp_seq_item.BCOUT=dspif.BCOUT;
   rsp_seq_item.PCOUT=dspif.PCOUT;
   rsp_seq_item.P=dspif.P;
   rsp_seq_item.M=dspif.M;
   rsp_seq_item.CARRYOUT=dspif.CARRYOUT;
   rsp_seq_item.CARRYOUTF=dspif.CARRYOUTF;
    mon_ap.write(rsp_seq_item);
  `uvm_info("run_phase",rsp_seq_item.convert2string(),UVM_HIGH);
        end
    endtask
endclass     
endpackage