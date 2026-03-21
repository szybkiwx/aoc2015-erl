-module(day08).
-export([part1/1, part2/1]).

part1(FileName) ->

	process_file(FileName, fun(Line) -> Line end).

part2(FileName) ->

	process_file(FileName, fun encode_line/1).

process_file(FileName, PreProcessLine) ->
	{ok, Bin} = file:read_file(FileName),
	Lines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	Sums = [count_chars_full(PreProcessLine(Line)) || Line <- Lines],
	[io:format("~p - ~p\n", [All, Chars]) || {All, Chars} <- Sums],

	lists:sum([All - Chars || {All, Chars} <- Sums]).

encode_line(Line) -> 
	EncodedLine = encode_char(Line, <<>>),
	<<$", EncodedLine/binary, $">>.

encode_char(<<$", Rest/binary>>, Result) -> encode_char(Rest, <<Result/binary, $\\, $">>);
encode_char(<<$\\, Rest/binary>>, Result) -> encode_char(Rest, <<Result/binary, $\\, $\\>>);
encode_char(<<C, Rest/binary>>, Result) -> encode_char(Rest, <<Result/binary, C>>);
encode_char(<<>>, Result) -> Result.
	
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

	
	
	
	
