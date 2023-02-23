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
            "src/amqp10_binary_generator.erl",
            "src/amqp10_binary_parser.erl",
            "src/amqp10_framing.erl",
            "src/amqp10_framing0.erl",
        ],
        outs = [
            "ebin/amqp10_binary_generator.beam",
            "ebin/amqp10_binary_parser.beam",
            "ebin/amqp10_framing.beam",
            "ebin/amqp10_framing0.beam",
        ],
        hdrs = ["include/amqp10_framing.hrl"],
        app_name = "amqp10_common",
        erlc_opts = "//:erlc_opts",
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
            "src/amqp10_binary_generator.erl",
            "src/amqp10_binary_parser.erl",
            "src/amqp10_framing.erl",
            "src/amqp10_framing0.erl",
        ],
        outs = [
            "test/amqp10_binary_generator.beam",
            "test/amqp10_binary_parser.beam",
            "test/amqp10_framing.beam",
            "test/amqp10_framing0.beam",
        ],
        hdrs = ["include/amqp10_framing.hrl"],
        app_name = "amqp10_common",
        erlc_opts = "//:test_erlc_opts",
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
            "src/amqp10_binary_generator.erl",
            "src/amqp10_binary_parser.erl",
            "src/amqp10_framing.erl",
            "src/amqp10_framing0.erl",
        ],
    )
    filegroup(
        name = "public_hdrs",
        srcs = ["include/amqp10_framing.hrl"],
    )
    filegroup(
        name = "private_hdrs",
    )

def test_suite_beam_files(name = "test_suite_beam_files"):
    erlang_bytecode(
        name = "binary_generator_SUITE_beam_files",
        testonly = True,
        srcs = ["test/binary_generator_SUITE.erl"],
        outs = ["test/binary_generator_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
    erlang_bytecode(
        name = "binary_parser_SUITE_beam_files",
        testonly = True,
        srcs = ["test/binary_parser_SUITE.erl"],
        outs = ["test/binary_parser_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
