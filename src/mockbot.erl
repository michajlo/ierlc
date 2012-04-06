-module(mockbot).

-export([init/1, handle_event/2, terminate/2]).

init([]) ->
    {ok, nil}.

handle_event({_, privmsg, ["#" ++ Room, Msg]}, State) ->
    irc:msg(["#"|Room], Msg),
    {ok, State};
handle_event({{Nick, _}, privmsg, [_, Msg]}, State) ->
    irc:msg(Nick, Msg),
    {ok, State};
handle_event(Any, State) ->
    io:format("Unhandled: ~p~n", [Any]),
    {ok, State}.

terminate(_, _) ->
    ok.
