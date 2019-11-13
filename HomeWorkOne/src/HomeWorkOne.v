module HomeWorkOne(
	input				Asynch_in		,
	input				clock					,
	input				reset					,
	
	output	reg	Synch_out
);

reg temp = 1'b0;

always@(posedge clock) begin
	
	if(reset) begin
		
		Synch_out	<=	1'b0			;
		
	end
	else begin
	
		Synch_out	=	temp			;
		temp			=	Asynch_in	;
	
	end

end

endmodule

