-module(irc_core_sup).

-behaviour(supervisor).

-export([start_link/3]).

-export([init/1]).

start_link(Host, Port, Id) ->
    supervisor:start_link(?MODULE, [Host, Port, Id]).

init([Host, Port, Id]) -> 
    {ok, {{one_for_one, 5, 30000},
      [{event_manager, {irc_event_manager, start_link, []}, permanent, 3000, worker, dynamic},
      {irc_session, {irc_session, start_link, [Host, Port, Id]}, permanent, 3000, worker, [irc_session]}]}}.
      
