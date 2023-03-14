load("@rules_erlang//:erlang_bytecode2.bzl", "erlang_bytecode")
load("@rules_erlang//:filegroup.bzl", "filegroup")

def all_beam_files(name = "all_beam_files"):
    filegroup(
        name = "beam_files",
        srcs = [":other_beam"],
    )
    erlang_bytecode(
        name = "other_beam",
        srcs = native.glob(["src/**/*.erl"]),
        hdrs = [":public_and_private_hdrs"],
        app_name = "rabbitmq_auth_backend_oauth2",
        dest = "ebin",
        erlc_opts = "//:erlc_opts",
        deps = [
            "//deps/rabbit_common:erlang_app",
            "//deps/rabbitmq_cli:erlang_app",
            "@jose//:erlang_app",
        ],
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
        srcs = native.glob(["src/**/*.erl"]),
        hdrs = [":public_and_private_hdrs"],
        app_name = "rabbitmq_auth_backend_oauth2",
        dest = "test",
        erlc_opts = "//:test_erlc_opts",
        deps = [
            "//deps/rabbit_common:erlang_app",
            "//deps/rabbitmq_cli:erlang_app",
            "@jose//:erlang_app",
        ],
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
        name = "priv",
        srcs = native.glob(["priv/**/*"]),
    )
    filegroup(
        name = "public_hdrs",
        srcs = native.glob(["include/**/*.hrl"]),
    )

    filegroup(
        name = "srcs",
        srcs = native.glob([
            "src/**/*.app.src",
            "src/**/*.erl",
        ]),
    )
    filegroup(
        name = "private_hdrs",
        srcs = native.glob(["src/**/*.hrl"]),
    )
    filegroup(
        name = "license_files",
        srcs = native.glob(["LICENSE*"]),
    )

def test_suite_beam_files(name = "test_suite_beam_files"):
    erlang_bytecode(
        name = "add_uaa_key_command_SUITE_beam_files",
        testonly = True,
        srcs = ["test/add_uaa_key_command_SUITE.erl"],
        outs = ["test/add_uaa_key_command_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )
    erlang_bytecode(
        name = "config_schema_SUITE_beam_files",
        testonly = True,
        srcs = ["test/config_schema_SUITE.erl"],
        outs = ["test/config_schema_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
    erlang_bytecode(
        name = "jwks_SUITE_beam_files",
        testonly = True,
        srcs = ["test/jwks_SUITE.erl"],
        outs = ["test/jwks_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/amqp_client:erlang_app"],
    )
    erlang_bytecode(
        name = "scope_SUITE_beam_files",
        testonly = True,
        srcs = ["test/scope_SUITE.erl"],
        outs = ["test/scope_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )
    erlang_bytecode(
        name = "system_SUITE_beam_files",
        testonly = True,
        srcs = ["test/system_SUITE.erl"],
        outs = ["test/system_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/amqp_client:erlang_app"],
    )
    erlang_bytecode(
        name = "test_jwks_http_app_beam",
        testonly = True,
        srcs = ["test/jwks_http_app.erl"],
        outs = ["test/jwks_http_app.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
    erlang_bytecode(
        name = "test_jwks_http_handler_beam",
        testonly = True,
        srcs = ["test/jwks_http_handler.erl"],
        outs = ["test/jwks_http_handler.beam"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["@cowboy//:erlang_app"],
    )
    erlang_bytecode(
        name = "test_jwks_http_sup_beam",
        testonly = True,
        srcs = ["test/jwks_http_sup.erl"],
        outs = ["test/jwks_http_sup.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
    erlang_bytecode(
        name = "test_rabbit_auth_backend_oauth2_test_util_beam",
        testonly = True,
        srcs = ["test/rabbit_auth_backend_oauth2_test_util.erl"],
        outs = ["test/rabbit_auth_backend_oauth2_test_util.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
    erlang_bytecode(
        name = "unit_SUITE_beam_files",
        testonly = True,
        srcs = ["test/unit_SUITE.erl"],
        outs = ["test/unit_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
        deps = ["//deps/rabbit_common:erlang_app"],
    )
    erlang_bytecode(
        name = "wildcard_match_SUITE_beam_files",
        testonly = True,
        srcs = ["test/wildcard_match_SUITE.erl"],
        outs = ["test/wildcard_match_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
