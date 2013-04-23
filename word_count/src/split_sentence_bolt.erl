%% Copyright
-module(split_sentence_bolt).
-author("pfeairheller@gmail.com").

-behaviour(bolt).

%% API
-export([prepare/1, execute/3, cleanup/3, declare_output_fields/1]).


prepare(_Args) ->
  {ok, undefined}.

execute(Output, Tuple, State) ->
  [bolt:emit(Output, {Word}) || Word <- string:tokens(element(1, Tuple), " ")],
  {ok, State}.

cleanup(_A, _B, _C) ->
  ok.

declare_output_fields(_Args) ->
  {ok, ["words"]}.
