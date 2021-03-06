%% Automatically generated, do not edit
%% Generated by gpb_compile version 3.21.0 on {{2018,7,26},{10,52,19}}
-module(my_client_v2_sample_type).

-export([encode_msg/1, encode_msg/2]).
-export([decode_msg/2]).
-export([merge_msgs/2]).
-export([verify_msg/1]).
-export([get_msg_defs/0]).
-export([get_msg_names/0]).
-export([get_enum_names/0]).
-export([find_msg_def/1, fetch_msg_def/1]).
-export([find_enum_def/1, fetch_enum_def/1]).
-export([enum_symbol_by_value/2, enum_value_by_symbol/2]).
-export([get_service_names/0]).
-export([get_service_def/1]).
-export([get_rpc_names/1]).
-export([find_rpc_def/2, fetch_rpc_def/2]).
-export([get_package_name/0]).
-export([gpb_version_as_string/0, gpb_version_as_list/0]).

-include("my_client_v2_sample_type.hrl").
-include("gpb.hrl").



encode_msg(Msg) -> encode_msg(Msg, []).


encode_msg(Msg, Opts) ->
    case proplists:get_bool(verify, Opts) of
      true -> verify_msg(Msg);
      false -> ok
    end,
    case Msg of
      #'my_client_v2.sample.type.FactResp'{} ->
	  'e_msg_my_client_v2.sample.type.FactResp'(Msg)
    end.


'e_msg_my_client_v2.sample.type.FactResp'(Msg) ->
    'e_msg_my_client_v2.sample.type.FactResp'(Msg, <<>>).


'e_msg_my_client_v2.sample.type.FactResp'(#'my_client_v2.sample.type.FactResp'{y
										   =
										   F1},
					  Bin) ->
    e_type_int32(F1, <<Bin/binary, 8>>).



e_type_int32(Value, Bin)
    when 0 =< Value, Value =< 127 ->
    <<Bin/binary, Value>>;
e_type_int32(Value, Bin) ->
    <<N:64/unsigned-native>> = <<Value:64/signed-native>>,
    e_varint(N, Bin).

e_varint(N, Bin) when N =< 127 -> <<Bin/binary, N>>;
e_varint(N, Bin) ->
    Bin2 = <<Bin/binary, (N band 127 bor 128)>>,
    e_varint(N bsr 7, Bin2).



decode_msg(Bin, MsgName) when is_binary(Bin) ->
    case MsgName of
      'my_client_v2.sample.type.FactResp' ->
	  'd_msg_my_client_v2.sample.type.FactResp'(Bin)
    end.



'd_msg_my_client_v2.sample.type.FactResp'(Bin) ->
    'dfp_read_field_def_my_client_v2.sample.type.FactResp'(Bin,
							   0, 0, id(undefined)).

'dfp_read_field_def_my_client_v2.sample.type.FactResp'(<<8,
							 Rest/binary>>,
						       Z1, Z2, F1) ->
    'd_field_my_client_v2.sample.type.FactResp_y'(Rest, Z1,
						  Z2, F1);
'dfp_read_field_def_my_client_v2.sample.type.FactResp'(<<>>,
						       0, 0, F1) ->
    #'my_client_v2.sample.type.FactResp'{y = F1};
'dfp_read_field_def_my_client_v2.sample.type.FactResp'(Other,
						       Z1, Z2, F1) ->
    'dg_read_field_def_my_client_v2.sample.type.FactResp'(Other,
							  Z1, Z2, F1).

'dg_read_field_def_my_client_v2.sample.type.FactResp'(<<1:1,
							X:7, Rest/binary>>,
						      N, Acc, F1)
    when N < 32 - 7 ->
    'dg_read_field_def_my_client_v2.sample.type.FactResp'(Rest,
							  N + 7, X bsl N + Acc,
							  F1);
'dg_read_field_def_my_client_v2.sample.type.FactResp'(<<0:1,
							X:7, Rest/binary>>,
						      N, Acc, F1) ->
    Key = X bsl N + Acc,
    case Key of
      8 ->
	  'd_field_my_client_v2.sample.type.FactResp_y'(Rest, 0,
							0, F1);
      _ ->
	  case Key band 7 of
	    0 ->
		'skip_varint_my_client_v2.sample.type.FactResp'(Rest, 0,
								0, F1);
	    1 ->
		'skip_64_my_client_v2.sample.type.FactResp'(Rest, 0, 0,
							    F1);
	    2 ->
		'skip_length_delimited_my_client_v2.sample.type.FactResp'(Rest,
									  0, 0,
									  F1);
	    5 ->
		'skip_32_my_client_v2.sample.type.FactResp'(Rest, 0, 0,
							    F1)
	  end
    end;
'dg_read_field_def_my_client_v2.sample.type.FactResp'(<<>>,
						      0, 0, F1) ->
    #'my_client_v2.sample.type.FactResp'{y = F1}.

'd_field_my_client_v2.sample.type.FactResp_y'(<<1:1,
						X:7, Rest/binary>>,
					      N, Acc, F1)
    when N < 57 ->
    'd_field_my_client_v2.sample.type.FactResp_y'(Rest,
						  N + 7, X bsl N + Acc, F1);
'd_field_my_client_v2.sample.type.FactResp_y'(<<0:1,
						X:7, Rest/binary>>,
					      N, Acc, _) ->
    <<NewFValue:32/signed-native>> = <<(X bsl N +
					  Acc):32/unsigned-native>>,
    'dfp_read_field_def_my_client_v2.sample.type.FactResp'(Rest,
							   0, 0, NewFValue).


'skip_varint_my_client_v2.sample.type.FactResp'(<<1:1,
						  _:7, Rest/binary>>,
						Z1, Z2, F1) ->
    'skip_varint_my_client_v2.sample.type.FactResp'(Rest,
						    Z1, Z2, F1);
