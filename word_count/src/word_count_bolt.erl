%% Copyright
-module(word_count_bolt).
-author("pfeairheller@gmail.com").

-behaviour(bolt).

%% API
-export([prepare/1, execute/3, cleanup/3, declare_output_fields/1]).


prepare(_Args) ->
  TabId = ets:new(word_counts, []),
  {ok, TabId}.

execute(Output, Tuple, TabId) ->
  Word = element(1, Tuple),
  NewCount = case ets:lookup(TabId, Word) of
    [{Word, Count}] ->
      ets:insert(TabId, {Word, Count+1}),
      Count+1;
    [] ->
      ets:insert(TabId, {Word, 1}),
      1
  end,
  bolt:emit(Output, {Word, NewCount}),
  {ok, TabId}.

cleanup(_A, _B, _C) ->
  ok.

declare_output_fields(_Args) ->
  {ok, ["word", "count"]}.

