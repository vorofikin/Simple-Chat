-module(routes).

-include_lib("n2o/include/n2o.hrl").

-export([init/2, finish/2]).

finish(State, Context) -> {ok, State, Context}.

init(State, #cx{req = Req} = Cx) ->
  #{path := Path} = Req,
  {ok, State, Cx#cx{path = Path, module = route_prefix(Path)}}.

route_prefix(<<"/ws/", P/binary>>) -> route(P);
route_prefix(<<"/", P/binary>>) -> route(P);
route_prefix(P) -> route(P).

route(<<>>) -> index;
route(<<"index", _/binary>>) -> index;
route(<<"room", _/binary>>) -> room;
route(<<"app/index", _/binary>>) -> index;
route(<<"app/room", _/binary>>) -> room;
route(_) -> index.
