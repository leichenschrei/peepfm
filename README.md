<h1 align="center">peepfm</h1>

This is a small utility written in
[POSIX](https://pubs.opengroup.org/onlinepubs/9699919799/)-compliant AWK
that crawls user-defined artist shoutboxes on [lastfm](https://last.fm/)
and prints shouts published throughout the day.

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
Sutcliffe Jügend
Genocide Organ
Muslimgauze
EOF
```

As shown in the following snippet, proper capitalization is not required
for the program to work correctly:

```
            CURRENT 93
cabaRET voltAIre
    nocTURNal eMISSiONs
```

### Parsing recent shouts

First, let’s run `peepfm.awk` without any arguments. This will allow it
to fetch the web pages that we will parse locally later on.

On February 1st, 2024, `peepfm.awk` produces the following output based
on the previously defined artists:

```sh
$ ./peepfm.awk
peepfm: fetching artist shoutboxes as of 2024-02-01
peepfm: processing 7 web pages...

MUSLIMGAUZE > dis nigga been right
```

### Parsing shouts published on a given date

Since we ran `peepfm.awk` once without any arguments, it pulled all the
relevant web pages from last.fm and saved them in a temporary directory.
If we were to look up shouts published yesterday, two weeks—or even
months—ago, we could easily do this without re-downloading every page by
giving the program a specific date in the format of ‘YYYY-MM-DD’:

> **NOTE**:
>
> The program parses the index page of the comments, so many older
> shouts will not be printed out.

```
$ ./peepfm.awk 2023-11-08
peepfm: processing 7 web pages...

GENOCIDE ORGAN > Why? To spread the genocide over Tel-Avive or Haifa or wherever in Israel... It could be a good idea.
GENOCIDE ORGAN > "Ich werde ihnen zeigen, wo die eiserne kreuze wachsen..."
GENOCIDE ORGAN > No, Prurient is so secondary and overrated...

MUSLIMGAUZE > Hidden Crash Bandicoot soundtrack

SUTCLIFFE JÜGEND > Seesh... Well, why not
```

### Dealing with Unicode

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
