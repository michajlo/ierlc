{application, ierlc, 
    [{description, "IRC Bot Monster"},
     {vsn, git},
     {modules, [
            irc_session,
            irc_event_manager,
            irc_parser,
            irc_core_sup
        ]},
     {registered, [
            irc_session,
            irc_event_manager,
            irc_core_sup
        ]},
     {applications, [
            kernel,
            stdlib,
            sasl
        ]},
     {mod, {ierlc, []}},
     {env, [
            {host, "localhost"},
            {port, 6667},
            {id, "test"}
        ]}
    ]
}.