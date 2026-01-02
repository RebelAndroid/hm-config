{combinators}:
with combinators; [
  (add-runtime (builtins.readFile ./scripts/add_paths_ro.sh))
  (add-runtime (builtins.readFile ./scripts/add_config.sh))
  (add-runtime ''echo "''${RUNTIME_ARGS[@]}"'')
  (try-readonly (noescape "~/.config/dust/config.toml"))
]
