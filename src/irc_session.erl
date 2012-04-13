-module(irc_session).

-export([init/1, handle_cast/2, handle_call/3, handle_info/2, terminate/2]).

-export([start/3, start_link/3, stop/0]).

-export([msg/2, join/1]).

-record(state, {sock}).

start(Host, Port, Id) ->
    gen_server:start({local, ?MODULE}, ?MODULE, [Host, Port, Id], []).

start_link(Host, Port, Id) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [Host, Port, Id], []).

join(Room) ->
    gen_server:call(?MODULE, {join, Room}).

msg(To, Msg) ->
    gen_server:cast(?MODULE, {msg, To, Msg}).

stop() ->
    gen_server:cast(?MODULE, stop).

init([Host, Port, Id]) ->
    {ok, Sock} = gen_tcp:connect(Host, Port, [list, {active, true}, {packet, line}]),
    gen_tcp:send(Sock, [<<"USER ">>, Id, <<" 0 * :IerlC\r\n">>]),
    gen_tcp:send(Sock, [<<"NICK ">>, Id, <<"\r\n">>]),
    {ok, #state{sock=Sock}}.

handle_call({join, Room}, _From, State=#state{sock=Sock}) ->
    gen_tcp:send(Sock, [<<"JOIN #">>, Room, <<"\r\n">>]),
    {reply, ok, State}.

handle_cast({msg, To, Msg}, State=#state{sock=Sock}) ->
    gen_tcp:send(Sock, [<<"PRIVMSG ">>, To, <<" :">>, Msg, <<"\r\n">>]),
    {noreply, State};
handle_cast(stop, State) ->
    {stop, normal, State}.

handle_info({tcp, _FSock, RawMsg}, State=#state{sock=Sock}) ->
    case irc_parser:parse_msg(RawMsg) of
        {_, ping, [Txt]} -> gen_tcp:send(Sock, [<<"PONG :">>, Txt, <<"\r\n">>]);
        ParsedMsg -> irc_event_manager:broadcast(ParsedMsg)
    end,
    {noreply, State}.

terminate(_, #state{sock=Sock}) ->
    gen_tcp:close(Sock),
    ok.
