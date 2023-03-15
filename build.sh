#!/usr/bin/env bash
set -o errexit -o nounset -o pipefail

# set current working directory to script directory to run script from everywhere
cd "$(dirname "$0")"

# This script builds all subprojects and puts all created Wasm modules in one dir
cargo update --aggressive
marine build --release

mkdir -p artifacts
rm -f artifacts/*.wasm
cp target/wasm32-wasi/release/ipfs_dag.wasm artifacts/
marine aqua artifacts/ipfs_dag.wasm -s ipfs_dag -i ipfs_dag > ./aqua/ipfs_dag.aqua

cp -f artifacts/*.wasm builtins/

RUST_LOG="info" mrepl --quiet Config.toml