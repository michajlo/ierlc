-module(ierlc_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_Type, _Args) ->
    {ok, Host} = application:get_env(host),
    {ok, Port} = application:get_env(port),
    {ok, Id} = application:get_env(id),
    ierlc_app_sup:start_link(Host, Port, Id).

stop(_State) -> ok.
