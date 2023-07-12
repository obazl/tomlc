BASE_SRCS = []

BASE_COPTS = [
    "-x", "c",
    "-Wall",
    "-Wextra",
    # GCC:
    "-Werror", # turn all warnings into errors
    "-Werror=pedantic", # not needed with -Werror?
    "-Wpedantic", # same as -pedantic, strict ISO C and ISO C++ warnings
    "-pedantic-errors",
    "-Wfatal-errors", # stop on first error
] + select({
    "@platforms//os:macos": [
        "-std=c11",
        # "-Wno-gnu-statement-expression"
        # "-Werror=pedantic",
        # "-Wno-gnu",
        # "-Wno-format-pedantic",
    ],
    "@platforms//os:linux": [
        "-std=gnu11",
        "-fPIC",
        # "-Wl,--no-undefined",
    ],
    "//conditions:default": ["-std=c11"],
})

BASE_DEPS = [ ## only vendored
    # "//vendored/CException",
    # "//vendored/logc"
]

BASE_INCLUDE_PATHS = [
    "-Iconfig", "-Iexternal/libtoml_cc/config",
    # "-Ivendored/CException", "-Iexternal/libtoml/vendored/CException",
    # "-Ivendored/logc", "-Iexternal/libtoml/vendored/logc",
]

BASE_LINKOPTS = select({
    "@platforms//os:linux": ["-rdynamic"],
    "//conditions:default": []
})

BASE_DEFINES = select({
    "@platforms//os:macos": ["DSO_EXT=\\\".dylib\\\""],
    "@platforms//os:linux": [
        "DSO_EXT=\\\".so\\\"",
        # "_XOPEN_SOURCE=500", # strdup
        "_POSIX_C_SOURCE=200809L", # strdup, strndup since glibc 2.10
        # "_DEFAULT_SOURCE"    # dirent DT_* macros
    ],
    "//conditions:default":   ["DSO_EXT=\\\".so\\\""]
})


