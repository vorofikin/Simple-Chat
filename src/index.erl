%%%-------------------------------------------------------------------
%%% @author vorofikin
%%% @copyright (C) 2024, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 29. May 2024 1:18 AM
%%%-------------------------------------------------------------------
-module(index).
-compile(export_all).
-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

event(init) ->
  Room = n2o:session(room),
  io:format(Room),
  Key = {topic, Room},
  n2o:reg(Key),
  n2o:reg(n2o:sid()),
  nitro:clear(history),
  nitro:update(
    send
    #button{
      id = send,
      body = <<"Send Message">>,
      postback = send_message,
      source = [message]
    }
  ).

event(_Event) -> ok.
%% API
%%-export([]).
