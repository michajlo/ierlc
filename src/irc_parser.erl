-module(irc_parser).

-include_lib("eunit/include/eunit.hrl").

-export([parse_msg/1]).

%% @doc Take message (with new line) and parse into something more manageable
parse_msg(RawMsg) ->
    [Msg|_] = re:replace(RawMsg, "\r\n", ""),
    {From, RestMsg} = parse_from(binary_to_list(Msg)),
    {Cmd, ParamsStr} = parse_word(RestMsg),
    {From, parse_cmd(Cmd), parse_params(ParamsStr)}.

%% @private
parse_cmd(Cmd) ->
    case Cmd of
        "PING" -> ping;
        "PRIVMSG" -> privmsg;
        "JOIN" -> join;
        "PART" -> part;
        "QUIT" -> quit;
        Other -> {unhandled, Other}
    end.

%% @private
parse_params(ParamsStr) -> parse_params(ParamsStr, []).

%% @private
parse_params(":" ++ Rest, A) -> lists:reverse([Rest|A]);
parse_params("", A) -> lists:reverse(A);
parse_params(" " ++ Rest, []) -> parse_params(Rest, []);
parse_params(ParamsStr, A) -> 
    {Param, Rest} = parse_word(ParamsStr),
    parse_params(Rest, [Param|A]).


%% @private
parse_from(":" ++ Cmd) ->
    {From, Rest} = parse_word(Cmd),
    Nick = parse_nick(From),
    {{Nick, From}, Rest};
parse_from(Cmd) -> {nil, Cmd}.

parse_nick(User) -> 
    [Nick|_] = string:tokens(User, "!"),
    Nick.

%% @private
parse_word(S) -> parse_word(S, []).

%% @private
parse_word(" "++R, []) -> parse_word(R, []);
parse_word(" "++R, A) -> {lists:reverse(A), R};
parse_word("", A) -> {lists:reverse(A), []};
parse_word([C|R], A) -> parse_word(R, [C|A]).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                  TESTS
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

parse_msg_test_() ->
    [
     ?_assert(parse_msg(":from PING :stuff\r\n") =:= {{"from", "from"}, ping, ["stuff"]}),
     ?_assert(parse_msg("PING :stuff\r\n") =:= {nil, ping, ["stuff"]}),
     ?_assert(parse_msg(":from PRIVMSG :stuff\r\n") =:= {{"from", "from"}, privmsg, ["stuff"]}),
     ?_assert(parse_msg("PRIVMSG :stuff\r\n") =:= {nil, privmsg, ["stuff"]})
    ].

parse_params_test_() ->
    [
     ?_assert(parse_params("param1 param2") =:= ["param1", "param2"]),
     ?_assert(parse_params("param1  param2") =:= ["param1", "param2"]),
     ?_assert(parse_params("param1 param2 :param number  three") =:= ["param1", "param2", "param number  three"])
    ].

parse_from_test_() ->
    [
     ?_assert(parse_from(":from asdf 1234") =:= {{"from", "from"}, "asdf 1234"}),
     ?_assert(parse_from(":from!somewhere asdf 1234") =:= {{"from", "from!somewhere"}, "asdf 1234"}),
     ?_assert(parse_from("asdf 1234") =:= {nil, "asdf 1234"})
    ].

parse_word_test_() ->
    [
     ?_assert(parse_word("") =:= {[], []}),
     ?_assert(parse_word(" ") =:= {[], []}),
     ?_assert(parse_word("  ") =:= {[], []}),
     ?_assert(parse_word("hello") =:= {"hello", []}),
     ?_assert(parse_word(" hello") =:= {"hello", []}),
     ?_assert(parse_word("hello world") =:= {"hello", "world"}),
     ?_assert(parse_word(" hello world") =:= {"hello", "world"})
    ].

