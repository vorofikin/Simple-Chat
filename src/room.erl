-module(room).

-compile(export_all).

-include_lib("nitro/include/nitro.hrl").
-include_lib("n2o/include/n2o.hrl").

event(init) ->
  Room = n2o:session(room),
  Key = {room, Room},
  n2o:reg(Key),
  nitro:update(send, #button{
    id = send,
    body = <<"Send Message"/utf8>>,
    postback = send_message,
    source = [message]
  });
event(send_message) ->
  Message = nitro:q(message),
  case Message of
    <<>> -> ok;
    _ ->
      Room = n2o:session(room),
      n2o:send({room, Room}, #client{data = Message})
  end;
event(#client{data = Message}) ->
  nitro:wire(#jq{
    target = message,
    method = [focus, select]
  }),
  nitro:insert_bottom(
    message_list,
    nitro:render(#panel{
      body = [
        #message{
          body = Message
        },
        #br{}
      ]
    }));
event(_Event) -> ok.