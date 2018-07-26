-module(my_client_v2_worker).

-behaviour(gen_server).

-include("my_client_v2.hrl").

%% API
-export([start_link/0]).

%% gen_server callbacks
-export([init/1,
         handle_call/3, handle_cast/2, handle_info/2,
         terminate/2,
         code_change/3,
         format_status/2]).

-define(SERVER, ?MODULE).

-record(state, {requests, socket, buffer}).

%%%===================================================================
%%% API
%%%===================================================================
start_link() ->
    gen_server:start_link(?MODULE, [], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================
init([]) ->
    process_flag(trap_exit, true),

    Host = get_val(host),
    Port = get_val(port),
    Socket = gen_tcp:connect(Host, Port, [binary]),

    State = #state{requests = maps:new(),
                   buffer = <<>>,
                   socket = Socket},

    {ok, State}.


handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.


handle_cast({From, #message{tracking_id = Tracking_id} = Message},
            #state{requests = Requests,
                   socket = Socket} = State) ->

    {ok, Frame} = encode(Message),

    NewRequests = maps:put(Tracking_id, From, Requests),

    ok = gen_tcp:send(Socket, Frame),

    {noreply, State#state{requests = NewRequests}};
handle_cast(_Request, State) ->
    {noreply, State}.




handle_info({tcp, Socket, Data}, #state{socket = Socket,
                                        requests = Requests,
                                        buffer = Buffer} = State) ->
    case parse_buffer(Buffer, Data) of
        #parsed_buffer{framed = Framed, buffered = Buffered} ->

            Msgs = [decode(Frame) || Frame <- Framed],

            ClientRequest = [#client_request{message = #message{} = Msg} ||
                                Msg <- Msgs],

            {NewClientRequest, NewRequests} =
                get_new_requests(ClientRequest, Requests),


            [dispatch_messages(Msg) || Msg <- NewClientRequest],


            {noreply, State#state{buffer = Buffered,
                                  requests = NewRequests}};
        _ ->
            {noreply, State}
    end;
handle_info(_Info, State) ->
    {noreply, State}.




terminate(_Reason, _State) ->
    ok.
code_change(_OldVsn, State, _Extra) ->
    {ok, State}.
format_status(_Opt, Status) ->
    Status.

%%%===================================================================
%%% Internal functions
%%%===================================================================
get_val(Key) ->
    my_client_v2_config:get(Key).


encode(Obj) ->
    my_client_v2_codec:encode_frame(Obj).
decode(Obj) ->
    my_client_v2_codec:deframe_decode(Obj).
parse_buffer(OldBuffer, NewData) ->
    my_client_v2_codec:parse_buffer(OldBuffer, NewData).


dispatch_messages(#client_request{caller = Caller,
                                  message = Message}) ->
    Caller ! {response, Message},
    ok;
dispatch_messages(_) ->
    false.


get_new_requests(#client_request{} = Msgs, Requests) ->
    get_new_requests(Msgs, Requests, 0, length(Msgs));
get_new_requests(_, _) ->
    {error, bad_argument}.

get_new_requests(Msgs, Requests, Counter, Counter) ->
    {Msgs, Requests};
get_new_requests(Msgs, Requests, Counter, N)
  when Counter > 0, N > 0 ->
    case lists:nth(Counter + 1, Msgs) of
        #client_request{message = Message} ->

            Tid = Message#message.tracking_id,
            {ok, Pid} = maps:find(Tid, Requests),

            NewMsgs = lists:sublist(Msgs, Counter) ++
                [#client_request{caller = Pid,
                                 message = Message}] ++
                lists:nthtail(Counter + 1, Msgs),

            NewRequests = maps:remove(Tid, Requests),

            get_new_requests(NewMsgs, NewRequests, Counter + 1, N);
        _ ->
            get_new_requests(Msgs, Requests, Counter + 1, N)
    end;
get_new_requests(_, _, _, _) ->
    false.
