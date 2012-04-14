# ierlc

bumbot, meet otp, otp, meet bumbot


## Getting started

The general idea is you start the `irc_session` `gen_server` to connect to a server and handle communication.  Everything deemed actionable is send to to the `irc_event_manager` `gen_event` handler.

For now, the only thing implemented is mockbot.  To get going, cd to src, open an erlang shell, and do the following:

    make:all([load]).
    application:start(ierlc).
    irc_event_manager:add_handler(mockbot, nil).

For now you'll need to edit `ierlc.app` to provide connection details.


## License

Apache 2.0
