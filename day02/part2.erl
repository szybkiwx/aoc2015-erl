-module(part2).
-export([part2/1]).


part2(FileName) ->
	Lines = read_lines(FileName),

	Boxes = [parse_line(L) || L <- Lines],
	Sizes = lists:map(
				fun({A1, A2, A3 }) -> 
					[Min, NextMin | _] = lists:sort(fun sort/2, [A1, A2, A3]),
					io:format("~p ~p ~p|~p ~p ~n", [A1, A2, A3, Min, NextMin]),
					 (A1*A2*A3)+2*Min + 2 * NextMin
				end,
			    Boxes
			),	

	lists:sum(Sizes).



sort(A, B) -> A < B.


parse_line(Line) ->
	Parts = binary:split(Line, <<"x">>, [global]),
	Sizes = [binary_to_integer(P) || P <- Parts],
	[L, W, H] = Sizes,
	{L, W, H}.


read_lines(FileName) ->
	{ok, Bin} = file:read_file(FileName),
	binary:split(Bin, <<"\n">>, [global, trim_all]).


	
