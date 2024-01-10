<h1 align="center">peepfm</h1>

This is a small utility written in
[POSIX](https://pubs.opengroup.org/onlinepubs/9699919799/)-compliant AWK
that crawls user-defined artist shoutboxes on [lastfm](https://last.fm/)
and prints shouts published throughout the day.

There is currently no way for you to parse past shouts, though. I may or
may not add this functionality in the future.

## Dependencies

`peepfm.awk` uses the `curl` package to scrape web pages.

## Usage

```sh
$ ./peepfm.awk
```

Let’s start by creating a directory that will contain an `artists` file
later on:

```sh
$ mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/peepfm"
```

It is important to create a list of musicians whose shoutboxes we would
like to check out:

```sh
$ cat >> "${XDG_DATA_HOME:-$HOME/.local/share}/peepfm/artists" <<EOF
Nocturnal Emissions
Cabaret Voltaire
Current 93
Bourbonese Qualk
EOF
```

As shown in the following snippet, proper capitalization is not required
for the program to work correctly:

```
            CURRENT 93
cabaRET voltAIre
    nocTURNal eMISSiONs
```

On January 11th, 2024, `peepfm.awk` produces the following output based
on the previously defined artists:

```sh
$ ./peepfm.awk
peepfm: fetching artist shoutboxes as of 2024-01-10
peepfm: processing 4 web pages...
```

As you can see, no messages were printed to the terminal on that date
because no one had posted in the shoutboxes of Nocturnal Emissions,
Cabaret Voltaire, Current 93, and Bourbonese Qualk.

> **NOTE**:
>
> Some users may use emojis in their comments, so it is important to
> have a font that can properly render the Unicode character set.

On Debian GNU/Linux, you can install such a font by running the
following command:

```sh
$ sudo apt-get install fonts-symbola
```

You may need to build font information cache files after the
installation is complete:

```sh
$ fc-cache -fv
```
