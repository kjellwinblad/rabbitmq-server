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
            "src/cth_log_redirect_any_domains.erl",
            "src/rabbit_control_helper.erl",
            "src/rabbit_ct_broker_helpers.erl",
            "src/rabbit_ct_config_schema.erl",
            "src/rabbit_ct_helpers.erl",
            "src/rabbit_ct_proper_helpers.erl",
            "src/rabbit_ct_vm_helpers.erl",
            "src/rabbit_mgmt_test_util.erl",
        ],
        outs = [
            "ebin/cth_log_redirect_any_domains.beam",
            "ebin/rabbit_control_helper.beam",
            "ebin/rabbit_ct_broker_helpers.beam",
            "ebin/rabbit_ct_config_schema.beam",
            "ebin/rabbit_ct_helpers.beam",
            "ebin/rabbit_ct_proper_helpers.beam",
            "ebin/rabbit_ct_vm_helpers.beam",
            "ebin/rabbit_mgmt_test_util.beam",
        ],
        hdrs = [
            "include/rabbit_assert.hrl",
            "include/rabbit_mgmt_test.hrl",
        ],
        app_name = "rabbitmq_ct_helpers",
        erlc_opts = "//:erlc_opts",
        deps = [
            "//deps/rabbit_common:erlang_app",
            "@proper//:erlang_app",
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
        srcs = [
            "src/cth_log_redirect_any_domains.erl",
            "src/rabbit_control_helper.erl",
            "src/rabbit_ct_broker_helpers.erl",
            "src/rabbit_ct_config_schema.erl",
            "src/rabbit_ct_helpers.erl",
            "src/rabbit_ct_proper_helpers.erl",
            "src/rabbit_ct_vm_helpers.erl",
            "src/rabbit_mgmt_test_util.erl",
        ],
        outs = [
            "test/cth_log_redirect_any_domains.beam",
            "test/rabbit_control_helper.beam",
            "test/rabbit_ct_broker_helpers.beam",
            "test/rabbit_ct_config_schema.beam",
            "test/rabbit_ct_helpers.beam",
            "test/rabbit_ct_proper_helpers.beam",
            "test/rabbit_ct_vm_helpers.beam",
            "test/rabbit_mgmt_test_util.beam",
        ],
        hdrs = [
            "include/rabbit_assert.hrl",
            "include/rabbit_mgmt_test.hrl",
        ],
        app_name = "rabbitmq_ct_helpers",
        erlc_opts = "//:test_erlc_opts",
        deps = [
            "//deps/rabbit_common:erlang_app",
            "@proper//:erlang_app",
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
        name = "licenses",
        srcs = ["LICENSE", "LICENSE-APACHE2", "LICENSE-MPL-RabbitMQ"],
    )
    filegroup(
        name = "priv",
    )
    filegroup(
        name = "srcs",
        srcs = [
            "src/cth_log_redirect_any_domains.erl",
            "src/rabbit_control_helper.erl",
            "src/rabbit_ct_broker_helpers.erl",
            "src/rabbit_ct_config_schema.erl",
            "src/rabbit_ct_helpers.erl",
            "src/rabbit_ct_proper_helpers.erl",
            "src/rabbit_ct_vm_helpers.erl",
            "src/rabbit_mgmt_test_util.erl",
        ],
    )
    filegroup(
        name = "public_hdrs",
        srcs = ["include/rabbit_assert.hrl", "include/rabbit_mgmt_test.hrl"],
    )
    filegroup(
        name = "private_hdrs",
    )

def test_suite_beam_files(name = "test_suite_beam_files"):
    erlang_bytecode(
        name = "terraform_SUITE_beam_files",
        testonly = True,
        srcs = ["test/terraform_SUITE.erl"],
        outs = ["test/terraform_SUITE.beam"],
        erlc_opts = "//:test_erlc_opts",
    )
