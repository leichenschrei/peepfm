#!/usr/bin/awk -f
# Parse recent artist shouts on lastfm.
BEGIN {
    base     = "peepfm"

    filename = "artists"
    path     = "${XDG_DATA_HOME:-$HOME/.local/share}" "/" base
    data     = path "/" filename

    read(data)
}

function read(input) {
    while ((getline artist < input) > 0)
        ARGV[ARGC++] = artist
}
