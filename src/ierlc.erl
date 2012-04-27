-module(ierlc).

-export([start/0, stop/0]).

-export([join/1, msg/2]).

-export([add_handler/2, delete_handler/2]).

start() -> application:start(ierlc).

stop() -> application:stop(ierlc).

join(Room) -> irc_session:join(Room).

msg(To, Msg) -> irc_session:msg(To, Msg).

add_handler(Handler, Args) -> irc_event_manager:add_handler(Handler, Args).

delete_handler(Handler, Args) -> irc_event_manager:delete_handler(Handler, Args).

