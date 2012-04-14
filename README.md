# ierlc

bumbot, meet otp, otp, meet bumbot


## Getting started

The general idea is you start the `irc_session` `gen_server` to connect to a server and handle communication.  Everything deemed actionable is send to to the `irc_event_manager` `gen_event` handler.

For now, the only thing implemented is mockbot.

Build by running

    ./rebar compile

Get ebin onto your path somehow and fire the bot up to play with it:

    application:start(ierlc).
    irc_event_manager:add_handler(mockbot, nil).

You can interact with `irc_session` directly to send messages and join room.  `irc_session:join` and `irc_session:msg` are really the only interesting things right now.

See `ierlc.app.src` for the relevant properties to set for connections/etc, or edit the file directly if you're lazy.

## License

Apache 2.0
