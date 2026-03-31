-module(day12).

-export([part1/1]).

part1(FileName) -> 
	{ok, Bin} = file:read_file(FileName),
	{match, Matches} = re:run(Bin, "-?\\d+", [global, {capture, all, list}]),
	Numbers = [ list_to_integer(Number) || [Number] <- Matches],
	lists:sum(Numbers).
	%io:format("~p~n", [Numbers]).

% Result: [["161"],["-14"],["-35"],["0"]]

