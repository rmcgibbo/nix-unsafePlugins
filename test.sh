#!/usr/bin/env bash
set -euo pipefail

args="--option plugin-files result/lib/nix/plugins/libunsafePlugins.so"
nix eval $args '(builtins.unsafeTraceFd 3 "foo" "bar")' 3>&1

nix eval  $args '(builtins.unsafeSuperTryEval (1+"a"))'