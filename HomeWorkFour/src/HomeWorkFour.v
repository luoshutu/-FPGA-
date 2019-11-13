module HomeWorkFour (
	input		clk								,
	input		rst								,
	input		[31:0] Data			,
	output	reg [5:0] Gap
);

parameter	s_idle=2'd0, s_1=2'd1, s_2=2'd2, s_done=2'd3			;

reg	flush_tmp, incr_tmp, store_tmp, incr_k											;
reg	[1:0] state, next_state									;
reg	[5:0] tmp, k																;
wire	Bit																					;

assign	Bit = Data[k]														;

always @(posedge clk) begin
	if(rst)	begin
		state							<=	s_idle								;
		k										<=	1'b0									;
		tmp								<=	1'b0									;
		Gap								<=	1'b0									;
	end
	else	begin
		state							<=next_state						;
		
		if(flush_tmp)tmp<=1'b0									;
		if(store_tmp)Gap<=tmp									;
		if(incr_k)		  k		<=k+1'b1								;
		if(incr_tmp)  tmp<=tmp+1'b1						;	
	end
end

always @(state or Bit or k) begin
	next_state					<=	state								;	
	incr_tmp						<=	1'b0									;
	incr_k								<=	1'b0									;
	store_tmp					<=	1'b0									;
	flush_tmp					<=	1'b0									;

	case(state)
	s_idle:	begin
		if(k == 6'd31)	begin
			next_state			<=	s_done							;
		end
		else	begin
			if(Bit) begin
				next_state		<=	s_1									;
				incr_k					<=	1'b1									;
			end	
			else begin
				next_state		<=	s_idle								;
				incr_k					<=	1'b1									;
			end	
		end
	end
	s_1:	begin
		if(k == 6'd31)	begin
			next_state		<=	s_done								;
		end
		else if(!Bit)	begin
			next_state		<=	s_2										;
			incr_k					<=	1'b1										;
			incr_tmp			<=	1'b1										;
		end
		else begin
			next_state		<=	s_1										;
			incr_k					<=	1'b1										;
		end
	end
	s_2 :	begin
		if(k == 6'd31)	begin
			if(Bit)	begin
				if(tmp	>	Gap)	begin
					store_tmp	<=	1'b1									;
					next_state	<=	s_done							;
				end
				else begin
					next_state	<=	s_done							;
				end
			end
			else begin
				next_state		<=	s_done							;
			end
		end
		else begin
			if(Bit)	begin
				if(tmp	>	Gap)	begin
					store_tmp	<=	1'b1									;
					next_state	<=	s_1									;
					incr_k				<=	1'b1									;
					flush_tmp	<=	1'b1									;
				end
				else begin
					flush_tmp	<=	1'b1									;
					incr_k				<=	1'b1									;
				end
			end
			else begin
				incr_tmp			<=	1'b1									;
				incr_k					<=	1'b1									;
				next_state		<=	s_2									;
			end
		end
	end
	s_done:	begin
		next_state				<=	s_idle								;
		incr_k							<=	1'b0									;
	end
	default :
		next_state				<=	s_idle								;
	endcase
end

endmodule
