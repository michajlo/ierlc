-module(ierlc).

-export([start/2]).

start(_Type, _Args) ->
    {ok, Host} = application:get_env(host),
    {ok, Port} = application:get_env(port),
    {ok, Id} = application:get_env(id),
    application:start(sasl),
    irc_core_sup:start_link(Host, Port, Id).
