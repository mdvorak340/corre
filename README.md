# NAME

corre - execute shell scripts embedded within text

# SYNOPSIS

**corre** [*OPTIONS*]\...

# DESCRIPTION

Used to execute shell scripts embedded within text files, and replace those
embedded scripts with their STDOUT results.

By default, the input for the corre is read from the STDIN and the output
printed to the STDOUT.  These can be redirected via file redirection or the -i
and -o flags.

The default delimiter used to mark an embedded script is the opening tag "!(("
and the closing tag "))!".  Backslashes can be used to escape these sequences
if needed and the delimiter can be changed with the -d flag.

The embedded scripts are called from the directory that corre is called from.

# OPTIONS

-i, -\-input
: The input file.  Defaults to the STDIN.

-o, -\-output
: The output file.  Defaults to the STDOUT.

-d, -\-delimiters
: Overrides the default delimiters "!(( ))!".  Separate the opening and
  closing tags with a space.

-h, -\-help
: Prints a help menu.

-V, -\-version
: Prints the current version of the program.

# BUGS

1. The characters "<" and ">" cannot be used as a part of a delimiter.

Report bugs to <mdvorak.projects@gmail.com>.

# EXAMPLES

Including partial files:

    $ cat main.md
    # Header

    !((cat ./partial.md))!

    And some text from the main file.
    $ cat partial.md
    Some text from a partial file.
    $ corre -i main.md -o out.md
    $ cat out.md
    # Header

    Some text from a partial file.

    And some text from the main file.

Including directory listings:

    $ ls ./src/ -1
    Element.hs
    Main.hs
    Markup.hs
    Patterns.hs
    $ cat list.md
    # All files in the `./src/` directory

    There are !((ls ./src./ -1 | wc -l))! file(s) in the `./src/` directory:

    !((
    for FILE in $(ls ./src/ -1)
    do echo "- `$FILE`"
    done
    ))!
    $ corre < list.md
    # All files in the `./src/` directory

    There are 4 file(s) in the `./src/` directory:

    - `Element.hs`
    - `Main.hs`
    - `Markup.hs`
    - `Patterns.hs`

Changing the delimiter:

    $ cat in.html
    <h1>Sub-pages</h1>
    ##(
    for PAGE in $(ls ./pages/*.html -1)
    do
        htag a "$(basename "$PAGE" .html)" \
            --href "$PAGE" \
            | htag li
    done | htag ul
    )##
    $ cat in.html | corre -d "##( )##" > out.html
    $ cat out.html
    <h1>Sub-pages</h1>
    <ul>
      <li><a href="./pages/about.html">about</a></li>
      <li><a href="./pages/contact.html">contact</a></li>
      <li><a href="./pages/resources.html">resources</a></li>
    </ul>

# SEE ALSO

Source code can be found at <https://github.com/mdvorak340/corre>.

Online manpage can be found at <https://mdvorak340.github.io/corre>.

Changelog can be found at <https://mdvorak340.github.io/corre/changelog>.

<!-- `rustdoc` documentation can be found at <https://mdvorak340.github.io/corre/doc/corre>. -->
