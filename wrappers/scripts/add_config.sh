# This script adds config files read-only based on --config=<path>
for i in "$@"; do
    case $i in
    # absolutely referenced config files
    --config=/*)
    path=${i#--config=}
    RUNTIME_ARGS+=(--ro-bind "$path" "$$path")
    ;;
    # relatively referenced config files
    --config=*)
    path=${i#--config=}
    RUNTIME_ARGS+=(--ro-bind "$(pwd)/$path" "$(pwd)/$path")
    ;;
    esac
done