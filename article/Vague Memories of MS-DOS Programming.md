Vague Memories of MS-DOS Programming
====================================

*draft, still*

So you want to program something in MS-DOS for some reason.  I
totally support this sort of endeavour!  It is a totally worthwhile
thing to try.  However, there are parts of it that can be a real
PITA.

This document attempts to collate my vague memories of my scant
experience programming things in DOS, to shed light on those parts.

Development Tools
-----------------

Borland tools are highly recommended; Borland C++, Turbo Pascal,
and Turbo Assembler especially.  [DGJPP][] and [nasm][] (or [yasm][])
are also highly recommended, and more modern.

You don't need to know x86 machine code, but because DOS isn't
much of an operating system, it helps to be comfortable with
thinking about low-level behaviour of the machine.

[DJGPP]: http://www.delorie.com/djgpp/
[nasm]: http://www.nasm.us/
[yasm]: http://yasm.tortall.net/

Interrupts
----------

OK, so when you write a program in DOS, you actually have a choice:
you can use DOS for what you want to do, or you can totally bypass
DOS and use the underlying BIOS instead.

If you go straight to the BIOS, DOS won't try to stop you; at
worst, you might leave DOS a little confused about the state of
things.  You will lose the advantages that DOS gives you, like being
able to redirect output to a file, talking to hardware in a more
abstract way via a driver, etc.  But those advantages aren't
terribly great, especially for games, and especially in the modern
era, where your code will almost certainly be running on [DOSBox][],
or [FreeDOS][] under [QEMU][], or [v86][], instead of on a real
machine where you need to worry about what kind of soundcard the
user has.

And if you only use the BIOS and never DOS itself, your program
can run without DOS.  That's right, you can just put your program
on a boot disk and boot right into it and not worry about DOS at all.

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
you will need to know, buf if you're using some other programming
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

The 286 and earlier models support what's called "real mode", which
is this terrible thing where 32 bits are used to address a byte in
memory, but it's actually a pair of 16-bit numbers, and the middle
4 bits overlap, so it's really only 20 bits of address space.

There is a reason for this, and I bet it dates back to CP/M days,
and I bet it's that this allows you to relocate a program in
memory in a fine-grained(ish) way simply by changing the segment
pointers.

But it's just horrible for normal use, and leads to things like
the Borland languages supporting `near` and `far` pointers to
memory which you can't interchange without various machinations.

If you must stay in "real mode" my recommendation would be to stick
with the "tiny" memory model, where the data and code segment are
the same and they never change and your program is a `.COM` file
and you have the extra fun of trying to fit everything you need
into 64K.  If you must have more, you can upgrade to the "small"
model where the segments still don't change, but now they are
disjoint.  But that's as far as it should go.  Once you get into
the "large" and "huge" models, you will lose hope, and instead
you should look into getting out of "real mode".

The best alternative to "real mode" is "protected mode", which
gives you simply 32-bit addressing, at the price of having to
start a DPMI (DOS Protected Mode Interface) driver first.
DGJPP targets this mode and comes with a DPMI driver.

But the best alternative isn't necessarily the most entertaining.
There is also something called "unreal mode" that I've wanted
to try for a long time, which is basically a "glitch" mode in
between "real" and "protected" modes.

There are also EMS and XMS memory, but those are possibly best
left to the imagination.

By the way, 20 bits of address space is 1024K, which is enough
to address 640K of main memory plus 384K of graphics memory,
and as we all know, 640K ought to be enough for anybody...

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
`B800h` and address individual bytes with `si` or `di`.

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
address individual bytes with `si` or `di`.

[VGA-compatible text mode]: https://en.wikipedia.org/wiki/VGA-compatible_text_mode
