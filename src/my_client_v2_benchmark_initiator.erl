-module(my_client_v2_benchmark_initiator).

-export([start/0, run_clients/0]).

-include("my_client_v2.hrl").

start() ->
    NumberOfClients = get_val(number_of_clients),
    TimeBetweenBenchmarks = get_val(time_between_benchmarks),
    _ = [begin
             ?LOG_INFO("Initiating requests from ~p clients", [N]),
             [spawn(?MODULE, run_clients, []) || _ <- lists:seq(1, N)],
             timer:sleep(TimeBetweenBenchmarks)
         end || N <- NumberOfClients],
    ok.
run_clients() ->
    my_client_v2_jactor:start().

get_val(Key) ->
    my_client_v2_config:get(Key).
