load("@rules_erlang//:erlang_bytecode2.bzl", "erlang_bytecode")
load("@rules_erlang//:filegroup.bzl", "filegroup")

def all_beam_files(name = "all_beam_files"):
    filegroup(
        name = "beam_files",
        srcs = [":other_beam"],
    )
    erlang_bytecode(
        name = "other_beam",
        srcs = [
            "src/rabbit_peer_discovery_cleanup.erl",
            "src/rabbit_peer_discovery_common_app.erl",
            "src/rabbit_peer_discovery_common_sup.erl",
            "src/rabbit_peer_discovery_config.erl",
            "src/rabbit_peer_discovery_httpc.erl",
            "src/rabbit_peer_discovery_util.erl",
        ],
        outs = [
            "ebin/rabbit_peer_discovery_cleanup.beam",
            "ebin/rabbit_peer_discovery_common_app.beam",
            "ebin/rabbit_peer_discovery_common_sup.beam",
            "ebin/rabbit_peer_discovery_config.beam",
            "ebin/rabbit_peer_discovery_httpc.beam",
            "ebin/rabbit_peer_discovery_util.beam",
        ],
        hdrs = ["include/rabbit_peer_discovery.hrl"],
        app_name = "rabbitmq_peer_discovery_common",
        erlc_opts = "//:erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )

def all_test_beam_files(name = "all_test_beam_files"):
    filegroup(
        name = "test_beam_files",
        testonly = True,
        srcs = [":test_other_beam"],
    )
    erlang_bytecode(
        name = "test_other_beam",
        testonly = True,
        srcs = [
            "src/rabbit_peer_discovery_cleanup.erl",
            "src/rabbit_peer_discovery_common_app.erl",
            "src/rabbit_peer_discovery_common_sup.erl",
            "src/rabbit_peer_discovery_config.erl",
            "src/rabbit_peer_discovery_httpc.erl",
            "src/rabbit_peer_discovery_util.erl",
        ],
        outs = [
            "test/rabbit_peer_discovery_cleanup.beam",
            "test/rabbit_peer_discovery_common_app.beam",
            "test/rabbit_peer_discovery_common_sup.beam",
            "test/rabbit_peer_discovery_config.beam",
            "test/rabbit_peer_discovery_httpc.beam",
            "test/rabbit_peer_discovery_util.beam",
        ],
        hdrs = ["include/rabbit_peer_discovery.hrl"],
        app_name = "rabbitmq_peer_discovery_common",
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
        srcs = ["priv/schema/rabbitmq_peer_discovery_common.schema"],
    )
    filegroup(
        name = "private_hdrs",
    )
    filegroup(
        name = "srcs",
        srcs = [
            "src/rabbit_peer_discovery_cleanup.erl",
            "src/rabbit_peer_discovery_common_app.erl",
            "src/rabbit_peer_discovery_common_sup.erl",
            "src/rabbit_peer_discovery_config.erl",
            "src/rabbit_peer_discovery_httpc.erl",
            "src/rabbit_peer_discovery_util.erl",
        ],
    )
    filegroup(
        name = "public_hdrs",
        srcs = ["include/rabbit_peer_discovery.hrl"],
    )

def test_suite_beam_files(name = "test_suite_beam_files"):
    erlang_bytecode(
        name = "config_schema_SUITE_beam_files",
        testonly = True,
        srcs = ["test/config_schema_SUITE.erl"],
        outs = ["test/config_schema_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
