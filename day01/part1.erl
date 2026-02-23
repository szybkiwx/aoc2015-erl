-module(day01).
-export([part1/1]).

part1(FileName) ->
	{ok, Binary } = file:read_file(FileName),
	Result = parse_binary(Binary, 0),

	io:format("Result ~p~n", [Result]).

parse_binary(<<>>, Floor) -> Floor;

parse_binary(<<Char:8, Rest/binary>>, Floor) ->
	case Char of 
		$( -> parse_binary(Rest, Floor + 1);
		$) -> parse_binary(Rest, Floor -1);
		_ -> 
			io:format("Ignoring ~p~n", [Char]),
			parse_binary(Rest, Floor)
	end.
	
