-module(ierlc).

-export([start/0]).

-export([start/2]).

start() ->
    application:start(ierlc).

start(_Type, _Args) ->
    {ok, Host} = application:get_env(host),
    {ok, Port} = application:get_env(port),
    {ok, Id} = application:get_env(id),
    irc_core_sup:start_link(Host, Port, Id).
