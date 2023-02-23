load("@rules_erlang//:erlang_bytecode2.bzl", "erlang_bytecode")
load("@rules_erlang//:filegroup.bzl", "filegroup")

def all_beam_files(name = "all_beam_files"):
    filegroup(
        name = "beam_files",
        srcs = [":behaviours", ":other_beam"],
    )
    erlang_bytecode(
        name = "behaviours",
        srcs = [
            "src/amqp_gen_connection.erl",
            "src/amqp_gen_consumer.erl",
        ],
        outs = [
            "ebin/amqp_gen_connection.beam",
            "ebin/amqp_gen_consumer.beam",
        ],
        hdrs = [
            "include/amqp_client.hrl",
            "include/amqp_client_internal.hrl",
            "include/amqp_gen_consumer_spec.hrl",
            "include/rabbit_routing_prefixes.hrl",
        ],
        app_name = "amqp_client",
        erlc_opts = "//:erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )
    erlang_bytecode(
        name = "other_beam",
        srcs = [
            "src/amqp_auth_mechanisms.erl",
            "src/amqp_channel.erl",
            "src/amqp_channel_sup.erl",
            "src/amqp_channel_sup_sup.erl",
            "src/amqp_channels_manager.erl",
            "src/amqp_client.erl",
            "src/amqp_connection.erl",
            "src/amqp_connection_sup.erl",
            "src/amqp_connection_type_sup.erl",
            "src/amqp_direct_connection.erl",
            "src/amqp_direct_consumer.erl",
            "src/amqp_main_reader.erl",
            "src/amqp_network_connection.erl",
            "src/amqp_rpc_client.erl",
            "src/amqp_rpc_server.erl",
            "src/amqp_selective_consumer.erl",
            "src/amqp_ssl.erl",
            "src/amqp_sup.erl",
            "src/amqp_uri.erl",
            "src/amqp_util.erl",
            "src/rabbit_routing_util.erl",
            "src/uri_parser.erl",
        ],
        outs = [
            "ebin/amqp_auth_mechanisms.beam",
            "ebin/amqp_channel.beam",
            "ebin/amqp_channel_sup.beam",
            "ebin/amqp_channel_sup_sup.beam",
            "ebin/amqp_channels_manager.beam",
            "ebin/amqp_client.beam",
            "ebin/amqp_connection.beam",
            "ebin/amqp_connection_sup.beam",
            "ebin/amqp_connection_type_sup.beam",
            "ebin/amqp_direct_connection.beam",
            "ebin/amqp_direct_consumer.beam",
            "ebin/amqp_main_reader.beam",
            "ebin/amqp_network_connection.beam",
            "ebin/amqp_rpc_client.beam",
            "ebin/amqp_rpc_server.beam",
            "ebin/amqp_selective_consumer.beam",
            "ebin/amqp_ssl.beam",
            "ebin/amqp_sup.beam",
            "ebin/amqp_uri.beam",
            "ebin/amqp_util.beam",
            "ebin/rabbit_routing_util.beam",
            "ebin/uri_parser.beam",
        ],
        hdrs = [
            "include/amqp_client.hrl",
            "include/amqp_client_internal.hrl",
            "include/amqp_gen_consumer_spec.hrl",
            "include/rabbit_routing_prefixes.hrl",
        ],
        app_name = "amqp_client",
        beam = [":behaviours"],
        erlc_opts = "//:erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )

def all_test_beam_files(name = "all_test_beam_files"):
    filegroup(
        name = "test_beam_files",
        testonly = True,
        srcs = [":test_behaviours", ":test_other_beam"],
    )
    erlang_bytecode(
        name = "test_behaviours",
        testonly = True,
        srcs = ["src/amqp_gen_connection.erl", "src/amqp_gen_consumer.erl"],
        outs = ["test/amqp_gen_connection.beam", "test/amqp_gen_consumer.beam"],
        hdrs = [
            "include/amqp_client.hrl",
            "include/amqp_client_internal.hrl",
            "include/amqp_gen_consumer_spec.hrl",
            "include/rabbit_routing_prefixes.hrl",
        ],
        app_name = "amqp_client",
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )
    erlang_bytecode(
        name = "test_other_beam",
        testonly = True,
        srcs = [
            "src/amqp_auth_mechanisms.erl",
            "src/amqp_channel.erl",
            "src/amqp_channel_sup.erl",
            "src/amqp_channel_sup_sup.erl",
            "src/amqp_channels_manager.erl",
            "src/amqp_client.erl",
            "src/amqp_connection.erl",
            "src/amqp_connection_sup.erl",
            "src/amqp_connection_type_sup.erl",
            "src/amqp_direct_connection.erl",
            "src/amqp_direct_consumer.erl",
            "src/amqp_main_reader.erl",
            "src/amqp_network_connection.erl",
            "src/amqp_rpc_client.erl",
            "src/amqp_rpc_server.erl",
            "src/amqp_selective_consumer.erl",
            "src/amqp_ssl.erl",
            "src/amqp_sup.erl",
            "src/amqp_uri.erl",
            "src/amqp_util.erl",
            "src/rabbit_routing_util.erl",
            "src/uri_parser.erl",
        ],
        outs = [
            "test/amqp_auth_mechanisms.beam",
            "test/amqp_channel.beam",
            "test/amqp_channel_sup.beam",
            "test/amqp_channel_sup_sup.beam",
            "test/amqp_channels_manager.beam",
            "test/amqp_client.beam",
            "test/amqp_connection.beam",
            "test/amqp_connection_sup.beam",
            "test/amqp_connection_type_sup.beam",
            "test/amqp_direct_connection.beam",
            "test/amqp_direct_consumer.beam",
            "test/amqp_main_reader.beam",
            "test/amqp_network_connection.beam",
            "test/amqp_rpc_client.beam",
            "test/amqp_rpc_server.beam",
            "test/amqp_selective_consumer.beam",
            "test/amqp_ssl.beam",
            "test/amqp_sup.beam",
            "test/amqp_uri.beam",
            "test/amqp_util.beam",
            "test/rabbit_routing_util.beam",
            "test/uri_parser.beam",
        ],
        hdrs = [
            "include/amqp_client.hrl",
            "include/amqp_client_internal.hrl",
            "include/amqp_gen_consumer_spec.hrl",
            "include/rabbit_routing_prefixes.hrl",
        ],
        app_name = "amqp_client",
        beam = [":test_behaviours"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )

def all_srcs(name = "all_srcs"):
    filegroup(
        name = "all_srcs",
        srcs = [":public_and_private_hdrs", ":srcs"],
    )
    filegroup(
        name = "public_and_private_hdrs",
        srcs = [":private_hdrs", ":public_hdrs"],
    )
    filegroup(
        name = "licenses",
        srcs = ["LICENSE", "LICENSE-MPL-RabbitMQ"],
    )
    filegroup(
        name = "priv",
    )

    filegroup(
        name = "srcs",
        srcs = [
            "src/amqp_auth_mechanisms.erl",
            "src/amqp_channel.erl",
            "src/amqp_channel_sup.erl",
            "src/amqp_channel_sup_sup.erl",
            "src/amqp_channels_manager.erl",
            "src/amqp_client.erl",
            "src/amqp_connection.erl",
            "src/amqp_connection_sup.erl",
            "src/amqp_connection_type_sup.erl",
            "src/amqp_direct_connection.erl",
            "src/amqp_direct_consumer.erl",
            "src/amqp_gen_connection.erl",
            "src/amqp_gen_consumer.erl",
            "src/amqp_main_reader.erl",
            "src/amqp_network_connection.erl",
            "src/amqp_rpc_client.erl",
            "src/amqp_rpc_server.erl",
            "src/amqp_selective_consumer.erl",
            "src/amqp_ssl.erl",
            "src/amqp_sup.erl",
            "src/amqp_uri.erl",
            "src/amqp_util.erl",
            "src/rabbit_routing_util.erl",
            "src/uri_parser.erl",
        ],
    )
    filegroup(
        name = "public_hdrs",
        srcs = [
            "include/amqp_client.hrl",
            "include/amqp_client_internal.hrl",
            "include/amqp_gen_consumer_spec.hrl",
            "include/rabbit_routing_prefixes.hrl",
        ],
    )
    filegroup(
        name = "private_hdrs",
    )

def test_suite_beam_files(name = "test_suite_beam_files"):
    erlang_bytecode(
        name = "system_SUITE_beam_files",
        testonly = True,
        srcs = ["test/system_SUITE.erl"],
        outs = ["test/system_SUITE.beam"],
        hdrs = ["include/amqp_client.hrl", "include/amqp_client_internal.hrl"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )
    erlang_bytecode(
        name = "unit_SUITE_beam_files",
        testonly = True,
        srcs = ["test/unit_SUITE.erl"],
        outs = ["test/unit_SUITE.beam"],
        hdrs = ["include/amqp_client.hrl"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )
