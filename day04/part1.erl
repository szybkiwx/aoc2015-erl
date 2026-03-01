-module(part1).
-export([part1/1]).

part1(Input) -> 
	check_next(Input, 1).

check_next(Input, Int) ->
	Raw = Input ++ integer_to_list(Int),
	Hash = binary:encode_hex(crypto:hash(md5, Raw)),
	
	case Hash of 
		<<"00000", _Rest/binary>> -> Int;
		_ -> check_next(Input, Int +1)
	end. 
