-module(my_client_v2_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    my_client_v2_dict:init(),

    ok = application:ensure_started(toveri),

    ToveriRef = get_val(toveri_ref),
    MFA = get_val(mfa),
    ToveriSize = get_val(toveri_size),



    {ok, _} = toveri:new(ToveriRef, ToveriSize),
    ok = toveri:add_child(ToveriRef, MFA, ToveriSize),

    my_client_v2_sup:start_link().

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
get_val(Key) ->
    my_client_v2_config:get(Key).
