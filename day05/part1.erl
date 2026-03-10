-module(day5).
-export([part1/1]).

part1(FileName) -> 
	{ok, Bin} = file:read_file(FileName),
	Lines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	NiceLines = [X || X <:- Lines, is_nice(X)].
	length(NiceLines).

is_nice(Line) ->
	has_double(Line) && has_vowel(Line).

has_vowel(Line) -> 
	CharsToFind = "aeiou",
	FindSet = sets:from_list(CharsToFind),
	TargetSet = sets:from_list(binary_to_list(Line)),

	not sets:is_disjoint(FindSet, TargetSet).

has_double(<<Char, Char, _Rest/binary>>) -> true,
has_double(<<_, _Rest/binary>>) -> false,
has_double(<<_>>) -> false.
	

