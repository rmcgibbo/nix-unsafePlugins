nix eval '(builtins.traceFd 3 "foo" "bar")'  --option plugin-files result/lib/nix/plugins/libtraceFd.so 3>&1
