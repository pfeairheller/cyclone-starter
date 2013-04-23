%% Copyright
-module(random_sentence_spout).
-author("pfeairheller").

-behaviour(spout).

%% API
-export([open/1, next_tuple/2, declare_output_fields/1]).


open(_Args) ->
  {ok, {"the cow jumped over the moon",
    "an apple a day keeps the doctor away",
    "four score and seven years ago",
    "snow white and the seven dwarfs",
    "i am at two with nature"}}.

next_tuple(Output, Sentences) ->
  timer:sleep(1000),
  Idx = random:uniform(5) - 1,
  spout:emit(Output, {element(Idx, Sentences)}),
  {ok, Sentences}.

declare_output_fields(_Args) ->
  {ok, ["words"]}.
