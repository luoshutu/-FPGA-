module	HomeWorkFive(
	input	rst													,
	input	clk													,
	input	Send											,
	input	Sort												,
	input	Load											,
	input	[3:0]Data_in							,
	
	output	wire	Waiting						,
	output	wire	Busy							,	
	output	wire	Ready						,
	output	reg[3:0]Data_out	
);

parameter   S_rst		=	0		;
parameter   S_init		=	1		;
parameter   S_idle		=	2		;
parameter   S_load	=	3		;
parameter   S_prep	=	4		;
parameter   S_sort		=	5		;
parameter   S_wait		=	6		;
parameter   S_send	=	7		;

reg	[2:0]	state, next_state	;

wire	gt, i_lte_N, j_gte_i, done;
reg	ld, set_i, incr_i, set_j, decr_j, clr_k, incr_k, swap, snd;

reg	[3:0]	A[1:8]		;
reg	[3:0]	i, j, k			;

always @(posedge clk)	begin
	if(rst)	state	<=	0							;
	else 	state	<=	next_state	;
end

always @(state,Load,Sort,Send,done,gt,i_lte_N,j_gte_i)	begin
	next_state	=	S_rst				;	
	ld						=	0							;
	set_i				=	0							;
	incr_i				=	0							;
	set_j				=	0							;
	decr_j			=	0							;
	clr_k				=	0							;
	incr_k				=	0							;
	swap				=	0							;
	snd					=	0							;
	case(state)
	 S_rst:
					begin
						if(rst)	next_state	=	S_rst	;
						else 	next_state	=	S_init	;
				  end
	 S_init: 
					begin 
						clr_k						=	1					;
						next_state			=	S_idle	; 
					end
	 S_idle: 
					begin
						if(Load)	begin
							ld							=	1					; 
							next_state		=	S_load	;
						end
						else begin 
							if(Sort)	begin 
								set_i				=	1					;
								set_j				=	1					;
								next_state	=	S_prep	;
							end
							else 
								next_state	=	S_idle	;
						end 
					end
	 S_load:
					begin
						if(done) 
							next_state		=	S_init		;
						else	begin
							incr_k					=	1					;
							ld							=	1					;
							next_state		=	S_load	;
						end
					end
	 S_prep: 
					begin
						if(!gt)
							next_state		=	S_sort	;
						else	begin 
							swap					=	1					;
							decr_j				=	1					;
							next_state		=	S_sort	;
						end
					end
	 S_sort:
					begin
						if(j_gte_i)	begin
							next_state		=	S_sort	;
							decr_j				=	1					;
							if(gt)	swap	=	1					;
						end
						else if(i_lte_N)	begin
							incr_i					=	1					;
							set_j					=	1					;
							next_state		=	S_sort	;
						end
						else if(Send)	begin
							next_state		=	S_send	;
							snd						=	1					;
							clr_k					=	1					;
						end
						else
							next_state		=	S_wait	;
					end 
	 S_wait:
					begin
						if(Send)	begin
						snd							=	1					;
						clr_k						=	1					;
						next_state			=	S_send	; 
						end
						else
							next_state		=	S_wait	;
					end
	 S_send:
					begin
						if(done)
							next_state		=	S_init		;
						else	begin
							incr_k					=	1					;
							snd						=	1					;
							next_state		=	S_send	;
						end
					end
	 endcase
end

assign  Ready		=		(state==S_idle)		;
assign  Busy			=		(state==S_sort)		;
assign  Waiting	=		(state==S_wait)		;

always @(posedge clk)	begin
	if(rst)	begin
		i			<=	0	;	j			<=	0	;	k			<=	0	;
		A[1]	<=	0	;	A[2]	<=	0	;	A[3]	<=	0	;
		A[4]	<=	0	;	A[5]	<=	0	;	A[6]	<=	0	;
		A[7]	<=	0	;	A[8]	<=	0	;
		Data_out		<=	0				;
	end
	else	begin 
		if(ld) begin
			A[1]	<=	Data_in	;
			A[2]	<=	A[1]			;
			A[3]	<=	A[2]			;
			A[4]	<=	A[3]			;
			A[5]	<=	A[4]			;
			A[6]	<=	A[5]			;
			A[7]	<=	A[6]			;
			A[8]	<=	A[7]			;
		end
		if(set_i)		i	<=	2		;
		if(incr_i)	i	<=	i+1;
		if(set_j)		j	<=	8		;
		if(decr_j)	j	<=	j-1	;
		if(clr_k)		k	<=	0		;
		if(incr_k)	k	<=	k+1;
		if(swap)	begin
			A[j]		<=	A[j-1]	;
			A[j-1]	<=	A[j]		;
		end
		if(snd)	begin
			Data_out	<=	A[8]	;
			A[8]				<=	A[7]	;
			A[7]				<=	A[6]	;
			A[6]				<=	A[5]	;
			A[5]				<=	A[4]	;
			A[4]				<=	A[3]	;
			A[3]				<=	A[2]	;
			A[2]				<=	A[1]	;
			A[1]				<=	0			;
		end
	end
 end
 
assign  gt				=	(A[j-1]	>		A[j]	)	;
assign  i_lte_N	=	(i					<=	8			)	;
assign  j_gte_i		=	(i					<=	j			)	;
assign  done		=	(k				==	7			)	;

endmodule
