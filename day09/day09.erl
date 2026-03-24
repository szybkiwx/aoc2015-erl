-module(day09).
-export([part1/1]).


part1(FileName) ->
	{ ok, Bin } = file:read_file(FileName),
	RawLines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	
	build_graph(RawLines, #{}).

build_graph([Line|Rest], Graph) ->
	ParsedLine = parse_line(Line),
	build_graph(Rest, add_to_graph(ParsedLine, Graph));

build_graph([], Graph) -> Graph.


add_to_graph({Src, Dst, Distance}, Graph) ->
	CurrentSrc = maps:get(Src, Graph, []),
	GraphWithSrc = Graph#{Src => [ { Dst, Distance } | CurrentSrc ]},
	CurrentDst = maps:get(Dst, GraphWithSrc, []),
	GraphWithSrc#{Dst => [ { Src, Distance } | CurrentDst ]}.


parse_line(Line) ->
	Pattern = "(\\S+) to (\\S+) = (\\d+)",
    {match, [Src, Dst, Distance]} = re:run(Line, Pattern, [{ capture, all_but_first, binary }]),
	{Src, Dst, Distance}.
	
