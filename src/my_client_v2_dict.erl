-module(my_client_v2_dict).

-export([start/0]).

-export([init/0,
         get_by_code/1,
         get_by_name/1,
         get_new_tid/0]).

-include("my_client_v2.hrl").

start() ->
    spawn(my_client_v2_dict, init, []).

init() ->
    case ets:info(?NAME_TABLE) of
        undefined ->
            ?NAME_TABLE = ets:new(?NAME_TABLE, [named_table, public]);
        _ ->
            ok
    end,
    case ets:info(?CODE_TABLE) of
        undefined ->
            ?CODE_TABLE = ets:new(?CODE_TABLE, [named_table, public]);
        _ ->
            ok
    end,
    case ets:info(?MESSAGE_COUNTER_TABLE) of
        undefined ->
            ?MESSAGE_COUNTER_TABLE = ets:new(?MESSAGE_COUNTER_TABLE,
                                             [named_table, public]),
            ets:insert(?MESSAGE_COUNTER_TABLE, {message_counter, 1});
        _ ->
            ok
    end,

    [begin
         ets:insert(?NAME_TABLE, {Name, Code, Actor, Codec}),
         ets:insert(?CODE_TABLE, {Code, Name, Actor, Codec})
     end ||
        #{code := Code,
          name := Name,
          actor := Actor,
          codec := Codec} <- get_list()],
    ok.

get_list() ->
    [
      %% =============== funcs ==================
      #{name => 'my_client_v2.sample.func.Fact',
        code => 51,
        actor => my_app_v4_actor,
        codec => my_client_v2_sample_func},

      %% =============== types ==================
      #{name => 'my_client_v2.sample.type.FactResp',
        code => 1,
        actor => undefined,
        codec => my_client_v2_sample_type}
     ].

get_by_code(Code) ->
    case ets:lookup(?CODE_TABLE, Code) of
        [{_Code, _Name, _Actor, _Codec}] = Response ->
            Response;
        _ ->
            {error, undefined}
    end.
get_by_name(Name) ->
    case ets:lookup(?NAME_TABLE, Name) of
        [{_Code, _Name, _Actor, _Codec}] = Response ->
            Response;
        _ ->
            {error, undefined}
    end.

get_new_tid() ->
    case ets:lookup(?MESSAGE_COUNTER_TABLE, message_counter) of
        [{message_counter, Value}] ->
            true = ets:update_element(?MESSAGE_COUNTER_TABLE, message_counter,
                              {2, Value + 1}),
            Value;
        Elem ->
            ?LOG_ERROR("failed in dictionary search: ~p", [Elem]),
            false
    end.
