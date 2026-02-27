-module(part1).
-export([part1/1]).


part1(FileName) -> 
	{ok, Bin} = file:read_file(FileName),
	
	run(Bin).


run(Bin) -> follow_path(Bin, {0,0}, #{{0,0} =>  1}).

follow_path(<<Char:8,Rest/binary>>, {X, Y}, Presents) ->
	NextPos = case Char of 
	$^ -> {X, Y +1};
	$> -> {X + 1, Y };
	$v -> {X, Y - 1};
	$< -> {X - 1, Y};
	_ -> {X, Y}
	end,
	
	NextPresents = maps:update_with(NextPos, fun(V) -> V + 1 end, 1, Presents),
	follow_path(Rest, NextPos, NextPresents);

follow_path(<<>>, _, Presents) -> maps:size(Presents).
	 

