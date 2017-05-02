Blurry Memories of DOS Programming
==================================

*   status: draft

So, for whatever reason, you want to program something in DOS —
that is to say, MS-DOS or one of its clones.  I totally support
this sort of endeavour!  It is a totally worthwhile thing to try
your hand at.  It can give you a sense of historical perspective,
or simply be a change from the everyday.

And it might even be a reasonable (in some sense) platform for
building and distributing certain kinds of software, like games,
since you lots of options for emulating DOS on all manner of
modern devices: [DOSBox][], or [FreeDOS][] under [QEMU][], or
[v86][], just to name three.

Now, I don't have tons of experience programming for DOS —
mainly writing [Shelta][] and [ILLGOL][] and [BefOS][], along
with a few games (all attempts at which were abandoned).

But I do recall, pretty clearly, that there are several parts of
DOS programming that can be a real PITA.

So this document attempts to collate my blurry memories of my scant
experience programming things in DOS, to shed light on those parts.

[Shelta]: http://catseye.tc/node/Shelta
[ILLGOL]: http://catseye.tc/node/ILLGOL
[BefOS]: http://catseye.tc/node/BefOS

Development Tools
-----------------

Borland tools are highly recommended; Borland C++, Turbo Pascal,
and Turbo Assembler especially.  [DJGPP][] and [nasm][] (or [yasm][])
are also highly recommended, and more modern.

You don't need to know x86 machine code, but because DOS isn't
much of an operating system, it helps to be comfortable with
thinking about low-level behaviour of the machine.

Since you're almost certainly going to be running the resulting
program in an emulator, you could even consider writing in
BASIC.  You can crank the emulator up to an unreasonable speed
on a modern machine to compensate for any performance problems
that come from BASIC being an interpreted language.

Or if you're doing this for laughs, you could write your code in
[ILLGOL][].  Or if you prefer a minimalist approach, you could
use [Shelta][].  (Or [colorForth][]!)

[DJGPP]: http://www.delorie.com/djgpp/
[nasm]: http://www.nasm.us/
[yasm]: http://yasm.tortall.net/
[colorForth]: https://en.wikipedia.org/wiki/ColorForth

Interrupts
----------

OK, so when you write a program in DOS, you actually have a choice:
you can use DOS for what you want to do, or you can totally bypass
DOS and use the underlying BIOS instead.