'skip_varint_my_client_v2.sample.type.FactResp'(<<0:1,
						  _:7, Rest/binary>>,
						Z1, Z2, F1) ->
    'dfp_read_field_def_my_client_v2.sample.type.FactResp'(Rest,
							   Z1, Z2, F1).


'skip_length_delimited_my_client_v2.sample.type.FactResp'(<<1:1,
							    X:7, Rest/binary>>,
							  N, Acc, F1)
    when N < 57 ->
    'skip_length_delimited_my_client_v2.sample.type.FactResp'(Rest,
							      N + 7,
							      X bsl N + Acc,
							      F1);
'skip_length_delimited_my_client_v2.sample.type.FactResp'(<<0:1,
							    X:7, Rest/binary>>,
							  N, Acc, F1) ->
    Length = X bsl N + Acc,
    <<_:Length/binary, Rest2/binary>> = Rest,
    'dfp_read_field_def_my_client_v2.sample.type.FactResp'(Rest2,
							   0, 0, F1).


'skip_32_my_client_v2.sample.type.FactResp'(<<_:32,
					      Rest/binary>>,
					    Z1, Z2, F1) ->
    'dfp_read_field_def_my_client_v2.sample.type.FactResp'(Rest,
							   Z1, Z2, F1).


'skip_64_my_client_v2.sample.type.FactResp'(<<_:64,
					      Rest/binary>>,
					    Z1, Z2, F1) ->
    'dfp_read_field_def_my_client_v2.sample.type.FactResp'(Rest,
							   Z1, Z2, F1).






merge_msgs(Prev, New)
    when element(1, Prev) =:= element(1, New) ->
    case Prev of
      #'my_client_v2.sample.type.FactResp'{} ->
	  'merge_msg_my_client_v2.sample.type.FactResp'(Prev, New)
    end.

'merge_msg_my_client_v2.sample.type.FactResp'(#'my_client_v2.sample.type.FactResp'{y
										       =
										       PFy},
					      #'my_client_v2.sample.type.FactResp'{y
										       =
										       NFy}) ->
    #'my_client_v2.sample.type.FactResp'{y =
					     if NFy =:= undefined -> PFy;
						true -> NFy
					     end}.



verify_msg(Msg) ->
    case Msg of
      #'my_client_v2.sample.type.FactResp'{} ->
	  'v_msg_my_client_v2.sample.type.FactResp'(Msg,
						    ['my_client_v2.sample.type.FactResp']);
      _ -> mk_type_error(not_a_known_message, Msg, [])
    end.


'v_msg_my_client_v2.sample.type.FactResp'(#'my_client_v2.sample.type.FactResp'{y
										   =
										   F1},
					  Path) ->
    v_type_int32(F1, [y | Path]), ok.

v_type_int32(N, _Path)
    when -2147483648 =< N, N =< 2147483647 ->
    ok;
v_type_int32(N, Path) when is_integer(N) ->
    mk_type_error({value_out_of_range, int32, signed, 32},
		  N, Path);
v_type_int32(X, Path) ->
    mk_type_error({bad_integer, int32, signed, 32}, X,
		  Path).

mk_type_error(Error, ValueSeen, Path) ->
    Path2 = prettify_path(Path),
    erlang:error({gpb_type_error,
		  {Error, [{value, ValueSeen}, {path, Path2}]}}).


prettify_path([]) -> top_level;
prettify_path(PathR) ->
    list_to_atom(string:join(lists:map(fun atom_to_list/1,
				       lists:reverse(PathR)),
			     ".")).



-compile({nowarn_unused_function,id/1}).
-compile({inline,id/1}).
id(X) -> X.

-compile({nowarn_unused_function,cons/2}).
-compile({inline,cons/2}).
cons(Elem, Acc) -> [Elem | Acc].

-compile({nowarn_unused_function,lists_reverse/1}).
-compile({inline,lists_reverse/1}).
'lists_reverse'(L) -> lists:reverse(L).

-compile({nowarn_unused_function,'erlang_++'/2}).
-compile({inline,'erlang_++'/2}).
'erlang_++'(A, B) -> A ++ B.



get_msg_defs() ->
    [{{msg, 'my_client_v2.sample.type.FactResp'},
      [#field{name = y, fnum = 1, rnum = 2, type = int32,
	      occurrence = required, opts = []}]}].


get_msg_names() ->
    ['my_client_v2.sample.type.FactResp'].


get_enum_names() -> [].


fetch_msg_def(MsgName) ->
    case find_msg_def(MsgName) of
      Fs when is_list(Fs) -> Fs;
      error -> erlang:error({no_such_msg, MsgName})
    end.


fetch_enum_def(EnumName) ->
    erlang:error({no_such_enum, EnumName}).


find_msg_def('my_client_v2.sample.type.FactResp') ->
    [#field{name = y, fnum = 1, rnum = 2, type = int32,
	    occurrence = required, opts = []}];
find_msg_def(_) -> error.


find_enum_def(_) -> error.


enum_symbol_by_value(E, V) ->
    erlang:error({no_enum_defs, E, V}).


enum_value_by_symbol(E, V) ->
    erlang:error({no_enum_defs, E, V}).



get_service_names() -> [].


get_service_def(_) -> error.


get_rpc_names(_) -> error.


find_rpc_def(_, _) -> error.



fetch_rpc_def(ServiceName, RpcName) ->
    erlang:error({no_such_rpc, ServiceName, RpcName}).


get_package_name() -> 'my_client_v2.sample.type'.



gpb_version_as_string() ->
    "3.21.0".

gpb_version_as_list() ->
    [3,21,0].
