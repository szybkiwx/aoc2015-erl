-module(day07).
-export([part1/1]).

-define(MASK, 65535).

part1(FileName) -> 
	{ok,Bin} = file:read_file(FileName),
	Lines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	Instructions = [parse_line(Line) || Line <- Lines],
	Results = process_instructions(Instructions, #{}),
	%io:format("~p", [Results]),
	maps:get(<<"a">>, Results).	


process_instructions([Instruction|Rest], Map) ->
	NewMap = case Instruction of 
		{not_op, Src, Dst} -> process_not(Src, Dst, Map);
		{assign, Val, Dst} -> process_assign(Val, Dst, Map);
		{op, Op, Src1, Src2, Dst} -> process_op(Op, Src1, Src2, Dst, Map)
	end,

	process_instructions(Rest, NewMap);

process_instructions([], Map) -> Map.


process_not(Src, Dst, Map) ->
	SrcVal = maps:get(Src, Map, 0),
	NewVal = (bnot SrcVal) band ?MASK,
	Map#{Dst => NewVal}.

process_assign(Val, Dst, Map) ->

	FinalVal = case string:to_integer(Val) of
        {Int, <<>>} when is_integer(Int) -> Int;
        _ -> maps:get(Val, Map, 0)
    end,

	Map#{Dst => FinalVal}.
process_op(Op, Src1, Src2, Dst, Map) ->
	SrcVal1 = maps:get(Src1, Map, 0),
	SrcVal2 = maps:get(Src2, Map, 0),

	Result = case Op of 
		<<"RSHIFT">> -> SrcVal1 bsr SrcVal2;
		<<"LSHIFT">> -> SrcVal1 bsl SrcVal2;
		<<"AND">> -> SrcVal1 band SrcVal2;
		<<"OR">> -> SrcVal1 bor SrcVal2
	end,

	Map#{Dst => Result band ?MASK}.


parse_line(Line) ->
	Words = string:lexemes(Line, " ->\n"),
	match_words(Words).


match_words([<<"NOT">>, Src, Dst]) -> {not_op, Src, Dst};
match_words([Val, Dst]) -> {assign, Val, Dst};
match_words([Src1, Op, Src2, Dst]) -> {op, Op, Src1, Src2, Dst}. 
