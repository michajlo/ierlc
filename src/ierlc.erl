-module(ierlc).

-export([start/0, stop/0, join/1, msg/2]).

start() -> application:start(ierlc).

stop() -> application:stop(ierlc).

join(Room) -> irc_session:join(Room).

msg(To, Msg) -> irc_session:msg(To, Msg).
