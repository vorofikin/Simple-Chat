-module('infotech-test-task_app').

-behaviour(application).

-compile(export_all).

start(_StartType, _StartArgs) ->
    cowboy:start_clear(http,
        [{port, application:get_env(n2o, port, 8080)}],
        #{env => #{
            dispatch => n2o_cowboy:points()
        }}),
    'infotech-test-task_sup':start_link().

stop(_) -> ok.

%%    main(A) -> mad:main(A).
%%
%%
%%start(_) -> start(normal, []).
%%
%%start(_, _) ->
%%    cowboy:start_clear(
%%        http,
%%        [{port, application:get_env(n2o, port, 8080)}],
%%        #{env => #{
%%            dispatch => n2o_cowboy:points()
%%        }}),
%%    supervisor:start_link({local, 'infotech-test-task'}, 'infotech-test-task', []).
