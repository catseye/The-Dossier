Vague Memories of MS-DOS Programming
====================================

So you want to program something in MS-DOS for some reason.  I
totally support this sort of endeavour!  It is a totally worthwhile
thing to try.  However, there are parts of it that can be a real
PITA.

This document attempts to collate my vague memories of my scant
experience programming things in DOS, to shed light on those parts.

Development Tools
-----------------

Borland tools are highly recommended; Borland C++, Turbo Pascal,
and Turbo Assembler especially.  DGJPP, which is more modern, is
also highly recommended.

You don't need to know x86 machine code, but because DOS isn't
much of an operating system, it helps to be comfortable with
thinking about low-level behaviour of the machine.

Interrupts
----------

OK, so when you write a program in DOS, you actually have a choice:
you can use DOS for what you want to do, or you can totally bypass
DOS and use the underlying BIOS instead.

If you go straight to the BIOS, you might leave DOS a little confused
about the state of things.  And you lose the advantages that DOS
gives you, like being able to redirect output to a file, talking to
hardware in a more abstract way via a driver, etc.

But those advantages aren't great, especially if what you want to
write is a game, and especially if it's in the modern era, where it
will more likely be run on DOSBox or QEMU, where you have control
over the (simulated) hardware.

And if you only use the BIOS and never DOS itself, you can run
without DOS.  Seriously, you could just put your program on a boot
disk and boot right into it and not worry about DOS at all.
Maybe this document should even be called "Programming the IBM PC".

But either way, everything you do with the system will be done, under
the hood, by invoking an interrupt.

This is, if you ask me, backwards.  A program should *respond* to
interrupts, not *cause* them.  But this is how they built this
architecture, so who am I to complain.  I think of them as system
calls.

`int 21h` is a "system call" to DOS.  The "system calls"
to the BIOS have a certain other numbers.

If you want to get serious about this, look up a document called
Ralf Brown's Interrupt List.

Text Mode
---------

The "standard" text mode is probably 80-column black-and-white,
but colour is also common (but sometimes "bright" is interpreted
as "flashing"), and other widths are possible (40 columns and
132 (I believe) columns.)

If you want to output via DOS, you get ASCII, but if you're OK
skipping DOS and writing directly to the screen memory, you
get the entire IBM OEM font, including the happy faces and
whatnot.

Screen memory starts at XXXX and extends to YYYY.  TODO:
look up these numbers.

Video
-----

VGA provides various video modes.  The simplest by far is 320x200x256
because the video RAM is just a 2D array of bytes and every pixel is
one byte.

TODO: provide example to go into this mode and list where the
screen is mapped to.

Addressing
----------

The 286 and earlier models support what's called "real mode", which
is this terrible thing where 32 bits are used to address a byte in
memory, but it's actually a pair of 16-bit numbers, and the middle
N bits overlap, so it's really only M bits of address space.

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
left unmentioned.

TSR
---

While I don't recommend you actually write a TSR (Terminate and
Stay Resident) program, they deserve a mention.  TODO write
a little about them.
