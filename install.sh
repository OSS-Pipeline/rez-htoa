#!/usr/bin/bash

# Will exit the Bash script the moment any command will itself exit with a non-zero status, thus an error.
set -e

EXTRACT_PATH=$1
INSTALL_PATH=${REZ_BUILD_INSTALL_PATH}
HTOA_URL=$2
HTOA_VERSION=${REZ_BUILD_PROJECT_VERSION}

# We print the arguments passed to the Bash script.
echo -e "\n"
echo -e "==============="
echo -e "=== INSTALL ==="
echo -e "==============="
echo -e "\n"

echo -e "[INSTALL][ARGS] EXTRACT PATH: ${EXTRACT_PATH}"
echo -e "[INSTALL][ARGS] INSTALL PATH: ${INSTALL_PATH}"
echo -e "[INSTALL][ARGS] HTOA URL: ${HTOA_URL}"
echo -e "[INSTALL][ARGS] HTOA VERSION: ${HTOA_VERSION}"

# We check if the arguments variables we need are correctly set.
# If not, we abort the process.
if [[ -z ${EXTRACT_PATH} || -z ${INSTALL_PATH} || -z ${HTOA_URL} || -z ${HTOA_VERSION} ]]; then
    echo -e "\n"
    echo -e "[INSTALL][ARGS] One or more of the argument variables are empty. Aborting..."
    echo -e "\n"

    exit 1
fi

# We install HtoA.
echo -e "\n"
echo -e "[INSTALL] Installing HtoA-${HTOA_VERSION}..."
echo -e "\n"

mkdir -p ${EXTRACT_PATH}

# We extract the content of the .run file in a manner that it does not ask for explicit user input.
${HTOA_URL} \
    --extract-to ${EXTRACT_PATH} \
    --accept-license

# We copy the necessary files to the install directory.
cp -R ${EXTRACT_PATH}/htoa-${HTOA_VERSION}_r48c4031_houdini-${REZ_HOUDINI_VERSION}/* ${INSTALL_PATH}

echo -e "\n"
echo -e "[INSTALL] Finished installing HtoA-${HTOA_VERSION}!"
echo -e "\n"
