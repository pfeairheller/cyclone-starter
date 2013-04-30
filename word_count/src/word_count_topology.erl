%% Copyright
-module(word_count_topology).
-author("pfeairheller").

-behaviour(topology).

-include("deps/cyclone/include/topology.hrl").
-include("deps/cyclone/include/spout_spec.hrl").
-include("deps/cyclone/include/bolt_spec.hrl").
-include("deps/cyclone/include/grouping.hrl").

%% API
-export([init/0]).

init() ->
  #topology{
    name = "word_count",
    spout_specs = [
      #spout_spec{
        id = "spout",
        spout = {random_sentence_spout, []},
        workers = 1
      }
    ],

    bolts_specs = [
      #bolt_spec{
        id = "split",
        bolt = {split_sentence_bolt, []},
        groupings = [
          #grouping {
            source = "spout",
            type = shuffle
          }
        ]
      },
      #bolt_spec{
        id = "count",
        bolt = {word_count_bolt, []},
        groupings = [
          #grouping{
            source = "split",
            type = field,
            args = ["word"]
          }
        ]
      }
    ]

  }.

