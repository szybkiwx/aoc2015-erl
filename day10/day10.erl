-module(day10).
-export([part1/1, test/1]).

part1(Input) ->
	Digits = [X - $0 || X <- Input],
	
	iterate(40, Digits).
	
test(Input) ->
	[H|Rest] = [X - $0 || X <-Input],
	count_chars(Rest, H, 1, []).

count_chars([H|Rest], H, PrevCount, Result) -> count_chars(Rest, H, PrevCount + 1, Result);
count_chars([H|Rest], PrevChar, PrevCount, Result) -> count_chars(Rest, H, 1, [PrevChar, PrevCount | Result]);
count_chars([], PrevChar, PrevCount, Result) -> lists:reverse([PrevChar, PrevCount | Result]).


iterate(N, Digits) when N > 0 ->
	io:format("iteration: ~p~n", [N]),
	[H|Rest] = Digits,
	NextDigits = count_chars(Rest, H, 1, []),
	iterate(N - 1, NextDigits);

iterate(0, Digits) -> length(Digits). 	





