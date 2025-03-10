load("@obazl_tools_cc//config:BASE.bzl",
     _BASE_COPTS = "BASE_COPTS",
     "DSO_EXT", "DYNLINK_OPTS", "STRDUP_DEFINE")

BASE_COPTS         = _BASE_COPTS
BASE_LINKOPTS      = DYNLINK_OPTS
BASE_DEFINES       = DSO_EXT + STRDUP_DEFINE

BASE_SRCS          = []
BASE_DEPS          = []
BASE_INCLUDE_PATHS = []

