Retrospective on Language Design
================================

*   original-title: Retrospective: Chris Pressey on Language Design
*   publication-date: 15 Jul 2010


### Abstract

In contrast to [the list of languages I've designed][],
in this article, I talk about what it's *like* to design languages
and what my thoughts on certain languages and the design process are.

### Esolangs

Mostly I design [esolangs][], which, in a nutshell,
are programming languages that were never meant to be. On the surface,
they appear to serve no purpose. You wouldn't use one for writing a
"serious" program like an operating system or a text editor or a web
service — unless you were quite mad, of course. They aren't academic
research as we know it, either, because they don't aim to tell us
anything about how software engineering can be improved.

What they are, though, is *highly entertaining* — if you like that sort
of thing — which many people do. If you're one of those people who likes
programming *per se*, as a kind of intellectual challenge, then there's
a chance you'll become good at it, and the possibilities presented by
mainstream languages will begin to bore you. Solution? Try coding
something in [INTERCAL](http://esolangs.org/wiki/INTERCAL),
[brainfuck][], or [Befunge][]; and if those aren't weird
enough for you, try [Homespring](http://esolangs.org/wiki/Homespring),
or [Muriel][], or [Please Porige
Hot](http://esolangs.org/wiki/Please_Porige_Hot). Guaranteed to not be
boring. And when you're really ready to test your mettle,
[Malbolge](http://esolangs.org/wiki/Malbolge) will be waiting for you.

They are also *things of beauty* — in their own right — if you can see
it — which many people can. They are works of art. But the medium of
programming language occupies a fairly unusual aesthetic position; any
program written in some esolang is also potentially a work of art, and
the program which implements the esolang — the interpreter or compiler —
might well be a work of art too.

Sometimes it seems like people sort themselves into groups based on
these attributes. Some people like to write programs in esolangs
(Brainfuck golf comes to mind,) some people like to design new and
interesting esolangs, and some people like to implement esolangs. I am
pretty squarely in the second group. While I am sometimes found
implementing others' designs when they impress me, I generally lack the
patience, concentration, stick-to-it-ive-ness, raw
reasoning-inside-a-system ability, and quite frankly spare time it takes
to puzzle together a working program in most esolangs. These days I find
it quite challenging enough to merely compose example programs for my
own esolangs.

### Quantity...

I have, at this point, designed over 50 languages. Exactly how many
depends on how you count. I don't consider [Illgola-2][], [Illberon][], or
[Open Sores Illgol##][] to really be different languages from
[ILLGOL][] — I've even gone back and forth on
whether they should live in the same distribution or not. I don't consider
[Jacciata][] to be significantly different from
[Jaccia][]; and I'm not sure whether
[beta-Juliet and Portia][] should count as two.
On the other hand, I do see
[Befunge-93][] and
[Befunge-98][] as being quite different, as are
say [Emmental][] and
[Mascarpone][], and
[Arboretuum][] and
[Treacle][]. And when you get into language
families, well, arguably [Funge-98][] only has 3
viable members, but there is really no limit to the number of
[Didigm][]s there are.

Yet I do consider my cellular automata to be languages. Partly because
some of them have roots in systems that were more clearly processor-, if
not language-, like: [REDGREEN][] is an
adaptation of [RUBE][] to CA, just as
[Braktif][] is an adaptation of Brainfuck, or
[Circute][] is an adaptation of circuitry.
Partly because they are Turing-equivalent systems in which problems can
be expressed and solved, just as they can in run-of-the-mill programming
languages.

### ...and Qualities

However, I am not by any means the most prolific language designer out
there. In fact, for sheer numbers, I seem to be in third place, behind
[Wouter "Aardappel" van Oortmerssen](http://strlen.com/) and
[zzo38](http://esolangs.org/wiki/User:Zzo38). But sheer numbers aren't
everything. Unlike zzo38, the majority of my designs have been
implemented, and unlike Wouter, the majority of my designs and
implementations are publicly available from [my website](http://catseye.tc/).

So I might be led to consider other ways to measure my success as a
language designer. What about popularity? Alas, it seems that I am third
in that arena too; the inevitable roll call of canonical esolangs seems
to be INTERCAL, then Brainfuck, then Befunge (see, even I followed that
sequence, above.) But, perhaps we will find a measure which is subtler
still, if we examine influence. While Brainfuck is the clear winner
here, with dozens and dozens of descendants and variants both major and
minor, (and yes, I have done a couple of these myself), I have the
distinction of having several of my languages inspire designs and
implementations and such by others, a fact by which I am flattered. For
instance, [Befunge-93][] has been implemented
dozens (maybe hundred) of times, and has influenced
[Blank][],
[Befreak](http://esolangs.org/wiki/Befreak),
[PATH][], and
[Aheui](http://esolangs.org/wiki/Aheui), among others;
[RUBE][] found its way into [RUBE II][],
[RubE On Conveyor Belts](http://esolangs.org/wiki/RubE_On_Conveyor_Belts),
and [Rubicon](http://kevan.org/rubicon/);
[SMETANA][] inspired a FSM-completeness proof in
the form of [Smallfuck][]; and
[SMITH][] begat
[SMITH\#](http://esolangs.org/wiki/SMITH_sharp) and
[SMITHb](http://esolangs.org/wiki/SMITHb). Even
[Xigxag][] seems to have attracted some attention
(and shorter proofs than my own).

### A Matter of Taste

What makes a "good" esolang? I'm not sure, but I have some opinions. For
starters, to take Brainfuck and to replace each instruction with a
different barnyard sound is... well, as Jeeves would say, I should
scarcely advocate it. At the same time, I rail against the idea of
reducing languages to "just semantics"; a delicate touch with the syntax
is what makes a good language outstanding, esolang or otherwise.

Languages I design tend to fall into a couple of groups. One is the
straight-up parody language, making fun of the absurdity of computer
programming or some other ridiculous activity.
[ILLGOL][] is probably the canonical example, but
[HUNTER][], ['N-DCNC][],
[Jaccia][] and maybe
[Sbeezg][] count, too.

Another group are the "merely interesting" languages which don't really
count as esolangs because they're just too normal, perhaps even
attempting to solve a practical problem; this would include at least
[ETHEL][], [Bhuna][], [Iphigeneia][], [Arboretuum][], [Treacle][],
[Dieter][], and anything I design any time I
start getting fed up with the state of modern mainstream languages and
think I can do better. (I don't usually try to publish those.)

A third group is made up of "strange exercises"; languages which are
designed around some principle which turns out to have unusal effects.
This could include [Sally][], [Larabee][], [Mascarpone][], and
[Unlikely][].

But probably my favourite design category is the "impossible language".
Pick a combination of features which appears absurd and contradictory,
like an Escher staircase or a de Chirico piazza, and in implementing it,
tease out a labrythine connection which allows it to exist. Whether that
be a machine language with no branch instructions — none at all — like
[SMITH][], or a non-deterministic imperative
language like [Strelnokoff][], or a conlang
without word order like [Opus-2][], or a language
with only infix operators but no precedence table like
[Hev][], or a Turing-equivalent language with only
`foreach` like [Quylthulg][], or a language
with memory-mapped loops like [ZOWIE][], or a
language where the only means of control flow is throwing and catching
lexical exceptions like [Okapi][], or an
imperative string-rewriting language like [Pophery][] (under
construction)... the results are usually highly entertaining.

What are my favourite esolangs, you ask? Well, the three I listed
earlier (Homespring, Muriel, and Please Porige Hot) hold special places
in my heart. The favourite esolangs of my *own* is a much harder
question to answer. I will say that, in terms of striking a balance
between "challenge to code in" and "beauty", I think
[Mascarpone][] is one of my best. That
doesn't necessarily mean it's my favourite, though.

### The Design Process

I should really say something about the design process itself. One thing
I can point out is how long it typically takes to design a language;
it's usually measured in years. It starts with an idea, of course. But
ideas are a dime a dozen, and it's recognizing the good ones, the ones
that fall in some relatively narrow zone between "too weird" and "not
weird enough", that's the hard part. Then the challenge is not
forgetting the idea, which usually means writing it down before your
brain is engaged in other pursuits. Sometimes it comes back if you
don't, but not always. Sometimes you can't reconstruct it from what you
wrote down, either, but usually you can.

After the idea has proven promising enough to make it into the notebook,
there comes a period of time known as development. The idea is almost
never a full-formed language, so it must grow into one, although
sometimes it [never reaches that stage][]. This is actually
why I try to implement my designs whenever I can; implementation fleshes
out the grey areas and lays bare any places where the design falls
apart. It usually leads to a more solid theme or paradigm inside the
design, too, as the implementation phase generally alternates between
(re)implementation and (re)design.

And this process, as I said, takes years. This is largely because I hold
down a full-time job and spend much of my time maintaining a household
too, so there is a tight limit on the amount of time I can spend. It is
also largely because at any given time I am working on a dozen different
designs "breadth-first", and must split my attention between them.
However, there is also something to the idea that a design must age,
like wine, to be really good. If the small amount of initial work I may
have done on something still interests me a year later, I have a better
feeling that it is worth finishing. Also, many designs accumulate small
changes over time as I look at them from different angles, while others
are simply difficult to fully conceive or implement —
[Burro][] and [Okapi][] come immediately to mind.

[the list of languages I've designed]: http://catseye.tc/node/Chris_Pressey's_Lingography
[never reaches that stage]: http://catseye.tc/node/LoUIE
[esolangs]: http://catseye.tc/node/Esolang
[Arboretuum]: http://catseye.tc/node/Arboretuum
[Befunge]: http://catseye.tc/node/Befunge-93
[Befunge-93]: http://catseye.tc/node/Befunge-93
[Befunge-98]: http://catseye.tc/node/Befunge-98
[beta-Juliet and Portia]: http://catseye.tc/node/beta-Juliet
[Bhuna]: http://catseye.tc/node/Bhuna
[Blank]: http://catseye.tc/node/Blank
[brainfuck]: http://catseye.tc/node/brainfuck
[Braktif]: http://catseye.tc/node/Braktif
[Burro]: http://catseye.tc/node/Burro
[Circute]: http://catseye.tc/node/Circute
[Didigm]: http://catseye.tc/node/Didigm
[Dieter]: http://catseye.tc/node/Dieter
[Emmental]: http://catseye.tc/node/Emmental
[ETHEL]: http://catseye.tc/node/ETHEL
[Funge-98]: http://catseye.tc/node/Funge-98
[Hev]: http://catseye.tc/node/Hev
[HUNTER]: http://catseye.tc/node/HUNTER
[ILLGOL]: http://catseye.tc/node/ILLGOL
[Illgola-2]: http://catseye.tc/node/Illgola-2
[Illberon]: http://catseye.tc/node/Illberon
[Iphigeneia]: http://catseye.tc/node/Iphigeneia
[Jaccia]: http://catseye.tc/node/Jaccia
[Jacciata]: http://catseye.tc/node/Jacciata
[Open Sores Illgol##]: http://catseye.tc/node/Open_Sores_Illgol__
[Larabee]: http://catseye.tc/node/Larabee
[Mascarpone]: http://catseye.tc/node/Mascarpone
[Muriel]: http://catseye.tc/node/Muriel
['N-DCNC]: http://catseye.tc/node/'N-DCNC
[Okapi]: http://catseye.tc/node/Okapi
[Opus-2]: http://catseye.tc/node/Opus-2
[PATH]: http://catseye.tc/node/PATH
[Pophery]: http://catseye.tc/node/Pophery
[Quylthulg]: http://catseye.tc/node/Quylthulg
[REDGREEN]: http://catseye.tc/node/REDGREEN
[RUBE]: http://catseye.tc/node/RUBE
[RUBE II]: http://catseye.tc/node/RUBE_II
[Sally]: http://catseye.tc/node/Sally
[Sbeezg]: http://catseye.tc/node/Sbeezg
[Smallfuck]: http://catseye.tc/node/Smallfuck
[SMETANA]: http://catseye.tc/node/SMETANA
[SMITH]: http://catseye.tc/node/SMITH
[Strelnokoff]: http://catseye.tc/node/Strelnokoff
[Treacle]: http://catseye.tc/node/Treacle
[Unlikely]: http://catseye.tc/node/Unlikely
[Xigxag]: http://catseye.tc/node/Xigxag
[ZOWIE]: http://catseye.tc/node/ZOWIE

