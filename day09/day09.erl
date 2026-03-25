-module(day09).
-export([part1/1]).


part1(FileName) ->
	{ ok, Bin } = file:read_file(FileName),
	RawLines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	
	Graph = build_graph(RawLines, #{}),
	Nodes = list_nodes(Graph),
	held_karp(Graph, Nodes).

held_karp(Graph, Nodes) ->
	SubsetCount = 1 bsl length(Nodes),
	Dp = fill_nested_list(SubsetCount, inf),
	Parents = fill_nested_list(SubsetCount, -1),
	Parents.			

fill_nested_list(Size, Value) ->
	#{ {R, C} => Value || R <- lists:seq(1, Size), C <- lists:seq(1, Size) }.


list_nodes(Graph) ->
	FullList =  [ C || {C1, C2} <- maps:keys(Graph), C <- [C1, C2]],
	lists:usort(FullList).

build_graph([Line|Rest], Graph) ->
	ParsedLine = parse_line(Line),
	build_graph(Rest, add_to_graph(ParsedLine, Graph));

build_graph([], Graph) -> Graph.


add_to_graph({Src, Dst, Distance}, Graph) ->
	Graph#{{Src, Dst} => Distance}#{{Dst, Src} => Distance}.

parse_line(Line) ->
	Pattern = "(\\S+) to (\\S+) = (\\d+)",
    {match, [Src, Dst, Distance]} = re:run(Line, Pattern, [{ capture, all_but_first, binary }]),
	{Src, Dst, binary_to_integer(Distance)}.
	
