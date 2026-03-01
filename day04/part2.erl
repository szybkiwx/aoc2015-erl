-module(part2).
-export([part2/1]).

part2(Input) -> 
	check_next(Input, 1).

check_next(Input, Int) ->
	Raw = Input ++ integer_to_list(Int),
	Hash = binary:encode_hex(crypto:hash(md5, Raw)),
	
	case Hash of 
		<<"000000", _Rest/binary>> -> Int;
		_ -> check_next(Input, Int +1)
	end. 
