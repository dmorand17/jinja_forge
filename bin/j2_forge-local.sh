#!/bin/bash
set -euo pipefail

# Script variables
SCRIPT_DIR=$(dirname -- "$(readlink -f -- "$0";)" ;)
PARENT_DIR=$(dirname "$SCRIPT_DIR")
#SCRIPT_NAME=$( basename -- "$0"; )

pushd "$PARENT_DIR" > /dev/null
# Check if virtual environment exists, and create if missing.  
# Install requirements if missing.
if [ ! -d "./.venv" ]; then
    echo "[-] Creating virtual environment..."
    python3 -m venv .venv &>/dev/null
    source "./.venv/bin/activate"    
    echo "[-] Installing requirements..."
    pip3 install -r requirements.txt &>/dev/null 
fi

source "./.venv/bin/activate"

python3 j2_forge/main.py "$@"

deactivate
popd > /dev/null
