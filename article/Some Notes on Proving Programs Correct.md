Some Notes on Proving Programs Correct
======================================

*   status: under construction

There's a certain confusion I sometimes see in software
developers when the topic of program proving comes up.

Maybe you start talking about showing that some algorithm
is correct, or proving that some program is safe.  They
respond in a way where it's apparent (after, perhaps,
some laboured clarification) that they're taking this to
mean that the program can somehow be correct, or safe, in
some _absolute_ sense — as if you could take all the
programs in the universe and divide them objectively into
two buckets, one containing all the correct programs, and
the other containing all the incorrect programs.

But this isn't the case at all.  In order to have a proof
that a program is correct, you first need to have a
definition of "correct".  You have to say what it means when you
declare, "This program is correct, but this other one isn't."

There is, in fact, no single definition of "correct"
(or "safe").

To put it another way, you can only really ever prove that a
program has a certain property or properties, and "correct"
is just a shorthand for a bundle of properties that a program
must have if it can be said to fulfill its requirements.

When no requirements are given, literally every program
is correct.  "Vacuously correct", you might say.
[(Footnote 1)](#footnote-1)

But typically, some requirements are imposed, and further,
all too often many of those requirements are tacit — everyone
involved assumes them, and no one discusses them.  And perhaps
it's this that leads some people to believe that a program can be
"correct" in some abstract, absolute sense.

At any rate, I think it's useful, in these situations,
to just forget about words like "correct" or "safe",
and concentrate on the specific properties of the program
that you want to prove:

*   Does it always terminate, in a finite number of steps,
    on all inputs?
*   Does it ever terminate prematurely, on any input?
*   Does it ever perform an operation, the result of which
    is not defined?
*   Does it ever write to a memory location outside a
    certain fixed set of memory locations?

...and so forth.

A particular kind of property that is worth mentioning, both because
it is hard to avoid using the word "correct" when stating it, and
because the implications of proving it can be a little disconcerting,
are properties like:

*   Does the program correctly compute the factorial function?

It can be disconcerting because, in order to show
that a program computes factorial, you have to have a
definition of what it means to compute factorial in the
first place.

But how do you know you have the right definition?  You don't.

Further, a proof like this often has a form where it shows,
step by step, that the program computes just what the definition
defines.  It looks very similar to a proof that two programs
compute the same thing.  And that can be very unsatisfying
if you were expecting it to tell you something about the
result or what it means.

To conclude, let's revisit the bucket metaphor above, but
instead of programs, consider the following objects: pairs
consisting of a program and a set of requirements.  Call these
objects _specified programs_.  Now, you _can_, in principle, divide
these objects into two buckets: the specified programs that meet
their specification, and the specified programs that don't.

Footnotes
---------

##### Footnote 1

There's a similar situation with generative art.  If you're coding
a generator but you make a mistake and the result is unexpectedly
more pleasing than what you originally intended it to do, is it
really fair to call that a "bug"?
