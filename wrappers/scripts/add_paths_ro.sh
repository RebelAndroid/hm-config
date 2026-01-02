# This script provides every path that appears in the arguments to the jail
# anything that does not start with a "-" is interpreted as a path
added_path=false
for i in "$@"; do
    case $i in
    # options starting with "-", not relevant for permissions
    -*)
    ;;
    # absolute path
    /*)
    RUNTIME_ARGS+=(--ro-bind "$i" "$i");
    added_path=true
    ;;
    # relative path
    *)
    RUNTIME_ARGS+=(--ro-bind "$(pwd)/$i" "$(pwd)/$i");
    added_path=true
    ;;
    esac
done
# if no files were given, ls lists files in the current directory so we add it
if [ "$added_path" = false ]; then
    RUNTIME_ARGS+=(--ro-bind "$(pwd)" "$(pwd)");
fi