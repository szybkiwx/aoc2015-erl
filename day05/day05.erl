-module(day05).
-export([part1/1, part2/1]).

part1(FileName) -> 
	{ok, Bin} = file:read_file(FileName),
	Lines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	NiceLines = [X || X <:- Lines, is_nice(X)],
	io:format("~p~n", [NiceLines]),
	length(NiceLines).

is_nice(Line) ->
	has_double(Line) andalso has_3vowels(Line) andalso has_no_excluded(Line).

has_3vowels(Line) ->
	CharsToFind = "aeiou",
	Set = sets:from_list(CharsToFind),
	has_3vowels(Line, Set, 0).

has_3vowels(<<X,Rest/binary>>, Set, Result) -> 
    case sets:is_element(X, Set) of 
		true -> 
			case Result == 2 of 
				true -> true;
				false -> has_3vowels(Rest, Set, Result + 1)
			end;
		false -> has_3vowels(Rest, Set, Result)
	end;

has_3vowels(<<>>, _, _) -> false.
		

has_no_excluded(<<"ab", _Rest/binary>>) -> false;
has_no_excluded(<<"cd", _Rest/binary>>) -> false;
has_no_excluded(<<"pq", _Rest/binary>>) -> false;
has_no_excluded(<<"xy", _Rest/binary>>) -> false;
has_no_excluded(<<_, Rest/binary>>) -> has_no_excluded(Rest);
has_no_excluded(_) -> true. 
	%ab, cd, pq, or xy
	

has_double(<<Char, Char, _Rest/binary>>) -> true;
has_double(<<_, Rest/binary>>) -> has_double(Rest);
has_double(_) -> false.
	

part2(FileName) ->
	{ok, Bin} = file:read_file(FileName),
	Lines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	NiceLines = [X || X <:- Lines, is_nice2(X)],
	io:format("~p~n", [NiceLines]),
	length(NiceLines).


is_nice2(Line) ->
	has_double_pair(Line) andalso has_one_between(Line).

has_double_pair(<<Char1,Char2,Rest/binary>>) ->
	case binary:match(Rest, <<Char1, Char2>>) of 
		nomatch -> has_double_pair(<<Char2, Rest/binary>>);
		_ -> true
	end;

has_double_pair(_) -> false.
 
	 

has_one_between(<<Outer,_Inner,Outer,_Rest/binary>>) -> true;
has_one_between(<<_, Rest/binary>>) -> has_one_between(Rest);
has_one_between(_) -> false.
	 


