#!/bin/bash
set -e

# command if an error for /bin/bash^M: bad interpreter is raised
# sed -i -e 's/\r$//' clean_python_files.sh

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
pushd "$DIR/.." > /dev/null
find . -name '*.egg-info' -exec rm -rf {} +
find . -name '*.pyc' -exec rm -f {} +
find . -name '*.pyo' -exec rm -f {} +
find . -name '__pycache__' -exec rm -rf {} +
find . -type d -empty -delete
popd
