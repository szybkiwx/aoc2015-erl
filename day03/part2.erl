-module(part2).
-export([part2/1]).


part2(FileName) -> 
	{ok, Bin} = file:read_file(FileName),
	
	run(Bin).


run(Bin) -> follow_path(Bin, {0,0}, {0, 0},  #{{0,0} =>  1}).

next_pos($^, {X, Y}) -> {X, Y + 1};
next_pos($>, {X, Y}) -> {X + 1, Y};
next_pos($v, {X, Y}) -> {X, Y - 1};
next_pos($<, {X, Y}) -> {X - 1, Y};
next_pos(_,  {X, Y}) -> {X, Y}.

follow_path(<<Char1, Char2, Rest/binary>>, Pos1, Pos2, Presents) ->
	NextPos1 = next_pos(Char1, Pos1),
	NextPos2 = next_pos(Char2, Pos2), 
	
	NextPresents1 = maps:update_with(NextPos1, fun(V) -> V + 1 end, 1, Presents),
	NextPresents2 = maps:update_with(NextPos2, fun(V) -> V + 1 end, 1, NextPresents1),
	follow_path(Rest, NextPos1, NextPos2, NextPresents2);

follow_path(<<"\n">>, _, _, Presents) -> maps:size(Presents); 
follow_path(<<>>, _, _, Presents) -> maps:size(Presents).
	 

