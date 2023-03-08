ForwardAD:
if (rsD != 0) {
	if(jE & (rsD == 31)) {
		ForwardAD = 3'b001;
	} else if (RegWriteM & srcIsALUM & rsD == WriteRegM) {
        ForwardAD = 3'b010;
    } else if (jM & rsD == 31) {
        ForWardAD = 3'b011;
    } else {
        ForWardAD = 3'b000;
    }
}
rtD����
---
Stall, Flush:
Stall = 0;
if ((rsD != 0 & RegWriteE & srcIsALUE & rsD == WriteRegE) || (rtD����)) {
    Stall0 = 1;
} else if ((rsD != 0 & RegWriteE & srcIsMemE & rsD == WriteRegE) || (rtD����)) {
    Stall0 = 1;
} else if ((rsD != 0 & RegWriteM & srcIsMemM & rsD == WriteRegM) || (rtD����)) {
    Stall0 = 1;
}
Flush = Stall;

---
ֱ������Tuse��Tnew�ж�forward��stall����?
ForwardAD:
ForwardAD = 3'b000;
if ((TnewE == 2'd0) && (rsD != 5'd0 && rsD == WriteRegE)) begin
        case (RegDataSrcE)
            `PC8Type: ForwardAD = 3'b001; 
        endcase
end else if ((TnewM == 2'd0) && (rsD != 5'd0 && rsD == WriteRegM)) begin
        case (RegDataSrcM)
            `ALUType: ForwardAD = 3'b010;
            `PC8Type: ForwardAD = 3'b011; 
        endcase
end

Stall:
Stall = 1'b0;
if ((Tuse < TnewE) &&
    ((rsD != 5'd0 && rsD == WriteRegE) || (rtD != 5'd0 && rtD == WriteRegE))) begin
        Stall = 1'b1;
end else if ((Tuse < TnewM) &&
    ((rsD != 5'd0 && rsD == WriteRegM) || (rtD != 5'd0 && rtD == WriteRegM))) begin
        Stall = 1'b1;
end 

ForwardAE:
ForwardAE = 3'b000;
if ((TnewM == 2'd0) && (rsE != 5'd0 && rsE == WriteRegM)) begin
    case (RegDataSrcM)
        `ALUType: ForwardAE = 3'b001;
        `PC8Type: ForwardAE = 3'b010; 
    endcase
end else if ((TnewW == 2'd0) && (rsE != 5'd0 && rsE == WriteRegW)) begin
    ForwardAE = 3'b111;
end

�Բۣ�ţ�ƣ�����