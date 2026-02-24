-module(part1).
-export([part1/1]).


part1(FileName) ->
	Lines = read_lines(FileName),

	Boxes = [parse_line(L) || L <- Lines],
	Areas = [[L * W,  W * H , H * L] || {L, W, H} <- Boxes],
	Sizes = lists:map(fun(Area) -> [A1, A2, A3] = Area, Slack = lists:min(Area), 2*(A1+A2+A3)+Slack end, Areas),	



	lists:sum(Sizes).



parse_line(Line) ->
	Parts = binary:split(Line, <<"x">>, [global]),
	Sizes = [binary_to_integer(P) || P <- Parts],
	[L, W, H] = Sizes,
	{L, W, H}.


read_lines(FileName) ->
	{ok, Bin} = file:read_file(FileName),
	binary:split(Bin, <<"\n">>, [global, trim_all]).


	
