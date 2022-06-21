%% This Source Code Form is subject to the terms of the Mozilla Public
%% License, v. 2.0. If a copy of the MPL was not distributed with this
%% file, You can obtain one at https://mozilla.org/MPL/2.0/.
%%
%% Copyright (c) 2007-2023 VMware, Inc. or its affiliates. All rights reserved.

-module(rabbit_exchange_type_recent_history).

-include_lib("rabbit_common/include/rabbit.hrl").
-include("rabbit_recent_history.hrl").

-behaviour(rabbit_exchange_type).

-import(rabbit_misc, [table_lookup/2]).

-export([description/0, serialise_events/0, route/2]).
-export([validate/1, validate_binding/2, create/2, delete/3, add_binding/3,
         remove_bindings/3, assert_args_equivalence/2, policy_changed/2]).
-export([setup_schema/0, disable_plugin/0]).
-export([info/1, info/2]).

-rabbit_boot_step({?MODULE,
                   [{description, "exchange type x-recent-history"},
                    {mfa, {rabbit_registry, register,
                           [exchange, <<"x-recent-history">>, ?MODULE]}},
                    {cleanup, {?MODULE, disable_plugin, []}},
                    {requires, rabbit_registry},
                    {enables, kernel_ready}]}).

-rabbit_boot_step({rabbit_exchange_type_recent_history_mnesia,
                   [{description, "recent history exchange type: mnesia"},
                    {mfa, {?MODULE, setup_schema, []}},
                    {requires, database},
                    {enables, external_infrastructure}]}).

-define(INTEGER_ARG_TYPES, [byte, short, signedint, long]).

info(_X) -> [].
info(_X, _) -> [].

description() ->
    [{name, <<"x-recent-history">>},
     {description, <<"Recent History Exchange.">>}].

serialise_events() -> false.

route(#exchange{name      = XName,
                arguments = Args}, Message) ->
    Length = table_lookup(Args, <<"x-recent-history-length">>),
    maybe_cache_msg(XName, Message, Length),
    rabbit_router:match_routing_key(XName, ['_']).

validate(#exchange{arguments = Args}) ->
    case table_lookup(Args, <<"x-recent-history-length">>) of
        undefined   ->
            ok;
        {Type, Val} ->
            case check_int_arg(Type) of
                ok when Val > 0 ->
                    ok;
                _ ->
                    rabbit_misc:protocol_error(precondition_failed,
                                               "Invalid argument ~tp, "
                                               "'x-recent-history-length' "
                                               "must be a positive integer",
                                               [Val])
            end
    end.

validate_binding(_X, _B) -> ok.
create(_Tx, _X) -> ok.
policy_changed(_X1, _X2) -> ok.

delete(transaction, #exchange{ name = XName }, _Bs) ->
    rabbit_misc:execute_mnesia_transaction(
      fun() ->
              mnesia:delete(?RH_TABLE, XName, write)
      end),
    ok;
delete(none, _Exchange, _Bs) ->
    ok.

add_binding(transaction, #exchange{ name = XName },
            #binding{ destination = #resource{kind = queue} = QName }) ->
    _ = case rabbit_amqqueue:lookup(QName) of
        {error, not_found} ->
            destination_not_found_error(QName);
        {ok, Q} ->
            Msgs = get_msgs_from_cache(XName),
            deliver_messages([Q], Msgs)
    end,
    ok;
add_binding(transaction, #exchange{ name = XName },
            #binding{ destination = #resource{kind = exchange} = DestName }) ->
    _ = case rabbit_exchange:lookup(DestName) of
        {error, not_found} ->
            destination_not_found_error(DestName);
        {ok, X} ->
            Msgs = get_msgs_from_cache(XName),
            [begin
                 Qs = rabbit_exchange:route(X, Msg),
                 case rabbit_amqqueue:lookup(Qs) of
                     [] ->
                         destination_not_found_error(Qs);
                     QPids ->
                         deliver_messages(QPids, [Msg])
                 end
             end || Msg <- Msgs]
    end,
    ok;
add_binding(none, _Exchange, _Binding) ->
    ok.

remove_bindings(_Tx, _X, _Bs) -> ok.

assert_args_equivalence(X, Args) ->
    rabbit_exchange:assert_args_equivalence(X, Args).

%%----------------------------------------------------------------------------

setup_schema() ->
    _ = mnesia:create_table(?RH_TABLE,
                             [{attributes, record_info(fields, cached)},
                              {record_name, cached},
                              {type, set}]),
    _ = mnesia:add_table_copy(?RH_TABLE, node(), ram_copies),
    rabbit_table:wait([?RH_TABLE]),
    ok.

disable_plugin() ->
    rabbit_registry:unregister(exchange, <<"x-recent-history">>),
    _ = mnesia:delete_table(?RH_TABLE),
    ok.

%%----------------------------------------------------------------------------
%%private
maybe_cache_msg(XName, Message, Length) ->
    case mc:proto_header(<<"x-recent-history-no-store">>, Message) of
        true ->
            ok;
        _ ->
            cache_msg(XName, Message, Length)
    end.

cache_msg(XName, Message, Length) ->
    rabbit_misc:execute_mnesia_transaction(
      fun () ->
              Cached = get_msgs_from_cache(XName),
              store_msg(XName, Cached, Message, Length)
      end).

get_msgs_from_cache(XName) ->
    rabbit_misc:execute_mnesia_transaction(
      fun () ->
              case mnesia:read(?RH_TABLE, XName) of
                  [] ->
                      [];
                  [#cached{key = XName, content=Cached}] ->
                      Cached
              end
      end).

store_msg(Key, Cached, Message, undefined) ->
    store_msg0(Key, Cached, Message, ?KEEP_NB);
store_msg(Key, Cached, Message, {_Type, Length}) ->
    store_msg0(Key, Cached, Message, Length).

store_msg0(Key, Cached, Message, Length) ->
    mnesia:write(?RH_TABLE,
                 #cached{key     = Key,
                         content = [Message|lists:sublist(Cached, Length-1)]},
                 write).

deliver_messages(Qs, Msgs) ->
    lists:map(
      fun (Msg) ->
              _ = rabbit_queue_type:deliver(Qs, Msg, #{}, stateless)
      end, lists:reverse(Msgs)).

-spec destination_not_found_error(string()) -> no_return().
destination_not_found_error(DestName) ->
    rabbit_misc:protocol_error(
      internal_error,
      "could not find queue/exchange '~ts'",
      [DestName]).

%% adapted from rabbit_amqqueue.erl
check_int_arg(Type) ->
    case lists:member(Type, ?INTEGER_ARG_TYPES) of
        true  -> ok;
        false -> {error, {unacceptable_type, Type}}
    end.
