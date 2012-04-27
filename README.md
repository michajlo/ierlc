# ierlc

bumbot, meet otp, otp, meet bumbot


## Getting started

The general idea is you start the the application using `application:start(ierlc)`, or `ierlc:start()`, and it connects to the configured IRC server with the configured nickname.  Everything deemed actionable is sent to to the `irc_event_manager` `gen_event` handler.

For now, the only thing implemented is mockbot.

Build by running

    ./rebar compile

Get ebin onto your path somehow and fire the bot up to play with it:

    application:start(ierlc).
    irc_event_manager:add_handler(mockbot, nil).

Join rooms using `ierlc:join(Room)`, where `Room` is the room name, without precedin #. Send messages usin `ierlc:msg(To, Msg)`, if `To` is a room it will have to be preceded by #.

See `ierlc.app.src` for the relevant properties to set for connections/etc, or edit the file directly if you're lazy.

## License

Apache 2.0
