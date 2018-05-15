Befunge Silver Jubilee Retrospective
====================================

*   status: under construction

The [Befunge](http://esolangs.org/wiki/Befunge) programming language was created in 1993,
meaning 2018 is its 25th anniversary!

[Cat's Eye Technologies](http://catseye.tc/) has planned to do some celebratory
stuff to mark this silver jubilee anniversary year, but I don't know how much of that stuff we will actually get done.

But what we can start with is this article, which I hope will be a sort of overview of
the course of development of the design of Befunge, describing, among other things, where it left off.

### Befunge-93

The original version of Befunge is generally called [Befunge-93](http://esolangs.org/wiki/Befunge-93).
It was not named this belatedly to distinguish it from its successor Befunge-98; it was called Befunge-93
right from the start, as a tongue-in-cheek reference to languages such as
[COBOL-85](https://en.wikipedia.org/wiki/COBOL#COBOL-85) and
[Fortran 90](https://en.wikipedia.org/wiki/Fortran#Fortran_90).

But the Befunge Version Numbering System doesn't stop there; the actual rule is that the number following
"Befunge-" is the year that that version was released, minus 1900.  So, if there was a version of
Befunge released this year, it would be Befunge-118.  Sadly, no new versions of Befunge
have yet been released after 1999 to take advantage of this lame joke.

The name "Befunge" itself came from a typo, which I think is a great approach for naming
languages, as it combines [that one quote by Knuth](https://www.brainyquote.com/quotes/donald_knuth_181626)
with the crackpot ideas about automatic writing that Breton & the other Surrealists held.
The name hung around without a language to go with it for at least a couple of weeks, maybe
a couple of months or more.  I went through a couple of designs, discarding them, before
hitting on the one that went with the name.  (I hope to publish these discarded designs as
part of this 2018 thing.)

By the way, the word is not spelled "BeFunge", and it has no relation to "fungus", but I suppose
it's unrealistic to hope that people wouldn't make these kinds of unjustified leaps.

#### A Pioneering Language

Whether you can say that Befunge-93 is the first 2-dimensional programming language or not
depends entirely on what you accept as a programming language.  If your definition includes
notations for programs which were not intended to be processed in an automated way, then
some of the very first high-level programming languages - [flowcharts](https://en.wikipedia.org/wiki/Flowchart#History)
and [Plankalkül](https://en.wikipedia.org/wiki/Plankalk%C3%BCl) - were 2-dimensional.  If your
definition excludes those, but includes automata which are Turing-complete (even though,
perhaps, hardly suitable for programming in,) then possibly John Conway's Game of Life qualifies.

But if you have in mind a program as something textual that you type into a computer and then
you run it and then it maybe produces some textual output after maybe asking for some textual
input - then Befunge-93 is, if not the first, then an early example of such where the programs
are distinctly two-dimensional.

On the other hand, I once attended a lecture on programming languages where the lecturer
(unaware that I was in the audience) brought up Befunge as an example of something that they
weren't going to talk about because it wasn't a _real_ programming language.

So, as I said, it comes down to what you will accept as one.

#### Turing-completeness

Befunge-93 is not Turing-complete.  (Heck, it's not even PDA-complete!)
But you know what?  That never stopped Wim Rijnders from
[writing Hunt the Wumpus in it](https://github.com/catseye/Befunge-93/blob/master/eg/wumpus.bf).
What I'm saying is, I get the impression that a lot of programmers have a rather fuzzy,
not to say off-kilter, notion of
what it means for a language to be Turing-complete.  Well, I was in that boat too, once,
but correcting those impressions goes beyond the scope of this article.  If I write something on this topic someday,
I'll update this paragraph to link to it.

### Funge-98

2018 is not just the 25th anniversary of Befunge, it's also the 20th anniversary of its
successor, Funge-98.  While the design of Befunge-93 was very much an individual effort,
Funge-98 was designed by committee - the Befunge Mailing List Working Group.

#### Generalization

Unlike Befunge, Funge is a family of programming languages, of which Befunge is the
two-dimensional member; the one-dimensional member is called Unefunge and the
three-dimensional member is called Trefunge. (You can probably see the naming convention
there.)

Unefunge, Befunge, and Trefunge are defined by the
[Funge-98 spec](https://github.com/catseye/Funge-98/).  The spec alludes to
the existence of Funges of yet higher dimensionalities, and even of different
topologies, but does not actually specify them.  (It should be noted that the
word "spec" can be short for both "specification" and "speculative".)

There was a small amount of interest in having a Unefunge (see also [Blank](http://esolangs.org/wiki/Blank),
which someone, possibly Rafal Sulejman, claimed to have found useful for
writing "stored procedures" in CHAR fields in an SQL database),
but the fact is that Funges in dimensions higher than 2 never seemed to catch on.
There could be many reasons for this.  One is probably that, while 2 dimensions matches the
"picture plane" of a text editor, as soon as you get to 3 dimensions, you need
a bit more specialized software — or more imagination — to visualize and edit the
program, and that's just enough of a barrier that most programmers won't bother.
(And if they do bother, it's entirely possible they pick a language that makes more
interesting use of three dimensions than Trefunge does.)

In the extreme case, there was an idea (from the same person who produced the
typo "Befunge" originally, I think) for an _n_-dimensional variant, called "Nefunge", where each vector
is an array of arbitrary length.  However, this design deviated enough from the others — you'd need to
construct such vectors slightly specially — that I don't think it was ever implemented or explored.

### After Funge-98

Why did development of the language stop after Funge-98?  There are many reasons, both technical
and social.

From a design perspective perhaps you could say Funge-98 reached a local maximum. While there are
several directions you could take the ideas in Funge-98 further, they mostly diverge, and if you start
following them, you start backtracking on the principles on top of which they are built.
(Or, if "principles" is too strong a word, then at least the properties that seem to have made
Befunge attractive in the first place.)  I'll discuss some specific design issues in more detail below.

Community-wise, the organization of the mailing list on which the design and development of Befunge
was discussed was probably too loose and chaotic to support anything more than this.  The voices
that were advocating what should or should not be in the next version were also people who weren't
writing many programs in Befunge themselves (myself included.)

I actually wrote a proposal for a Befunge-99 (or Befunge-100?) at some point, but I suppose it
strayed far too far from the existing design (it used, for instance, abstract symbols not found in any
character set to represent the instructions), and I don't remember anyone making any remark on it
at all.  It is probably utterly lost now.

There was also the fact that my ISP at the time, a local small business, was being acquired by a
much larger and more faceless corporation, and I didn't really feel like convincing them to
retain the mailing list I was hosting when they migrated my account (I got the distinct
impression that even trying to explain to them that, on the ISP they were acquiring,
_users could run their own instances of qmail_, would have left them frowning in confusion.)
So the mailing list was decomissioned in a blaze of glory, and I went off to do
Things Other Than Esolang for a while.

All in all I do not regret this.  You might ask: since history will inevitably one-hit-wonder
me into "that Befunge guy" anyway (thanks, history!), why did I not play that role to its
hilt and promote the living daylights out of it?

Well, milking Befunge for all it's worth is just... not who I am, as I found out through
experience.  Cripes, I almost tried to sell Befunge CD-ROMs and T-shirts once, you know that?
In my defence, I wanted to have the proceeds go to charity, but when I looked into what was
actually involved in doing that, the amount of paperwork involved completely demotivated me.

And even by the time Funge-98 was released, I had been exploring other corners of the design
space of programming languages, and doing that was far more interesting to me than flogging a
language that I had largely burned out on. And so that's what I did.

### Design Issues

#### Continuity vs Expressivity

In Befunge there's a tension between continuity (in some sense) and expressivity (in some sense).

For example, the "Jump"-type instructions let you do reasonably powerful flow control.  You could add some kind
of call/return semantics to this, to get reusable subroutines.  And then you could go further,
and let the subroutines be given names.  This would add a lot of expressive power.
But it is highly conventional.  (At one point I proposed the "Principle of
Greatest Astonishment", as a counter to PoLA, for a yardstick for language features for esolangs.)  Worse,
it is receding far away from the simple, straightforward flow control of `<^>v` ("and sometimes `#`"),
and losing some of that charm, while bringing in no real charm of its own.

On the other hand, say you wanted to increase continuity.  Funge-98 had already introduced `j` and `J`
and `X`.  But all you need is the cardinal directions, `<^>v` ("and sometimes `#`").  If you decide to
restrict the language to those, you're reverting from Funge-98 to Befunge-93.  This could be called
backpedalling.

I was, and still am, in favour of more continuity, though, to the point of even thinking that
`g` and `p` should be removed in favour of instructions that get and put values from cells that are
directly adjacent to the IP.  But whether that's a good design choice or not is not the question;
the question is, is it Befunge or not?  And I don't think it quite is.  Because for all their
violation of continuity, `g` and `p` did lend Befunge-93 a certain charm.

So, back to the drawing board.

#### Extensibility

Another major factor in why development on Befunge stalled after Funge-98 is probably
the existence of fingerprints — Funge's extension mechanism.  If you
want a version of Befunge-98 that is extended in some way, you can define a fingerprint
for it.  Then, if you're serious, you can go and implement that fingerprint in a
Befunge-98 interpreter.  Then if you're *really* serious you can write a Befunge-98
program that *uses* your fingerprint and does Heaven-knows-what and is arguably not even
a Befunge-98 program anymore.

(There are also handprints, but those were intended more for detecting a particular
implementation of Funge-98, presumably so that your program can compensate in some manner
for some thing that you know that implementation does that you find undesirable.
You probably *could* extend Befunge using handprints, but the facility
wasn't really designed for it, and fingerprints, being less drastic, are probably the
path most people who have been tempted to do this have taken instead.)

There was, once, a Central Fingerprint Registry for Funge-98.  It did not last.
There was an open web interface for adding a new fingerprint, but I assumed people
would try to discuss them on the mailing list before registering them.  Apparently no.
So I took it down, only a few days after it went up.

Today, fingerprints travel by word of mouth.  There is, in fact, nothing whatsoever
stopping you from, right this minute, defining a new fingerprint (after picking a
32-bit identifier that you hope and guess and to the best of your research determine
has not yet been used), writing up a spec, and posting it on your blog with a
title that includes the words "Funge-98 Fingerprint" or something in the
sincere hopes that search engines will index it and that people looking for
Funge-98 fingerprints will search for those words in those search engines.

#### Ambiguity

There is occasionally a desire expressed to "clean up" the Funge-98 spec and rewrite parts
"in a more formal language" with the goal of "removing ambiguities".

I think this is misguided.

I felt this way at one point too.  But then it was pointed out to me, that a large part of the appeal of
Funge-98, is that it is *not* very well specified.  That it reads like something that was put together
by a committee of amateurs (which is exactly what it is.)  And the consequences of it being poorly
standardized are minimal.  That a program runs on one Befunge-98 interpreter but not on another is hardly
the end of the world.  Heck, the mindset that leads to looking at programming in Befunge-98 as being an
interesting problem instead of an annoyance, can also lead to looking at making the program run on two
slightly incomparible interpreters an interesting problem instead of an annoyance.

To put it another way, the entertainment value of the specification being written the way it is
generally outweighs, in my mind, whatever value there would be in the specification being written more
rigorously.

This is why I am often loathe to apply patches to the specification when they are submitted.  Besides,
it's way past 1998 now!  I think the damage is done, right?

### After Funge-98

#### Flobnar

When Befunge-93 turned 18, I celebrated the fact that it was old enough to drink (in its native land
of Canada) by designing a purely functional variation on Befunge called [Flobnar](http://catseye.tc/node/Flobnar).

Absolutely no-one cares about Flobnar.

#### BEEFGUN

Around 2007 I had the idea that you could apply the ideas from [Mascarpone](http://catseye.tc/node/Mascarpone),
namely having (or rather, pretending to have) an infinite tower of interpreters and being able to
"reify" and "deify" interpreters onto and off of this tower, to a Befunge-like language.  I called
this language idea BEEFGUN (an anagram of Befunge) and developed it a little bit, but only a little
bit.

Some of the things a Befunge interpreter does are: examine the cell under the IP for the current instruction,
modify the stack and/or the playfield according to the instruction; and move the IP to a new location for
the next instruction.  This suggests a modification of the Befunge language that adopts these operations.
I believe my idea was that the I/O instructions (`,` and `&`) would be re-purposed as reading from and
writing to the "external playfield" (because there would be an infinite tower of playfields as well as
interpreters) and some commands analogous to `<>^v` would move the "external IP" in that external playfield.

I still think there is some merit to this idea, or at least to its name.
