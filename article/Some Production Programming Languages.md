Some Production Programming Languages
=====================================

This is a collection of mini-screeds on commonly-used programming
languages, written between (let's say) 2007 and (let's say) 2013,
with varying levels of snark and high-mindedness.  (Which, reading
over them again today, induce varying levels of facepalminess and
cringeyness.)

They used to be strewn about my website.  I decided to collect them
in one place.

### C++

For any software project, it's important that you choose the right
language to develop it in. That's why you'll always choose C++, no
matter what the project is!

Why will you choose C++? Because it's popular, so a lot of programmers
know it. And a lot of programmers means a lot of competition, and that
means you'll be able to hire programmers at the lowest rate! This will
surely offset whatever costs might be incurred from choosing an
ill-suited programming language and hiring programmers who work at the
lowest rate.

And why *is* C++ such a popular programming language?

Is it because it's a good programming language? Hardly. That's like
saying that coffee is a popular beverage because it's healthful.

No, C++ is popular because C++ is popular. Hey, Google is a big,
successful company, and I hear they use C++... it must be *why* they're
successful! You should use C++ too!

But that's not the only reason. C++ is popular because programmers
*like* it. I suppose the question then is, *why* do programmers like it?

Is it because C++ makes it easy to write correct, maintainable code? Is
it because C++ is easy to learn? Is it because there are things you can
do in C++ that you can't do in any other language? Is it that C++ lets
your programs run as fast as they possibly can?

Anyone who has ever used C++ can tell you the answer to all of those
questions: No. (No, not even when it comes to making your program run as
fast as it can. C++ allows so much control over the low-level workings
of the program that the compiler cannot make optimizations that it
otherwise could, if the programmer were constrained to working at a
higher level of abstraction.)

So what is it about C++ that makes programmers like it?

Well, I have a theory. While most "normal" people feel that their lives
are too complicated, too full of arbitrary rules and boring details and
essentially meaningless things to remember, there's a certain strain of
psychology that actually *thrives* on complexity like this, because such
complexity *generates gratuitous expertise*.

What I mean by this is that if a system is easy to master, then there's
no opportunity to show off your mastery of it. There's no way to display
your dominance through your command of minutiae and knowledge of trivia.
And if that's what really motivates you, then, well, you're going to
avoid that system, because it doesn't provide you anything to work with
in the social game you want to play. Instead, you'll look for something
with a lot of nooks and crannies and bells and whistles and jargon and
buzzwords that you can familiarize yourself with, and you'll take every
opportunity to demonstrate that you are More Familiar with It than Thou.
You'll look for something like... well, like C++.

And if it so happens that programmers with this general personality type
*also* like the idea of *total control over their program* — and while
I'm no expert on psychology, somehow that seems likely — C++'ll have'em
downright hooked.

### CSS

If I, as a programmer, were to tell you that CSS is the ultimate hacking
language, would you be surprised? After all, it's not even a
programming language, really. But that doesn't really
matter, does it? It meets the only possible criterion there could be for
the ultimate hacking language: in order to achieve the effect that what
you want, you have to hack and hack and hack...

