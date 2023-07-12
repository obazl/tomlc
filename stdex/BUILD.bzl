load("@bazel_skylib//rules:diff_test.bzl", "diff_test")
load("@bazel_skylib//lib:paths.bzl", "paths")

def toml_test(name, toml_files = []):
    native.test_suite(
        name = "test",
        ## default:runs all *_test targets in pkg
    )
    for toml in toml_files:
        (stem, ext) = paths.split_extension(paths.basename(toml))
        native.genrule(
            name       = stem,
            srcs       = [toml],
            outs       = [toml + ".out"],
            tools      = ["//:toml_cat"],
            cmd       = " ".join([
                "$(execpath //:toml_cat)",
                "$(location " + toml + ")",
                ">&", "$(location " + toml + ".out)",
            ]),
        )
        diff_test(
            name  = stem + "_test",
            file1 = toml + ".out",
            file2 = toml + ".res",
            timeout = "short"
        )

