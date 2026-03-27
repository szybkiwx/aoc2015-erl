-module(day11).
-export([part1/1, is_password_valid/1, has_two_pairs/1, has_increasing/1, has_valid_letters/1, find_valid_next/1]).
part1(Input) ->
	find_valid_next(Input).


find_valid_next(Password) ->
	case is_password_valid(Password) of 
		true -> Password;
		_ -> find_valid_next(increment_password(Password))
	end.

increment_password(Password) -> 
	Rev = lists:reverse(Password),
	lists:reverse( increment(Rev, []) ).


increment([H|Rest], Result)  when H =:= $z ->
	increment(Rest, [$a | Result]);

increment([H|Rest], Result) when H =:= $h;H=:=$k;H=:=$n ->
	Result ++ [H + 2 | Rest];

increment([H|Rest], Result)  ->
	Result ++ [H + 1 | Rest].
	 

is_password_valid(Password) ->
	has_two_pairs(Password) andalso has_increasing(Password) andalso has_valid_letters(Password).

has_valid_letters([$i|_]) -> false; 
has_valid_letters([$o|_]) -> false; 
has_valid_letters([$l|_]) -> false;
has_valid_letters([_|Rest]) -> has_valid_letters(Rest);
has_valid_letters([]) -> true.

has_increasing([H|Rest]) ->
	has_increasing(Rest, H, 1).

has_increasing(_, _, 3) -> true;
has_increasing([H|Rest], Last, Cnt) when Last + 1  =:= H -> has_increasing(Rest, H, Cnt + 1); 

has_increasing([H|Rest], _, _) -> has_increasing(Rest, H, 1);
has_increasing([], _, _) -> false.

has_two_pairs([H|Rest]) -> has_two_pairs(Rest, H, 0, none).

has_two_pairs([H|_], Last, 1, PrevPairChar) when Last =:= H, H =/= PrevPairChar -> true;
has_two_pairs([H|Rest], Last, 0, _) when Last =:= H -> has_two_pairs(Rest, H, 1, H);
has_two_pairs([H|Rest], _, PairCnt, PrevPairChar) -> has_two_pairs(Rest, H, PairCnt, PrevPairChar);
has_two_pairs([], _, _, _) -> false.

