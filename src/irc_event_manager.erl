-module(irc_event_manager).

-export([start/0, start_link/0]).
-export([add_handler/2, delete_handler/2, broadcast/1]).

start() -> gen_event:start({local, ?MODULE}).

start_link() -> gen_event:start_link({local, ?MODULE}).

add_handler(Handler, Args) -> gen_event:add_handler(?MODULE, Handler, Args).

delete_handler(Handler, Args) -> gen_event:delete_handler(?MODULE, Handler, Args).

broadcast(Msg) -> gen_event:notify(?MODULE, Msg).
