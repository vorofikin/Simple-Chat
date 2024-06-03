-module(index).

-compile(export_all).

-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

-define(ROOM_NUMBER, 3).

event(init) ->
  ButtonElements = lists:map(
    fun(Button) ->
      BinaryButtonNum = integer_to_binary(Button),
      #button{
        id = <<"room", BinaryButtonNum/binary>>,
        body = <<"Кімната "/utf8, BinaryButtonNum/binary>>,
        postback = {go_to_room, Button}
      }
    end,
    lists:seq(1, ?ROOM_NUMBER)
  ),
  nitro:insert_bottom(heading, #panel{
    id = <<"buttons"/utf8>>,
    body = ButtonElements
  });
event({go_to_room, Room}) ->
  RoomBinary = integer_to_binary(Room),
  n2o:session(room, Room),
  nitro:redirect(<<"/app/room.htm?room="/utf8, RoomBinary/binary>>),
  ok;
event(Event) -> ok.
