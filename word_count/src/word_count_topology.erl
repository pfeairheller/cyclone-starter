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
        workers = 5
      }
    ],

    bolts_specs = [
      #bolt_spec{
        id = "split",
        bolt = {split_sentence_bolt, []},
        workers = 8
      },
      #bolt_spec{
        id = "count",
        bolt = {word_count_bolt, []},
        workers = 12
      }
    ],

    groupings = [
      #grouping{
        source = "spout",
        dest = "split",
        type = shuffle
      },
      #grouping{
        source = "split",
        dest = "count",
        type = field,
        args = ["word"]
      }
    ]


  }.

