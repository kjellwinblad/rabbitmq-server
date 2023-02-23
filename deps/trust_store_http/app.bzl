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
            "src/trust_store_http.erl",
            "src/trust_store_http_app.erl",
            "src/trust_store_http_sup.erl",
            "src/trust_store_invalid_handler.erl",
            "src/trust_store_list_handler.erl",
        ],
        outs = [
            "ebin/trust_store_http.beam",
            "ebin/trust_store_http_app.beam",
            "ebin/trust_store_http_sup.beam",
            "ebin/trust_store_invalid_handler.beam",
            "ebin/trust_store_list_handler.beam",
        ],
        app_name = "trust_store_http",
        erlc_opts = "//:erlc_opts",
        deps = ["@cowboy//:erlang_app"],
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
    )

    filegroup(
        name = "srcs",
        srcs = [
            "src/trust_store_http.erl",
            "src/trust_store_http_app.erl",
            "src/trust_store_http_sup.erl",
            "src/trust_store_invalid_handler.erl",
            "src/trust_store_list_handler.erl",
        ],
    )
    filegroup(
        name = "priv",
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
        srcs = [
            "src/trust_store_http.erl",
            "src/trust_store_http_app.erl",
            "src/trust_store_http_sup.erl",
            "src/trust_store_invalid_handler.erl",
            "src/trust_store_list_handler.erl",
        ],
        outs = [
            "test/trust_store_http.beam",
            "test/trust_store_http_app.beam",
            "test/trust_store_http_sup.beam",
            "test/trust_store_invalid_handler.beam",
            "test/trust_store_list_handler.beam",
        ],
        app_name = "trust_store_http",
        erlc_opts = "//:test_erlc_opts",
        deps = ["@cowboy//:erlang_app"],
    )

def test_suite_beam_files(name = "test_suite_beam_files"):
    pass
