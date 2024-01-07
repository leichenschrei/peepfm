#!/usr/bin/awk -f
# Parse recent artist shouts on lastfm.
BEGIN {
    base     = "peepfm"

    filename = "artists"
    basepath = get_xdg_path() "/" base
    data     = basepath "/" filename

    read(data)
}

function get_xdg_path() {
    cmd = "printf '%s\n' " " ${XDG_DATA_HOME:-$HOME/.local/share}"
    cmd | getline xdg
    close(cmd)
    return xdg
}

function read(input) {
    while ((getline artist < input) > 0) {
        sub(/^[ \t]*/, "", artist)
        sub(/[ \t]*$/, "", artist)
        ARGV[ARGC++] = artist
        print artist
    }
}
