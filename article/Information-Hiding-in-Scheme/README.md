Information Hiding in Scheme
============================

Say you wanted to implement an [abstract data type (Wikipedia)][]
in [R5RS Scheme][].  How would you do it?

_Could_ you do it?  On first blush, it might appear that you can't.
There is no module system, and the data structuring facilities that
Scheme provides are really primitive.  If you represent your data type
as a list, any client code could just take it apart with `car` and `cdr`,
and, worse, could `cons` together any other thing and pass that off
as an instance of your data type.

But there is a way.  More than one, in fact.  I'd like to describe some
of these ways in this document, starting with one that is I think is
easier to grasp, followed by one that is closer to the usual theoretical
presentation.

### 1. Using Secret Tokens

The more intuitive approach relies on two properties of Scheme:

*   Scheme _does_ have an opaque data structure: the function value.
*   `(eq? (list 1) (list 1))` is `#f`, that is, each cons-cell can
    be distinguished from every other cons-cell.

(The former would not be true if one could examine the definition of a
function value.  The latter would not be true if Scheme implemented
hash-consing.)

The basic idea is straightforward.  We define a function which we call
a _module_.  When called, the module generates a few values internally.
One of these values is a unique cons-cell which we'll call the
_secret token_ of the module.  Other values are functions, which we'll
call _operations_.

Each operation requires a token to work, and only performs its intended
function when this token matches the secret token defined by the module.

There are some restrictions on the value that the module returns to its
caller.  The value may return the operations defined by the module
(in fact the value may simply be a list of all these operations), but
the value must not contain the secret token.

Likewise, the values returned by the operations must not contain
the secret token.

(These values may be functions which have _closed over_ the secret
token.  But they should not _be_ the secret token nor _return_ it.)

In this way, clients of the module may use the operations of the module
without having to know, nor being able to alter or counterfeit, the
concrete data format that the operations work on.

#### `seal` and `open`

Because every operation follows the same pattern — pass the secret
token to a given opaque object to obtain the internal representation,
examine or modify the internal representation, then possibly create
a new opaque object — it is useful to write a pair of helper functions to
"open" and "seal" these objects using the module's secret token, and
then write all operations using these helpers.

`seal` takes some data, and returns a function which does the following:
it takes a token, and if that token matches the secret token, it returns
the data, otherwise it returns an error value.

`open` takes an opaque object, and calls it using the secret token
returning the data.  (The `open` helper "knows" the secret token
because they are both defined inside the module; the definition
of the function called `open` closes over the secret token value.)

#### Example Code

See the file [`information-hiding.scm`](information-hiding.scm) for
an example of using this technique to implement a stack ADT.

### 2. Using Closures Only

Since function values in Scheme are an opaque data type, the secret
tokens aren't actually necessary, but things do get a little more
complicated.

Actually, if you're willing for instances of your abstract data type
to be mutable, it's only a little more complicated.  Your module
function can simply generate a mutable value internally, and all of
the operation functions can close over it.  This way, they all have
it in scope, and can read it and modify it as appropriate, but their
callers can never see it.  No secret token is needed to prevent this.

In this setup, the module function can return, not a list of
operations, but a single function; and this single function can take,
as its first argument, a symbol which indicates what operation to
perform.  This resembles object-oriented method dispatch, and can
be used to implement object-oriented features such as inheritance.

See the file [`mutable-adt.scm`](mutable-adt.scm) for
an example of using this technique to implement a mutable stack ADT.

It's if you want instances of your abstract data type to be
[immutable data (Wikipedia)][] where it begins to get trickier to
think about, and this is because every operation of the ADT that
modifies the data has to return a new, immutable instance of the
ADT, and by association, all of its operations.

We can accomplish this by doing two things: sticking with the
"method dispatch" approach of having all operations implemented
by a single function that takes a symbol to choose the operation,
and defining this single function with `letrec` so that it can,
essentially, return a new version of itself when it has to.

See the file [`immutable-adt.scm`](immutable-adt.scm) for
an example of using this technique to implement a stack ADT.

[abstract data type (Wikipedia)]: https://en.wikipedia.org/wiki/Abstract_data_type
[immutable data (Wikipedia)]: https://en.wikipedia.org/wiki/Immutable_object
[R5RS Scheme]: https://schemers.org/Documents/Standards/R5RS/
