#!/usr/bin/awk -f
# Parse recent artist shouts on lastfm.
BEGIN {
    base     = "peepfm"
    date     = getdate()
    dep      = "curl"

    filename = "artists"
    basepath = get_xdg_path() "/" base
    data     = basepath "/" filename

    sitehead = "https://www.last.fm/music/"
    sitetail = "/+shoutbox"

    check(dep) || die("utility is not installed: " dep)

    say("fetching artist shoutboxes as of " date)
    read(data)
    say("processing " nartists " web pages...")
}

index($0, date) {
    for (i = 0; i < 10; i++) getline shout

    prev = p
    name = p = stylise(FILENAME)
    if (name != prev) print ""

    sub(/^ */, "> ", shout)
    gsub("&#34;", "\"", shout)
    gsub("&#39;", "'", shout)
    print name, shout
}

function say(content) { printf "%s: %s\n", base, content }

function die(message) {
    err = "cat >&2"
    printf "%s: error: %s\n", base, message | err
    close(err)
    exit(2)
}

function check(util) {
    cmd = "command -v"
    rdr = ">/dev/null 2>&1"
    return (system(cmd " " util " " rdr) == 0 ? 1 : 0)
}

function getdate() {
    cmd = "date +%Y-%m-%d"
    cmd | getline date
    close(cmd)
    return date
}

function stylise(name) {
    sub("/tmp/", "", name)
    sub(".html", "", name)
    gsub("[+]", " ", name)
    return toupper(name)
}

function get_xdg_path() {
    cmd = "printf '%s\n' " " ${XDG_DATA_HOME:-$HOME/.local/share}"
    cmd | getline xdg
    close(cmd)
    return xdg
}

function read(input) {
    while ((getline artist < input) > 0) {
        nartists++
        sub(/^[ \t]*/, "", artist)
        sub(/[ \t]*$/, "", artist)
        gsub(" ", "+", artist)
        ARGV[ARGC++] = scrape(artist, sitehead artist sitetail)
    }
}

function scrape(name, link) {
    out = "/tmp/" name ".html"
    cmd = "curl" " -s -L " link " > " out
    system(cmd)
    return out
}
