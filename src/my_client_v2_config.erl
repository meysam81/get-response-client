-module(my_client_v2_config).

-export([get/1,
         set/2]).

get(Key) ->
    case application:get_env(my_client_v2, Key) of
        {ok, Val} ->
            Val;
        undefined ->
            {error, no_such_value}
    end.
set(Key, Value) ->
    ok = application:set_env(my_client_v2, Key, Value).
