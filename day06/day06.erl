-module(day06).
-export([part1/1, part2/1]).


part1(FileName) -> 
	process_rules(FileName, fun set_light/4).	


part2(FileName) -> 
	process_rules(FileName, fun set_light2/4).	

process_rules(FileName, SetLight) ->
	{ok, Bin} = file:read_file(FileName),
	Lines = binary:split(Bin, <<"\n">>, [global, trim_all]),
	Instructions = [parse_line(Line) || Line <- Lines],
	FinalLightsMap = apply_rules(Instructions, #{}, SetLight),
	lists:sum(maps:values(FinalLightsMap)).	

apply_rules([Rule|Rest], LightsMap, SetLight) -> 
	{ Action, X1, Y1, X2, Y2 } = Rule,
	XRange = lists:seq(X1, X2),
	YRange = lists:seq(Y1, Y2),

	FinalMap = lists:foldl(fun(X, MapAcc1) ->
    	lists:foldl(fun(Y, MapAcc2) ->
        	MapAcc2#{ {X, Y} => SetLight(Action, MapAcc2, X, Y) }
    	end, MapAcc1, YRange)
	end, LightsMap, XRange),

	apply_rules(Rest, FinalMap, SetLight);

apply_rules([], LightsMap, _) -> LightsMap.

set_light(Action, Map, X, Y) ->
	Current = maps:get({X, Y}, Map, 0),
	resolve_action(Action, Current).

resolve_action(<<"toggle">>, 0) -> 1;
resolve_action(<<"toggle">>, 1) -> 0;
resolve_action(<<"turn on">>, _) -> 1;
resolve_action(<<"turn off">>, _) -> 0.

set_light2(Action, Map, X, Y) ->
	Current = maps:get({X, Y}, Map, 0),
	resolve_action2(Action, Current).
	
resolve_action2(<<"turn on">>, Current) -> Current + 1; 
resolve_action2(<<"turn off">>, Current) when Current > 0 -> Current -1; 
resolve_action2(<<"turn off">>, 0) -> 0; 
resolve_action2(<<"toggle">>, Current) -> Current + 2. 



parse_line(Line) ->
    Pattern = "(toggle|turn off|turn on) (\\d+),(\\d+) through (\\d+),(\\d+)",
    {match, [Action, X1, Y1, X2, Y2]} = 
        re:run(Line, Pattern, [{capture, all_but_first, binary}]),
    
    {Action, 
     binary_to_integer(X1), binary_to_integer(Y1), 
     binary_to_integer(X2), binary_to_integer(Y2)}.	
