package score_board_pkg;
import uvm_pkg::*;
import shared_pkg::*;
import sequence_item_pkg::*;
`include"uvm_macros.svh" 
class dsp_scoreboard extends uvm_scoreboard;
`uvm_component_utils(dsp_scoreboard)
uvm_analysis_export #(dsp_seq_item) sb_export;
uvm_tlm_analysis_fifo #(dsp_seq_item) sb_fifo;
dsp_seq_item seq_item_sb;
bit [17:0] BCOUT_ref;
bit [17:0] temp;
bit [47:0] PCOUT_ref;
bit [47:0] P_ref;
bit [35:0] M_ref;
bit CARRYOUT_ref;
bit CARRYOUTF_ref;
bit [47:0] X;
bit [47:0] Z;
bit [47:0]P_COMB;
bit CIN;
bit CARRYOUT_COMB;
int error_count=0;
int correct_count=0;
//////////////////////////////////////////////internal reisters
bit [17:0] R,A_REG,B_REG,D_REG,D_B_RESULT,A1REG,B1REG;
bit [35:0] mult_product;
bit [7:0] OPMODE_REG;
bit [47:0] C_REG;
    function new(string name ="dsp_scoreboard",uvm_component parent =null);
        super.new(name,parent);
    endfunction //new()
function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    sb_export =new("sb_export",this);
    sb_fifo=new("sb_fifo",this);
endfunction
function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    sb_export.connect(sb_fifo.analysis_export);
endfunction

task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
        sb_fifo.get(seq_item_sb);
        if(!shared_pkg::parameter_comb)
        ref_model(seq_item_sb);
        else
         comb_ref_model(seq_item_sb);
        if((seq_item_sb.BCOUT !==BCOUT_ref)||(seq_item_sb.M !== M_ref)||(P_ref!==seq_item_sb.P)||(CARRYOUT_ref!==seq_item_sb.CARRYOUT))
        begin
            error_count=error_count+1;
           `uvm_error("run_phase",$sformatf("comparasion_failed,transaction recieved by dut : %s while the refrence M:0%h and P :%h and Bcout is %h X is %h and Z is %h and opmode is %0b and D is %0h and B is %0h and result of D_B is %0h  CIN IS %d",seq_item_sb.convert2string(),M_ref,P_ref,BCOUT_ref,X,Z,OPMODE_REG,seq_item_sb.D,seq_item_sb.B,D_B_RESULT,CIN)) 
        
        end
       else begin
            correct_count= correct_count+1 ;
           `uvm_info("run_phase",$sformatf("comparasion_successeded,transaction recieved by dut : %s while the refrence M:0%h and P :%0h and Bcout is %h OPMODE IS %b  ",seq_item_sb.convert2string(),M_ref,P_ref,BCOUT_ref,OPMODE_REG), UVM_HIGH)      
        end    
    end   

endtask
/////////////////////////////////////////////////////////////////////////////
task ref_model(dsp_seq_item seq_item_chk);

///for X 
case(OPMODE_REG[1:0])
0:X=0;
1:X={{12{M_ref[35]}},M_ref};
2:X=P_ref;
3:X={D_REG[11:0],A1REG,B1REG};
endcase
// for Z :
case(OPMODE_REG[3:2])
0:Z=0;
1:Z=seq_item_chk.PCIN;
2:Z=P_ref;
3:Z=C_REG;
endcase
{CARRYOUT_COMB,P_COMB}=(!OPMODE_REG[7])? X+Z+CIN : Z-(X+CIN);

if(seq_item_chk.RSTP)
begin
P_ref=0;    
end else if(seq_item_chk.CEP)
begin
   P_ref= P_COMB;
end
if(seq_item_chk.RSTCARRYIN)
begin
CARRYOUT_ref=0;    
end else if(seq_item_chk.CECARRYIN)
begin
   CARRYOUT_ref= CARRYOUT_COMB;
end
//for M_ref (done)
if (seq_item_chk.RSTM) begin
    M_ref=0;
end else begin
    if (seq_item_chk.CEM) begin
    M_ref=A1REG*B1REG;    
    end
end

if (seq_item_chk.RSTB) begin
    B1REG=0;
end else begin
    if (seq_item_chk.CEB) begin
    B1REG=(OPMODE_REG[4])?((OPMODE_REG[6])?(D_REG-B_REG):(D_REG+B_REG)):B_REG;    
    end
end



BCOUT_ref=B1REG;// for Bcout_ref--->(done)
/////////////////////////////////////////////////////////////////////////
if(seq_item_chk.RSTA)
begin
A1REG=0;    
end else if (seq_item_chk.CEA) begin
A1REG=A_REG;   
end

if(seq_item_chk.RSTOPMODE)
begin
OPMODE_REG=0;    
end else if (seq_item_chk.CEOPMODE) begin
OPMODE_REG=seq_item_chk.OPMODE;   
end
// inputs :
if(seq_item_chk.RSTD)
begin
D_REG=0;    
end else if (seq_item_chk.CED) begin
D_REG=seq_item_chk.D;   
end
if(seq_item_chk.RSTB)
begin
B_REG=0;    
end else if (seq_item_chk.CEB) begin
B_REG=seq_item_chk.B;   
end
if(seq_item_chk.RSTC)
begin
C_REG=0;    
end else if (seq_item_chk.CEC) begin
C_REG=seq_item_chk.C;   
end
if(seq_item_chk.RSTA)
begin
A_REG=0;    
end else if (seq_item_chk.CEA) begin
A_REG=seq_item_chk.A;   
end


if (seq_item_chk.RSTCARRYIN) begin
   CIN =0;  
end else begin
    if (seq_item_chk.CECARRYIN) begin
    CIN =seq_item_chk.OPMODE[5];    
    end
end


endtask

task comb_ref_model(dsp_seq_item seq_item_chk);

BCOUT_ref=(seq_item_chk.OPMODE[4])?((!seq_item_chk.OPMODE[6])?(seq_item_chk.B+seq_item_chk.D):(seq_item_chk.D-seq_item_chk.B)):seq_item_chk.B;
M_ref=BCOUT_ref*seq_item_chk.A;
case(seq_item_chk.OPMODE[1:0])
0:X=0;
1:X={{12{M_ref[35]}},M_ref};
2:X=P_ref;
3:X={seq_item_chk.D,seq_item_chk.A,BCOUT_ref};
endcase
// for Z :
case(seq_item_chk.OPMODE[3:2])
0:Z=0;
1:Z=seq_item_chk.PCIN;
2:Z=P_ref;
3:Z=seq_item_chk.C;
endcase

CIN=seq_item_chk.OPMODE[5];
{CARRYOUT_ref,P_COMB}=(!seq_item_chk.OPMODE[7])? X+Z+CIN : Z-(X+CIN);

if(seq_item_chk.RSTP)
begin
P_ref=0;    
end else if(seq_item_chk.CEP)
begin
   P_ref= P_COMB;
end

endtask




function void report_phase(uvm_phase phase) ;
    super.report_phase(phase);
    `uvm_info("report phase",$sformatf("total successful transactions is %0d",correct_count),UVM_MEDIUM);
    `uvm_info("report phase",$sformatf("total wrong transactions is %0d",error_count),UVM_MEDIUM);
endfunction
endclass 
endpackage