(This is what I was getting at when I said "DOS isn't much of an
operating system", above.)

If you go straight to the BIOS, DOS won't try to stop you; at
worst, you might leave DOS a little confused about the state of
things.  You will lose the advantages that DOS gives you, like being
able to redirect output to a file, talking to hardware in a more
abstract way via a driver, etc.  But those advantages aren't
terribly great, especially for games, and especially in the modern
era, where your code will almost certainly be running on an
emulator instead of on a real machine where you need to worry about
things like what kind of soundcard the user has.

And if you only use the BIOS and never DOS itself, your program
can run without DOS.  That's right, you can just put your program
on a boot disk and boot right into it and not worry about DOS at all.
Some actual "DOS" games did this.

But if you want to do things like load and save files, then using
DOS will be much easier than e.g. writing your own filesystem routines.
And if you're using a language other than assembler, your compiler
might insert code which uses DOS anyway and would be a bother to work
around.

In either case, under the hood, everything you do with the system
will be done by invoking an interrupt.  This is, if you ask me,
backwards.  A program should *respond* to interrupts, not *cause* them.
But this is how they built this architecture, so who am I to complain.
I think of them as system calls.

`int 21h` is a "system call" to DOS.  The "system calls"
to the BIOS include `int 10h`, but there are also other numbers.
(The trailing `h` is convention for "hexadecimal", although you may
be more used to a preceding `0x`.)

If you want to get serious about this, consult a document called
[Ralf Brown's Interrupt List][].  It lists probably every interrupt
you will ever care about, and describes each of them briefly
(although not always in much detail).

Again, this is something that, if you are programming in assembler,
you will need to know, but if you're using some higher-level programming
language, chances are there will be standard or 3rd-party libraries
that will wrap calling these interrupts.

One such 3rd party library is [Allegro][], which, until version 4.2,
supported DOS.

[DOSBox]: https://www.dosbox.com/
[FreeDOS]: http://www.freedos.org/
[QEMU]: http://www.qemu-project.org/
[v86]: https://github.com/copy/v86
[Ralf Brown's Interrupt List]: http://www.cs.cmu.edu/~ralf/files.html
[Allegro]: http://liballeg.org/

Addressing Memory
-----------------

For addressing memory, the 80286 and earlier models support only
a mode called "real mode", which is this terrible thing where 32
bits are used to address a byte location in memory, but it's
actually a pair of 16-bit numbers call the "segment" and the
"offset", but all but the topmost 4 bits of the segment overlap
bits in the offset, so it's really only 20 bits of address space.

There is a reason for this, and I bet it dates back to CP/M days,
and I bet it's that this allows you to relocate a program in
memory in a fine-grained(ish) way simply by changing the segment
(but leaving the offsets, hardcoded in the program, the same).

But it's just horrible for normal use, and leads to things like
the Borland languages supporting `near` and `far` pointers to
memory which you can't interchange without various machinations.

If you must stay in "real mode" my recommendation would be to stick
with the "tiny" memory model, where the data and code segment are
the same and they never change and your program is a `.COM` file
and you have the extra fun of trying to fit everything you need
into 64K.  If you must have more, you can upgrade to the "small"
model where the segments still don't change, but now they are
disjoint, so you have 64K for your code and 64K for your data.

But that's as far as it should go.  Once you get into
the "large" and "huge" models, you will lose hope, and instead
you should look into getting out of "real mode".

The sanest alternative to "real mode" is "protected mode", which
gives you a nice and simple flat 32-bit address space, at the
small, small price of having to run on a 80386 or later model,
and start something called a DPMI ([DOS Protected Mode Interface][])
driver first.  DJGPP targets this mode and comes with a DPMI driver
called [CWSDPMI][].

But the sanest alternative isn't necessarily the most entertaining.
There is also something called "unreal mode" that I've wanted
to try for a long time, which is basically a "glitch" mode in
between "real" and "protected" modes.  TODO: link to an article
about it here.

There are also EMS and XMS memory, but those are possibly best
left to the imagination at this point.  (I tried working with them
once, in [BefOS][], but I gave up, because IIRC you need to page
data into and out of them, and for that you need a paging system,
and memory management systems are often a bit subtle, by which I
mean annoying, to design and implement.)

By the way, 20 bits of address space is 1024K, which was split
up into 640K of main memory plus 384K of graphics memory.  The
640K there is the same 640K that was made famous by the phrase
"640K ought to be enough for anybody."

[DOS Protected Mode Interface]: https://en.wikipedia.org/wiki/DOS_Protected_Mode_Interface
[CWSDPMI]: https://en.wikipedia.org/wiki/CWSDPMI

Text and Graphics
-----------------

At this point in history you can safely assume the machine has
VGA — i.e. that the emulator knows how to support it.  You don't
have to fiddle with CGA and EGA unless you really, *really* want to.

VGA provides various modes, both text and graphic.

The "standard" text mode is probably 80-column-by-25-row 16-colour
text.  16 colours doesn't always mean 16 colours; sometimes the
"brightness" bit is interpreted to mean "blinking" instead.
There's a Wikipedia article about it: [VGA-compatible text mode][].

This is the mode that the computer generally already is in,
but to switch to it (from e.g. a graphics mode),
set `AH=0h` and `AL=03h` and call `int 10h`.

If you want to output text via DOS, the controls codes will
cause things to happen, but if you write directly to the screen
memory, you get the entire IBM OEM font, including the happy faces
and whatnot.

The screen memory for this mode starts at `B8000h` (the uppermost-
leftmost character) and extends 80 * 25 = 2000 bytes beyond that.
It's probably easiest to set the extended segment pointer `es` to
`B800h` and address individual bytes with `es:si` or `es:di`.

There are two bytes for every character; the high byte is the attribute
byte, which contains the foreground and background colours, and
the low byte is the character code, which matches ASCII but of
course goes beyond just ASCII.

There are other text configurations, like black-and-white,
40 (or 132?) columns, 50 rows... but these are left as exercises
for the interested reader.

The simplest graphic mode by far is 320x200x256 because the video
RAM is just a 2D array of bytes and every pixel is one byte.

To switch into this mode, set `AH=0h` and `AL=13h` and call `int 10h`.

Screen memory starts at `A0000h` (the uppermost-leftmost pixel)
and extends 320 * 200 = 64000 bytes beyond that.  It's probably
easiest to set the extended segment pointer `es` to `A000h` and
address individual bytes with `es:si` or `es:di`.

There is also the fact that if you want smooth animation, you should
wait for the vertical retrace period (a.k.a. the vertical blanking
interval) before making changes to screen memory, as discussed in
[A Basic Theory of Video Games][].

I don't actually remember how to do this on an IBM PC, if I ever knew,
but I do remember that [Allegro][] has a function for it called
`vsync()`.  If this function was all you wanted from Allegro, you
would still be justified in using it, IMO.

[VGA-compatible text mode]: https://en.wikipedia.org/wiki/VGA-compatible_text_mode
[A Basic Theory of Video Games]: A%20Basic%20Theory%20of%20Video%20Games.md

Keyboard Input
--------------

DOS will let you read text from "standard input", even when that
input is coming from a console, but that will be line-buffered,
i.e. the user will need to press Enter before the program sees
any of it, which is fine for text adventures and the like, but
not really sufficient for video games.

I don't think DOS has a way to check if input is available and
only consume it if it is available, but I might be misremembering.

But the BIOS certainly can do this.

To wait for a key to be pressed, set `AH=0h` and `int 16h`.
To check if a key is pressed or not, set `AH=01h` instead,
then check the `Z` flag afterward.  For both calls,
the ASCII value will be available in `AL` afterward, and
the raw scan code will be available in `AH`.

Here is a really comprehensive list of [Keyboard scancodes][].

If you also want to see if any of the modifier keys (Shift,
Ctrl, etc,) are being pressed, set `AH=02h` and `int 16h`.
I'd describe the result but this is getting outside the scope
of this article; consult Ralf Brown's Interrupt List, or
simply do a web search for `int 16h`, for more information.

[Keyboard scancodes]: http://www.win.tue.nl/~aeb/linux/kbd/scancodes.html

Sound
-----

I never played much with sound on the IBM PC architecture.  It's
probably reasonable to assume that any given emulator supports at
least the SoundBlaster 16.  It's probably even OK to assume that
the SB16 lives at a certain interrupt and DMA address, since those
can be configured on the emulator side now (instead of asking you
with one of those horrible `SETUP.EXE` menus!)

But I don't actually know anything about talking to an SB16.
But I would be really surprised if there wasn't information about
it somewhere on the internet.

Failing the SB16, you could, if your really wanted to, drive the
internal speaker, and the emulator, if it is worth its salt, should
support that.  However, I'm not sure there are many listeners who
would appreciate it greatly.  In fact, many would probably
appreciate if you *didn't* make the internal speaker make any sounds...
