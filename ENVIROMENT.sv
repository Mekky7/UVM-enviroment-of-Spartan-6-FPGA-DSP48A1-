
package dsp_env_pkg;
import dsp_driver_pkg::*;
import squencer_pkg::*;
import uvm_pkg::*;
import agent_pkg::*;
import sequence_item_pkg::*;
import score_board_pkg::*;
import coverage_collector::*;
`include "uvm_macros.svh"
class dsp_env extends uvm_env;
 `uvm_component_utils(dsp_env)
 dsp_coverage cov;
 dsp_scoreboard sb;
 dsp_agent agt;
   function new(string name = "dsp_env", uvm_component parent = null);
      super.new(name, parent);
   endfunction
function void build_phase(uvm_phase phase);
super.build_phase(phase);
agt=dsp_agent::type_id::create("agt",this);
sb=dsp_scoreboard::type_id::create("sb",this);
cov=dsp_coverage::type_id::create("cov",this);
endfunction

function void connect_phase(uvm_phase phase);
  super.connect_phase(phase);
  agt.agt_ap.connect(sb.sb_export);
  agt.agt_ap.connect(cov.cov_export);   
endfunction
endclass
endpackage
