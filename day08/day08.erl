-module(day08).
-export([part1/1]).

part1(FileName) ->
	{ok, Bin} = file:read_file(FileName),
	Lines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	Sums = [count_chars_full(Line) || Line <- Lines],
	[io:format("~p - ~p\n", [All, Chars]) || {All, Chars} <- Sums],

	lists:sum([All - Chars || {All, Chars} <- Sums]).
	
count_chars_full(FullLine) ->
	FullSize = byte_size(FullLine),
	Line = binary:part(FullLine, 1, byte_size(FullLine) - 2),
	%io:format("~p", [Line]).

	Chars = count_chars(Line, 0),
	{FullSize, Chars}.


count_chars(<<$\\,$", Rest/binary>>, Cnt) -> count_chars(Rest, Cnt+1) ;
count_chars(<<$\\,$\\, Rest/binary>>, Cnt) -> count_chars(Rest, Cnt+1) ;
count_chars(<<$\\,$x, _, _, Rest/binary>>, Cnt) -> count_chars(Rest, Cnt +1);
count_chars(<<_, Rest/binary>>, Cnt) -> count_chars(Rest, Cnt + 1);
count_chars(<<>>, Cnt) -> Cnt.

	
	
	
	