So, I have a question. If CSS is so superior to [those awful tables
which should never ever be used for
layout](http://phrogz.net/CSS/HowToDevelopWithCSS.html#tables), how come
a simple and much desired three-column layout, so trivial to construct
with a table, is considered [one of the holy grails of
CSS](http://www.alistapart.com/articles/holygrail)?

Seems that the real solution to this would be to have some set of
elements that has the layout behaviour of tables but without the "treat
this as tabular data, would you please" semantics. I suppose that's what
`display: table-cell` *et al* is for — if only more browsers supported
it.

I kvetch, but there *is* one very nice thing about CSS: unlike
[Javascript](#javascript), it's declarative, and not actually
as powerful as a Turing machine.  So, it might make
your page look ugly in nine out of ten browsers six out of seven days of
the week, but at least it probably won't hang, or crash, or corrupt the
browser's state.

### Haskell

In theory, Haskell is the perfect language for writing reference
implementations of programming languages.  It, itself, has semantics
which are specified reasonably formally.  It's purely functional
(does not permit side-effects), and these two things bring it much
closer to being like mathematics than other languages.
Additionally, Haskell programs are lazily evaluated (expressions
are only evaluated if they are needed), so, basically, Haskell is
denotational semantics.  Except it's also a program, so you can
run it.  It's executable denotational semantics.

Pretty sweet, right?  Well... yes, except for the small fact that
denotational semantics may not be the best way to describe your language
in the first place.  You might have to describe I/O and concurrency,
for example, and denotational semantics doesn't make that easy.

But I hear you say, well, Haskell has I/O and concurrency features.

OK, look.  It's a pretty profound thing to show that you can encode I/O
or concurrency or really, any feature of an imperative language that you
want, into a lazy functional language using monads, *but*, that doesn't
necessarily mean that it's always a beautiful thing to actually *do* so.

Yes you can do it, but no, it's not one of Haskell's strengths.  I've
accepted that.

Using Haskell for other purposes, though?  Well, I've already accepted
that, when going outside the "batch processing" world, Haskell is a little
out of its element, so I would not jump at the opportunity.
Armchair category theorists might enjoy writing a multithreaded
webserver with shared transactional memory monads or whatever, but I
have trouble imagining anyone except a category theorist enjoying
maintaining such a beast, so I wouldn't recommend it for most
"operational" projects.  Choose carefully.

Maybe functional reactive programming, or other techniques, will
change this.  Or maybe Haskell will simply continue to be the academic
playground for type theory research.  Or maybe both.

### Java

No comment.

### Javascript

Javascript, now there's a programming language rags-to-riches story.
Well, it still wears rags, but you know what I mean.

In the beginning, the World Wide Web was just a bunch of interlinked
static documents, which was just fine.  Hypertext, they called it.  Then
immediately it grew fill-out forms and queries which were sent to web
servers, which could respond with dynamically-generated content, like
the results of a web search, which was great.

And then along the way, the Web succumbed to the inviolable law of
software engineering that states  "Any sufficiently complex
program contains a buggy, half-implemented, undocumented
version of [Lisp](#lisp)".  If you've ever been on the receiving side of
requirements, you might also know this as, "Can we add a scripting
language?  That'd be awesome."  (Because taking a nice, predictable
system and making it Turing-complete is [always awesome](http://esolangs.org/).)

So, even though web pages at the time hardly justified being scripted,
Javascript was born.  And, to be fair, it's really not such a bad language
for having been designed in two weeks.  Of course, the name was pure
marketing; it shares almost nothing with [Java](#java) except curly braces.

And so the Web went through a painful period where Javascript
was used to make sites that tried to stand out from the crowd by
annoying the user in more advanced and petulant and irritating ways.
And during Javascript's childhood, every vendor implemented it
slightly differently, with different bugs and different reckonings of
the DOM (the API that refers to the parts of a web page).

And then, Ajax happened, which meant, in essence, that, you
could now use Javascript and XML to reload part of a page without
reloading the whole thing.  Which meant, in essence, that web pages
started to look a lot more like traditional user interfaces.  Which meant,
in essence, that there was actually a (somewhat) justifiable reason for
using Javascript.

And then a standard was written for Javascript (sort of) and jQuery
was developed (which handled some of the discrepancies between
browsers for you) and JSON took over from XML (but we
still call it Ajax, not Ajaj) and vendors' Javascript implementations
started to do JIT compiling and got reasonably performant and some
clever wag coined the term "web app" and *at that very moment* it
became an acceptable fact of life for a web page to hang or crash.
(Because it's now an "app", you see.)

And then it got even weirder.  Developers decided they wanted to
run Javascript *outside* of the browser.  Which, for the purposes of
automated testing of the scripts used on web pages, makes some sense.
But *then* some exceedingly clever people decided
it should [run on servers](http://nodejs.org/) and that
new, back-end software should be developed in it.  And the next
thing you know, it has an
[ncurses binding](https://github.com/mscdex/node-ncurses).  I give up.

### Lisp

I'm one of those people who wonders why anyone bothers programming in,
talking about, or thinking about Lisp anymore, since [Scheme](#scheme) exists.
That's just me, though.

### Perl

Perl is what happens when you play [Katamari Damacy](https://en.wikipedia.org/wiki/Katamari_Damacy)
with the Unix toolchain.

Ah, but the world should thank Perl for being the experiment that
demonstrated the effect of [designing a programming language around
natural-language principles](http://www.wall.org/~larry/natural.html)
(because for some reason, we learned so little from COBOL.) And of
course we should thank the experimenters for being so candid and
unbiased about their results. Finally, we have data that shows us what
we already knew, namely that [programming, no, "scripting" is really a
fuzzy endeavour](http://www.perl.com/pub/a/2007/12/06/soto-11.html) —
much like talking, or thinking. This is why Perl scripts, and by
extension all computer programs, have so few bugs.

But if you can psychologically overcome all of that — perhaps with the
aid of some sort of nuclear-powered ninja weaponry — Perl's not *that*
bad. Unlike [C++](#c), it has garbage collection. It has
anonymous function closures (unlike [PHP](#php),)
and they can consist of more than one expression (unlike [Python](#python).) And
things like `use strict` at least smell like an attempt to approach some
sort of trying to permit, I don't know, enforcing discipline, or
something, if you think that would help.

### PHP

PHP is language defined by a tool built by some guys who saw a
[Perl](#perl) interpreter once and thought it was really neat. They
thought that it would just *rock* to make a similar tool that lived in a
webserver and whose default operation was `print`.

> "One of the most interesting aspects [of PHP version 2] included the
> way `while` loops were implemented. The hand-crafted lexical scanner
> would go through the script and when it hit the `while` keyword it
> would remember its position in the file. At the end of the loop, the
> file pointer sought back to the saved position, and the whole loop was
> reread and re-executed."
>
> — [PHP 5 Power
> Programming](http://ptgmedia.pearsoncmg.com/images/013147149X/downloads/013147149X_book.pdf)
> by Andi Gutmans, Stig Sæther Bakken, and Derick Rethans

'Nuff said, I guess.

No, no — you can *never* say enough about PHP!

I would have to say the single greatest software engineering
achievement of PHP is how it taught us all that
programming should never be done without having constantly within arm's
reach a book with a photo of the author's face on it. Preferably on the
cover, and preferably amidst the [photos of his or her 8
co-authors](https://www.amazon.com/dp/0470055200/). Even more preferably
described as a ["Cookbook"](https://www.amazon.com/dp/0672323257/), or a
collection of ["Hacks"](https://www.amazon.com/dp/0596101392/) — hey, if
it didn't save me from having to understand what I'm doing, I wouldn't
have spent the \$30 on it.

However, this is not to diminish the other great advance that PHP has
brought us. Truly, the shortest path from point A to point B is to slap
some B-coloured paint onto point A and put up a sign next to it saying
"Welcome to Point B, Population: You!" And does not PHP help us achieve
such a software development style — so *effective*, so *powerful*, so
downright worthy of this maxim?

**Fatal error**: require\_once() [[function.require](function.require)]:
Failed opening required 'config.php'
(include\_path='.:/usr/local/share/pear') in
**/internal/directory/structure/home/website/include/oh\_drat.php** on
line **444**

### Python

Mostly harmless.

Hah, I say that and it makes it sound like I *like* Python.  That can't
be right.  All languages are crap.  I'm a language designer — why else
would I be a language designer if it were not for the fact that all
languages are crap?

But I am weary.  I urge you to consider that Python may be pretty on
the surface, but go on, scratch that surface.  See what you find.  Tell
me if it's pretty.  Go on, do it.

Here, I'll get you started.

    >>> a = 200
    >>> b = 200
    >>> c = 300
    >>> d = 300
    >>> a is b
    True
    >>> c is d
    False
    >>> 300 is 300
    True

But wait, there's more!

    >>> True = 4
    >>> True
    4
    >>> 4 == True
    True

### R

[R IS THE LANGUAGE OF THE FUTURE](https://www.r-bloggers.com/revolutions-chief-scientist-r-is-the-language-of-the-future/).

WHY, IT'S SO FUTURE, IT EVEN HAS AN ISBN: 3-900051-07-0

No seriously, to cite R in a research paper you're supposed to type `citation()` within R,
and [that ISBN is what it responds with](https://www.software.ac.uk/blog/2016-09-30-oh-research-software-how-shalt-i-cite-thee).

### Scheme

Scheme is often looked at historically, and described as a variant of
[Lisp](#lisp). While useful, this historical viewpoint frequently gets in the way
of thinking about Scheme's significance *today*. In brief, if you are
evaluating Scheme for your own needs, evaluate *Scheme*, and don't worry
about Lisp or functional programming.

That said, let's go ahead and examine Scheme historically. Its history
has been one of shedding baggage from its Lisp heritage: it has lexical
(instead of dynamic) scoping, guaranteed (rather than
if-your-vendor-supports-it) tail-recursive behaviour at execution time,
hygenic (instead of textual) macros, and continuations as first-class
objects. These are generally considered significant improvements, and we
fully agree.

But there's one thing of Lisp's that Scheme hasn't shed: its syntax...
or lack thereof!

Whether you love it or hate it, you have to admit that Scheme's
S-expression syntax is extremely — no, *pathologically* — regular. Just
about as orthogonal as syntax can get.

As far as we know, the reason Lisp has such a mind-bogglingly minimal
syntax is that it's a consequence of how it approached higher-order
functions: *represent functions as lists*. You can already pass lists to
and return lists from functions, so if functions "are" lists, then
problem solved, right? And there's no sense having two different
syntaxes for the same kind of data.

But that didn't turn out too happily, and times have changed. In Scheme,
function values are *not* lists: they're closures. This
is overall a nice thing — it avoids the ugliness of trying to determine
which list is the "right" representation, and allows free variables to
be captured in function values instead using the crutch of dynamic
binding.

But that syntax is still there, like some kind of vestigial organ. What
purpose does it serve now?

Well, the interesting thing about it is that it makes it impossible to
syntactically distinguish between code and data. Depending on the
circumstance, this can be a horror or a delight.

Here's the horror: say you're looking at a snippet of a Scheme program.
You can't tell what `(+ 1 2)` is supposed to be — code, or data? —
without looking at what context it's in. This can be as confusing as all
git-out. (And don't get me started on `quasiquote`.)

Here's the delight: it makes it trivial to read and write Scheme
programs from other Scheme programs. No parsing, no backpatching. No
blood, sweat, *or* tears. In fact, we wonder why this holdover from Lisp
has not driven Scheme on to become *the* program-analysis language.
