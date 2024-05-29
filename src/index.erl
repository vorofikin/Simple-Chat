-module(index).

-compile(export_all).

-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

-define(ROOM_NUMBER, 3).

% event(init) ->
%   Room = n2o:session(room),
%   io:format(Room),
%   Key = {topic, Room},
%   n2o:reg(Key),
%   n2o:reg(n2o:sid()),
%   nitro:clear(history),
%   nitro:update(
%     send
%     #button{
%       id = send,
%       body = <<"Send Message">>,
%       postback = send_message,
%       source = [message]
%     }
%   ).

event(init) ->
  io:format("init"),
  ButtonElements = lists:map(
    fun(Button) ->
      io:format("~p~n", [Button]),
      #button{
        id = <<"room", integer_to_binary(Button)>>,
        body = <<"Кімната", integer_to_binary(Button)>>,
        postback = {go_to_room, Button}
      }
    end,
    lists:seq(1, ?ROOM_NUMBER)
  ),
  nitro:render(ButtonElements),
  ButtonElements;
event({go_to_room, Room}) ->
  io:format("OK~p~n", [Room]);
event(room) ->
  io:format(nitro:to_list(nitro:q(room))),
  nitro:redirect(nitro:to_list(nitro:q(room)));
event(Event) -> io:format("~p~n", [Event]), ok.
