CMAKE_MINIMUM_REQUIRED(VERSION 3.0)

include(RezBuild)
include(RezRepository)
include(ExternalProject)

# HtoA
rez_set_archive(
    HTOA_URL htoa/htoa-${REZ_BUILD_PROJECT_VERSION}_r48c4031_houdini-$ENV{REZ_HOUDINI_VERSION}_linux.run
    https://www.arnoldrenderer.com/arnold/download/product-download/?id=2964
)

# The environment variable REZ_TMP_PATH is meant to point to a location such as "/tmp/rez".
set(EXTRACT_DIR $ENV{REZ_TMP_PATH}/htoa/${REZ_BUILD_PROJECT_VERSION})

# We will only use a Bash script to deal with the installation as it is provided as a .run file,
# which does not play well with the ExternalProject_Add CMake macro.
execute_process(
    COMMAND
    bash ${CMAKE_SOURCE_DIR}/install.sh ${EXTRACT_DIR} ${HTOA_URL}
    RESULT_VARIABLE RETURN_CODE
)

# We check that the execute_process() macro terminated properly.
# If not, we abort the process.
if(RETURN_CODE EQUAL "1")
    message(FATAL_ERROR "[CMAKE] Install script returned an error code. Aborting...")
endif()

# We use a bogus CMake "install" step in order to be able to properly finish
# and get out of the CMake script.
install(
    CODE
    "execute_process(
        COMMAND echo \"\n[CMAKE] HtoA-${REZ_BUILD_PROJECT_VERSION} PACKAGE SETUP FINISHED!\n\"
    )"
)
