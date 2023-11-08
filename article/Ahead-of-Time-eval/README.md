Ahead-of-Time `eval`
====================

**Aggressive Constant Folding + `eval` = Hygienic Macros**

Motivation
----------

I started writing this because it seemed to me that I had never
seen a hygienic macro system that wasn't _ad hoc_ and
convoluted in some way (just my opinion, of course!) and I wanted to
present one that is — I can only hope — coherent and conceptually
simple instead, as a sort of counter-example: a testament to the
fact that it isn't impossible to have such a design.

This is a write-up only, and contains no code.  If you prefer to
see code, many of the ideas in this article are implemented in
the toy language [Durito][].

Background
----------

The definition of the Scheme programming language includes
a rule that essentially says

> If a procedure call can be replaced with a tail call without
> changing the meaning of the expression, it *must* be
> replaced with a tail cail.

In the Scheme report, this is called "proper tail recursion"
[[Footnote 1]](#footnote-1) and it is somewhat unusual,
as language implementation requirements go, in that it is an
operational rule rather than a semantic one; it
doesn't affect the result that the procedure computes, instead
it constrains the method by which the result is to be computed.

I mention this rule because in this article I would like to
consider a rule with a similarly operational character, which is:

> If the value of an expression can be computed ahead of time
> without changing the meaning of the expression, it *must*
> be computed ahead of time.

Since this is a kind of constant folding [[Footnote 2]](#footnote-2),
we could follow the example of "proper tail recursion" and call this
"proper constant folding"; however, that phrasing doesn't quite fit
here for a number of reasons, so instead, we will
call this _aggressive constant folding_ [[Footnote 3]](#footnote-3).

In this article, I'd like to demonstrate that the combination of
aggressive constant folding together with a reflective evaluation facility
(conventionally called `eval`) provides an alternative to a dedicated macro
system which is both conceptually simple and hygienic, and has a number of
other benefits.

For the purpose of this demonstration, we'll assume we have a
functional programming language, based on Scheme but presumably much simpler,
that has these two features, and we'll write our example code snippets in it.

Aggressive constant folding
---------------------------

Let's begin by defining "aggressive constant folding" more rigorously.

Literals such as `1` and `"Hello, world!"` are constants.
A literal function, that is, a lambda expression
such as `(lambda (x) (* x x))`, is also a constant.
Built-in functions, such as the function represented by `*`,
are also constants.

If `f` is a constant function and `a1`, `a2`, ... `an` are constants,
then the function application `(f a1 a2 ... an)` can be
computed ahead of time, assuming the following things about f:

*   `f` is _referentially transparent_, i.e. the result of
    evaluating `f` depends only the values of `a1`, `a2`, ... `an`,
    and this evaluation does not cause any side-effects; and
*   `f` is _always terminating_, i.e. evaluating `f` always
    returns a result after a finite time, for any choice of
    arguments passed to `f`.

Now, _how_ we determine whether `f` is referentially transparent and always
terminating is an altogether different matter; but it is one that is orthogonal
to the main point of this article [[Footnote 4]](#footnote-4).
For our demonstrations, we'll simply assume that all the functions we're
working with are both referentially transparent and always terminating.

There is a third constraint:

*   All names used inside the definition of `f`, apart from the formal
    arguments of `f`, are bound to constants.

This third constraint is particularly relevant if `f` uses names
that are defined in an outer scope, for example the formal arguments
of the function inside which `f` is defined.

Now, if `(f a1 a2 ... a2)` can be computed ahead of time, we do so,
then replace it (either conceptually or concretely) with the
constant value we obtained by doing so.

Once replaced, we repeat this process, in the manner of a transitive
closure algorithm, until we can find no more function applications
that can be replaced by constants [[Footnote 5]](#footnote-5).

That is the basic idea.

There are a few more details we could mention:

When analyzing an expression that contains a name, we must have some
way of telling if we know that it is bound to a constant or not,
in order to determine if the expression is constant.  Typically
some kind of environment structure mapping names to values
would be maintained during analysis.  When a name is discovered
to refer to a constant, that name-value pair is added to this
map.  If a name is not present in the map, we must err on
the side of safety and assume it does not represent a constant.

The propagation of constanthood will typically occur in some
language constructs that aren't function applications, as well.
For example, in an `(if x t f)` expression, `x` may be a constant;
if `x` is a "truthy" constant then the entire expression reduces
to `t`, otherwise it reduces to `f`.

`quote` and `eval`
------------------

To demonstrate our point about hygienic macros, the language
will need an `eval` facility, and in order to employ that facility
in a reasonable way, it will need a way to represent program texts
as expressible values in the language.

For concreteness we will call such values "quoted forms".

We've already stated our language here is similar to Scheme, and
the standard way to represent quoted forms in Scheme is as list
structures, using the `quote` construct to express literal
(and thus constant) quoted forms in expressions.

Meanwhile, `eval` is a built-in function that takes a quoted form
and an environment, and evaluates to the value that that form,
were it unquoted, would evaluate to in that environment.  Again,
this is very similar to Schemes's `eval`; the main difference
is that we use a slightly more nuanced conception of
"environment" (see below).

We note also that `eval`, being a built-in function, is itself a constant.
An application of `eval` is not essentially different from any other
function application, so, for example, by the rules of aggressive
constant folding,

    (eval (quote (* 2 2)) std-env)

is a constant (the constant value `4`) — under the assumption
that `std-env` is a value representing an environment (presumably
the "standard" environment) in which the symbol `*` is bound to a suitable
integer multiplication function.

Macros
------

### Kinds of Macros

Before launching into how all this relates to hygienic macros,
it might be good to have an overview of the common use cases of macros.

I submit that there are three major purposes for which macros are used:
_circumspection_, _optimization_, and _ergonomics_.

**Circumspection** — which we might call "conditional compilation" if
we were restricting ourselves to compilers, which we're not — means
omitting code that we don't strictly need, in the version of the
program that executes.  So for example, if one of our customer agreements
stipulates they do not have access to some special feature of our product,
we leave out that feature in the build we supply to that customer
[[Footnote 6]](#footnote-6).  Or, if we build a program without debugging,
we leave out the debug logging function and all the calls to it too.

Happily, aggressive constant folding _by itself_ gives us circumspection
"for free".  Instead of `#ifdef DEBUG`, for instance, we simply define
`debug` as a function that returns a constant and use plain `if` tests on it;
we have a strong guarantee that this will all have been accounted for ahead
of time, and it will not appear in the code or impose any cost at runtime.

**Optimization**, where it is not already accomplished by circumspection
(less stuff in program = less work to do), usually consists of arranging
instructions in a particular way so that their pattern of execution is
closer to optimal.  For example, array striding, vectorization, and loop
unrolling are optimizations to achieve better cache- and processor-level
behaviour when executing vector or matrix based code, and these can be
implemented with macros.

However, Ahead-of-Time `eval` as we've described it
requires that the functions involved are referentially transparent.
And part of the point of raise the abstraction level of the program
with "pure" functional programming like this, is to allow the compiler to
be able to select and make these kinds of optimizations itself, rather than
leaving it up to the programmer to address these with explicit handiwork.

So I'm happy to concede that Ahead-of-Time `eval` is not really suited to
writing macros for optimization tasks, and won't worry too much about it.

**Ergonomics** is where Ahead-of-Time `eval` can really focus.  An
ergonomic macro is one designed to improve the usability of the
language itself in some way; for example, defining a `case` statement
in a language that only supports `if` statements, by translating
the `case` to a sequence of `if`s.  This idea of improving the
constructs of the language from within can be taken quite far, to
the point of creating entire embedded domain-specific languages (EDSLs).

In this setting, a macro is nothing more than _a function that_
_takes syntax to syntax_.  Given some syntax as input, it reduces that
to a (presumably different) syntactic form, before program execution
begins.

Since quoted forms represent syntax, this matches exactly what
Ahead-of-Time `eval` will do to referentially-transparent,
always-terminating functions that are passed constant quoted forms:
reduce them, ahead of time, to other constant quoted forms.

Such "macros" also happen to "gracefully degrade" back into functions;
if not all actual arguments are constants, the function will not be applied
until the values of the non-constant arguments are known, i.e. at runtime.

There is a subtlety when using Ahead-of-Time `eval` to form an ergonomic
macro, however.  (At least, I must assume it's a subtlety as it took me
a while to figure it out; I wasn't clearly seperating circumscription
macros from ergonomic macros in my head.)  Some of the arguments to the
"macro", the syntax parts, are constant and translated ahead of time; while
other arguments (such as the expression in the `case` statement example
above) are not known until runtime.  It would be a mistake to treat
those arguments as things that we can compute ahead of time.

The resolution to this is to have the function that takes syntax as
input, produce as its output a function which takes arguments.
It is those arguments that are the runtime arguments of the macro.

### Example of Ergonomic Macro

As an example, if we were to try to define a Perl-like `unless` form
in our putative Scheme-like language, we might have

    (define unless (qa qb)
      (eval
        `(lambda (x) (if (not x) ,qa ,qb))
        std-env))

(Here we are using quasiquoting for succinctness.)  This macro would
be applied like so:

    ((unless '(do-one-thing 123) '(do-something-else 456)) (> c 0.5))

The two argument to `unless` are syntax for the branches that are
incorporated, ahead of time, into the `if` statement in the function.
The `(> c 0)` expression is not evaluated until runtime, and the
result of evaluating it is passed to the function.

This simple version only works if we are content to have our true
and false branches be computable ahead of time, which probably isn't
very useful in practice.  If we want them to have components that
aren't known until runtime, we need to treat them as functions, too.

`unless` is perhaps too simple to make a good demonstration of
this, so let's fancy it up a tiny bit, even at the cost of it looking
a bit contrived.  Let's make a macro called `if-greater` that selects
the first branch if the test value is greater than a constant threshold,
and the second branch otherwise.

    (define if-greater (threshold)
      (eval
        `(lambda (x fa fb) (if (> x ,threshold) (fa) (fb)))
        std-env))

And then the usage would be something like

    (let ((x something-known-only-at-runtime)
          (y something-else-known-only-at-runtime))
      ((if-greater 0.5) c
        (lambda () (do-one-thing x))
        (lambda () (do-some-other-thing y))))

where `x` and `y` aren't known until runtime.

Note that even though `x` was used in the definition of the
macro, there is no danger mentioning `x` in the first branch;
it has already been bound to `something-known-only-at-runtime`.

There is of course nothing stopping a language from supporting
language constructs to hide some of this complexity in the name
of making macro definition and usage less awkward.  But we need to
reveal it here in order to show how the mechanism works.

### Hygiene

The manipulation of syntax by functions that take syntax to syntax as we've
done here is naturally hygienic.  This is because the environment passed
to `eval` is explicitly given, and only the bindings in that environment
will be used during the evaluation of `eval`.  Supplying only a standard
environment, which does not contain any bindings specific to the active
program, makes it impossible to capture a program binding during the
evaluation of `eval`.

It also makes it possible to strategically subvert hygiene, either by
manipulating the environment that is passed in so that it no longer resembles
the "standard" one, or by manipulating the quoted form and replacing referents
with other values.

Runtime values for ergonomic macros, meanwhile, are passed in as arguments to
formed functions.  The formed function does have formal arguments, and the
possibility of using a name that collides with the name of a formal argument
does still exist; but there appear to be mitigating factors when doing things
this way.  Namely, the runtime values are always passed as arguments, and thus
referred to by the formal name of the argument, which will shadow any pre-
existing bindings for that name; and if a function does happen to refer to
bindings that aren't known ahead of time, it won't be computed ahead of time
itself.  So if the language supports some way of annotating what is expected
to be computed ahead of time, it could, e.g., warn the user that such a
collision has occurred.

Now, the statements in the above few paragraphs aren't untrue, but they're
perhaps somewhat underwhelming.  To get into why that is though, I think we
need to examine the assumptions more closely.  What makes a macro "hygienic"
anyway?

I would submit that a programmer perceives a macro as _un_-hygienic when
the names used in the macro become bind to values that they did not
expect them to become bind to, almost always resulting an unpleasant surprise.

In other words, hygiene is relative to the programmer's expectations, and the
particular expectations are set up by what the particular programming language
provides in regards to scope and binding.

This problem becomes even more pervasive when you consider that advanced macros
can implement _their own_ rules for scope and bindings, thus setting up new
hygiene expectations of their own, over and above what the programming language
itself sets up.

So it would seem that there is really no escaping the relativity of hygiene.

In the most general case, what macro authors need is control over the bindings
used in the evaluation of the body of a macro, and tools to examine the
bindings in effect at the points in the program where the macro is used.  Such
tools are out of scope of this write-up, as the possibilities are vast and
they don't really affect the core idea of Ahead-of-Time `eval` one way or the
other; but the other core need, control over the bindings during evaluation,
has been granted.

### "But `eval` is evil!"

The reputation `eval` has in some circles is not a positive one, and this
reputation is not wholly undeserved.  But this reputation is attached to using
`eval` _at runtime_.  The core ideas of Ahead-of-Time `eval` only necessitate
using `eval` _ahead of time_.  It would in fact be quite possible to couple it
with _forbidding_ runtime `eval`: at some point after the aggressive constant
folding pass, look for any remaining instances of `eval` in the program, and
raise an error if any are found.

Related Work
------------

I have no idea how novel this is; the basic mechanism is so simple that I
can hardly expect that no one has ever thought of it before; yet I haven't
come across this arrangement of things before either.

Clearly it is related to constant folding; but constant folding is often
considered only as a compiler optimization, and not something that is
specified by the language.

Clearly it is also related to partial evaluation; but partial evaluation
usually goes much further.  Partial evaluation generally aims at statically
generating a new function when *any* of its arguments are constant; while
aggressive constant folding only reduces the function to a constant when *all*
of its arguments are constant.

Clearly it is also related to staged computation.  It is a kind of strategy
for computation that moves as much computation as it can to an earlier
"precomputation" stage.  However, this does not seem to be the concern that
staged computation usually aims to address; discussions of the concept seem
to centre around compilation and generating executable code at runtime
[[Footnote 7]](#footnote-7).  But Ahead-of-Time `eval` happens ahead of time
only, and need not involve compiling.

Clearly it is also related to hygienic macros, but I refer back to my opinion
at the beginning of the article.  Hygienic macro systems almost always seem
to start with conventional (unhygienic) macros and then patch them up so that
they're hygienic.  Ahead-of-Time `eval` seems to approach the entire problem
from a different angle, obviating the very need for macros in some instances.

It also seems to be related to evaluation techniques for functional languages,
although my impression is that much of the existing work there is to support
more performant ways of implementing lazy languages.  Ahead-of-Time `eval` can
perform optimization in much the same way macros do, and in much the same
way memoization does, by computing a result once and using it many times
instead of recomputing it each time.  But, like macros, it is not restricted
to memoization.

- - - -

#### Footnote 1

See, for example, section 3.5 of the
[Revised^5 Report on the Algorithmic Language Scheme](https://schemers.org/Documents/Standards/R5RS/).

#### Footnote 2

For more background on constant folding, see, for example, the
[Wikipedia article on Constant folding](https://en.wikipedia.org/wiki/Constant_folding),
though note that the Wikipedia article focuses on it as a compiler optimization,
rather than as a language specification rule as we're doing here.

#### Footnote 3

We also avoid the phrase "compile-time" as it is technically inaccurate, as we might
never actually compile the given code; instead we say "ahead of time".

#### Footnote 4

There are several approaches that can be taken.  The language can be designed to only
be capable of expressing such functions; the properties can be specified as part
of a type system; we can use static analysis to conservatively infer these
properties; or we can simply assume that any function that is not
referentially transparent and always terminating will be marked as such by the
programmer and that any incorrect marking is a bug just like any other bug.

#### Footnote 5

In most languages we ought to be able to proceed, for the most part, in a bottom-up
fashion: when we have reduced a function application to a constant, consider whether
the function application containing this new constant, is itself constant, and so
on.  But we should take care with where names are used; if an expression that a
name is bound to is reduced to a constant, all the sites where that name is referenced
should also be checked to see if those sites can now be reduced to constants.

#### Footnote 6

Never mind how terribly antiquated delivering software directly to an individual
customer sounds in this modern, Cloud-polluted world of ours.  Actually, it still
does happen in some of the more arid corners of the industry.

#### Footnote 7

See, for example, the answers to the question
[What are staged functions (conceptually)?](https://cs.stackexchange.com/questions/2869)
on the Computer Science StackExchange.

[Durito]: https://github.com/cpressey/Durito
