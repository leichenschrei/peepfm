#!/usr/bin/awk -f
# Parse recent artist shouts on lastfm.
BEGIN {
    base     = "peepfm"

    data     = "artists"
    path     = "${XDG_DATA_HOME:-$HOME/.local/share}" "/" base
    datapath = path "/" data

    read(datapath)
}

function read(data) {
    cmd = "cat" " " data
    while (cmd | getline line)
        # TODO: parse the line
    close(cmd)
}
