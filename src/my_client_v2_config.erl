-module(my_client_v2_config).

-export([get/1]).

get(Key) ->
    case application:get_env(my_client_v2, Key) of
        {ok, Val} ->
            Val;
        undefined ->
            {error, no_such_value}
    end.
