ierlc
=====

bumbot, meet otp, otp, meet bumbot


Getting started
===============

The general idea is you start the irc_session gen_server to connect to a server and handle communication.  Everything deemed actionable is send to to the irc_event_manager gen_event handler.

For now, the only thing implemented is mockbot.  To get going, cd to src, open an erlang shell, and do the following:

> make:all([load]).
> irc_event_manager:start_link().
> irc_event_manager:add_handler(mockbot, nil).
> irc_session:start("host", port, "nick").

One day I'll wrap this all up into a supervisor heirarchy and application...


License
=======

Apache 2.0
