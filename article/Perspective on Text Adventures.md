Perspective on Text Adventures
==============================

*   status: under construction

I'm writing this in order to reduce the number of tangents I go off on in
the [Text Adventures of Note](Text%20Adventures%20of%20Note.md) and
[Text Adventure Classics](Text%20Adventure%20Classics.md).
This is more of a memoir (or something) than a curational list.
At any rate, expect it to be a bit rambly.

I grew up in the 80's.  I had a Commodore 64.  I really liked video games.
I wanted to write my own video games, but BASIC was too slow.  So when I
wrote my own games, they were often text adventures.

I say "text adventure" here because that's what they were called at the time,
before Infocom began labelling its wares as "interactive fiction".

But even nowadays I generally avoid the term "interactive fiction".
I still call them "text adventures".  Probably mainly because it
doesn't carry the connotations that "fiction" does.  There isn't an
assumption that they have any plot beyond perhaps "collect all the treasures",
nor any character development or other narrative elements.

It is a more basic form.  It involves a computer giving a player some
text, being a description of some kind of imagined environment, and
then the player giving the computer some text, being a description of
what the player would like to do in this environment.  With this cycle
repeating until some end goal is reached.

The requirement that the player communicates their intentions
in a textual form disqualifies things like "Choose Your Own Adventure" books
(or the modern equivalent, vanilla Twine games) from being text adventures,
even though one could argue that they are a form of "interactive fiction",
at least if one takes that term on its face value.

But one typically does not; interactive fiction is its own thing.
I would say that interactive fiction is a subset of text adventuredom which
is assumed to have narrative elements (such as plot and character development
and so forth) in order to be more like conventional, non-interactive fiction.

But this property doesn't interest me greatly, and in fact I often feel that
it detracts from the somewhat dreamlike effect that a narrative-lacking,
unmotivated, and slightly incoherent world can have.

This definition I've given also does not exclude text adventures with graphics.
When the graphical content consists of still pictures (possibly with minor
animations only loosely connected with gamepay), I do not consider this
to be much different from a book with illustrations.  The exchange between
computer and player is still primarily text-based.

I don't remember which text adventure I played first.  It was either
[Zork I][] or [African Adventure: In Search of Dr. Livingston][].  It was
likely the former.  I think I had known of text adventures before playing
one; possibly I had read about them in a magazine.

These were both very influential, but of particular influence was the book
[Write your own Adventure Programs for your Microcomputer][].

This book was probably responsible for setting me off in the direction of
programming languages, too, because it describes how
to write a simple one-or-two word parser for an adventure game.

And (once again on the point of nomenclature) I'd like to note that that was
a frustratingly difficult book to find again in adulthood, because I was convinced
that it had the term "text adventure" in its title, when it in fact does not,
it has the term "adventure program" which is not something anyone, as far as I
know, ever calls them.

That wasn't the only idiosyncratic thing about that book.  It seems to claim,
quite strongly, that the map of the territory through which the player travels
in the game must be a dense two-dimensional array.

"Haunted House" (which was the type-in adventure which appeared in the book
and which the bulk of the book was dedicated to analyzing), for example, had
64 locations in an 8-by-8 grid.

Further, the book claimed that if you wanted to do a 3-dimensional map,
you'd need a 3-dimensional array, and that this takes a lot of memory.

This did not jibe with my experience, even at the time.  The games I had
played had very irregular maps that would not comfortably fit in a grid,
and which had one-way routes and up-and-down routes and even "bendy" routes
(where west and south are "opposite directions", for example.)

I had seen maps of Zork I published in Electronic Games magazine, too,
and they made this visually obvious.

I realized (through I did not know the term "graph" at
that point in time, and indeed the term "graph" seems to not have been
standardized at that point in history, with some authors calling them "plexes"
or "mazes"; see [Microprocessor Programming for Computer Hobbyists][])
that the map could be represented by a graph with
degree 4 for the four cardinal directions, or 6 if you wanted to add up and
down, or even 10 if you wanted the 4 diagonal directions too.

And so when I went to write my own games, I did not follow the advice of that
part of the book, and instead I used a 2-dimensional array like `DIM EX(30,6)`
to store the "exit information" for each room.

But other than that, there is a lot of sound advice in this book.
For example, "There is no point hiding a key in a dark room and then putting
the lantern behind a locked door."

Another piece of advice was to put objects where they would be expected
to be found - axe near the woodpile, coat in a closet, and so forth.

However, that gets back to why I feel that text adventures are a different
beast from interactive fiction.  Discovering objects in places they don't
belong can induce a _frisson_ of Surrealism.  I remember several such instances
in Zork I and African Adventure.

[Zork I]: Classic%20Text%20Adventures.md#zork-i
[African Adventure: In Search of Dr. Livingston]: Text%20Adventures%20of%20Note.md#african-adventure-in-search-of-dr-livingston
[Write your own Adventure Programs for your Microcomputer]: An%20Esolang%20Reading%20List.md#write-your-own-adventure-programs-for-your-microcomputer
[Microprocessor Programming for Computer Hobbyists]: An%20Esolang%20Reading%20List.md#microprocessor-programming-for-computer-hobbyists

