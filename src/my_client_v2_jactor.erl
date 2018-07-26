-module(my_client_v2_jactor).

-export([start/0]).

-include("my_client_v2.hrl").
-include("my_client_v2_sample_func.hrl").
-include("my_client_v2_sample_type.hrl").


start() ->
    Message = #message{object = #'my_client_v2.sample.func.Fact'{x = 5},
                       type = request,
                       flags = 2#00100000},
    my_client_v2_worker:send(Message),
    receive
        {response, #message{
                      object = #'my_client_v2.sample.type.FactResp'{y = Resp},
                      tracking_id = Tid}} ->
            ?LOG_INFO("I'm ~p, I asked for fact(5), and I got ~p with Tid: ~p",
                      [self(), Resp, Tid]),
            ok;
        _ ->
            {error, bad_response_received}
    end.
