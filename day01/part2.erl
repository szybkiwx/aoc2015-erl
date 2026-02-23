-module(part2).
-export([part2/1]).

part2(FileName) ->
	{ok, Binary } = file:read_file(FileName),
	Result = parse_binary(Binary, 0, 1),

	io:format("Result ~p~n", [Result]).

parse_binary(<<>>,_, Step) -> Step;

parse_binary(<<Char:8, Rest/binary>>, Floor, Step) ->
	NextFloor = case Char of 
		$( -> Floor + 1;
		$) -> Floor -1;
		_ -> 
			io:format("Ignoring ~p~n", [Char]),
			Floor
	end,
	if 
		NextFloor =:= -1 ->
			Step;
	 	true ->
			parse_binary(Rest, NextFloor, Step + 1)	
	end.

	
