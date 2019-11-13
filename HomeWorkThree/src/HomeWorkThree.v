module HomeWorkThree(
	input				Asynch_in		,
	input				clock					,
	input				reset					,
	
	output	reg	Synch_out
);

reg		q1				=	1'b0				;
reg		q2				=	1'b0				;
wire		temp									;
wire		temp2								;
wire		clrq1									;
wire		clrq2									;

assign	temp1	=	Synch_out&(~Asynch_in)	;
assign	temp2	=	Synch_out&(~Asynch_in)	;

assign	clrq1	=	reset|temp1		;
assign	clrq2	=	reset|temp2		;

always@(posedge clock) begin
		
	if(reset) begin
		
		Synch_out	=	1'b0				;
		
	end
	else begin
		
		Synch_out	=	q2					;
	
	end
	
end

always@(posedge clock) begin
		
	if(clrq2) begin
		
		q2			=	1'b0				;
		
	end
	else begin
		
		q2			=	q1					;
	
	end
	
end

always@(posedge Asynch_in) begin
		
	if(clrq1) begin
		
		q1			=	1'b0				;
		
	end
	else begin
		
		q1			=	1'b1				;
	
	end
	
end


endmodule
