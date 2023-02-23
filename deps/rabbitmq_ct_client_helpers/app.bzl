load("@rules_erlang//:erlang_bytecode2.bzl", "erlang_bytecode")
load("@rules_erlang//:filegroup.bzl", "filegroup")

def all_beam_files(name = "all_beam_files"):
    filegroup(
        name = "beam_files",
        srcs = [":other_beam"],
    )
    erlang_bytecode(
        name = "other_beam",
        srcs = ["src/rabbit_ct_client_helpers.erl"],
        outs = ["ebin/rabbit_ct_client_helpers.beam"],
        app_name = "rabbitmq_ct_client_helpers",
        erlc_opts = "//:erlc_opts",
        deps = ["//deps/amqp_client:erlang_app"],
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
        srcs = ["src/rabbit_ct_client_helpers.erl"],
    )
    filegroup(
        name = "private_hdrs",
    )
    filegroup(
        name = "public_hdrs",
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
        srcs = ["src/rabbit_ct_client_helpers.erl"],
        outs = ["test/rabbit_ct_client_helpers.beam"],
        app_name = "rabbitmq_ct_client_helpers",
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/amqp_client:erlang_app"],
    )

def test_suite_beam_files(name = "test_suite_beam_files"):
    pass
