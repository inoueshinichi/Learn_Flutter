cmake_minimum_required(VERSION 3.7 FATAL_ERROR)
project(struct_library VERSION 1.0.0 LANGUAGES C)
add_library(struct_library SHARED struct.c struct.def)
# add_executable(struct_test struct.c)

set_target_properties(struct_library PROPERTIES
    PUBLIC_HEADER struct.h
    VERSION ${PROJECT_VERSION}
    SOVERSION 1
    OUTPUT_NAME "struct"
    XCODE_ATTRIBUTE_CODE_SIGN_IDENTITY "Hex_Identity_ID_Goes_Here"
)