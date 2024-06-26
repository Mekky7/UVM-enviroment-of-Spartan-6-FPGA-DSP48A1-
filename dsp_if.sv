interface dsp_if (clk);
    input clk;
    logic [17:0] A, B, D, BCIN;
    logic [47:0] C, PCIN;
    logic CEP, RSTP, CECARRYIN, RSTCARRYIN, CARRYIN, RSTM, CEM, RSTA, RSTB, RSTC, RSTD, CEA, CEB, CEC, CED, CEOPMODE, RSTOPMODE;
    logic [7:0] OPMODE;
    logic CARRYOUT,CARRYOUT_COMB,CARRYOUTF_COMB,CARRYOUTF;
    logic [17:0] BCOUT,BCOUT_COMP;
    logic [47:0] P, PCOUT,PCOUT_COMB,P_COMB;
    logic [35:0] M,M_COMB;
endinterface 