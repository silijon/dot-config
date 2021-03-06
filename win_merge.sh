#!/usr/bin/env sh

VS_MERGE='/mnt/c/Program Files (x86)/Microsoft Visual Studio/2017/Professional/Common7/IDE/CommonExtensions/Microsoft/TeamFoundation/Team Explorer/vsDiffMerge.exe'

get_filename() {
    echo "$1" | sed 's:.*/::'
}

resolve_path() {
    pushd "$(dirname "$1")" >/dev/null
    local base_path="$(pwd -P | sed 's:/mnt/::;s_/_:/_;s:/:\\:g')"
    echo "$base_path\\$(get_filename "$1")"
    popd >/dev/null
}

do_diff() {
    local tmp_local="$(get_filename $1)"
    local remote="$(resolve_path "$2")"
    cp "$1" "/mnt/c/Windows/Temp/$tmp_local"
    "$VS_MERGE" /t "C:\\Windows\\Temp\\$tmp_local" "$remote" Source Target
}

case "$1" in
    diff)  do_diff "$2" "$3" ;;
    merge) "$VS_MERGE" /m "$2" "$3" "$4" "$5" ;;
esac
