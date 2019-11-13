module HomeWorkTwo(
	input				clock				,
	input				Asynch_in	,
	
	output	reg	Synch_out
);

reg		q1			=	1'b0				;
reg		q2			=	1'b0				;
wire		reset								;

assign	reset	=	Synch_out&(~Asynch_in)	;

always@(posedge clock) begin
		
	Synch_out	=	q2					;
	q2						=	q1					;
	
end

always@(posedge Asynch_in) begin
		
	if(reset) begin
		
		q1					=	1'b0				;
		
	end
	else begin
		
		q1					=	1'b1				;
	
	end
	
end


endmodule
