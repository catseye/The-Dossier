Basic Theory of Video Games
===========================

*draft*

Modern computers are obscenely powerful, but they weren't always so.  Yet
we had video games back then.  How did they work?

The operative word is _video_.  Understanding how a television works will
really help in understanding how a video game works.

Video
-----

The basic idea is that a video display is composed of a number of horizontal
_scan lines_.  In an old analog television, there was a beam that could
cause only one point on the screen at a time to glow, and this beam's point
would pass left-to-right along the top scan line, then left-to-right on the next
scan line down, then the next, until finished the last scan line at the bottom
of the screen.  Then it would go back to the top and repeat the process.  Each
of these passes down the screen is called a _frame_.  Modern display devices
are slightly different, but the basic idea still holds.

In order to display smooth movement in the video, the device must display
a significant number of frames per second, for instance 30 (note: I'm
just making up some numbers for convenience in this paragraph).  Therefore each
frame must be generated quite quickly — say, 1/30 of a second — and therefore
each scan line must be generated even more quickly — 1/6000 of a second if
there are 200 scan lines.  And if each scan line contains 200 pixels, then the
beam must change in intensity 1.2 million times a second.

Video display circuitry
-----------------------

1.2 million times per second is a lot of times per second to do anything,
and while it's not too difficult to pack this many changes into an analog TV
signal, if you wanted a computer to generate this signal, it would really
help matters if it had some dedicated hardware for it.  You'd use up a lot of
cycles if you were to task the CPU with controlling every pixel individually.

In fact, to appreciate how video-oriented the early computers were,
consider that the Commodore 64's clock speed in North America was
1.023 MHz.  Why such a weird number, especially when the CPU was capable
of 2 MHz?  Because the clock was being used to generate the video signal,
which had to match the NTSC standard, and 1.023 MHz, when divided in the
right way, does that.  (The following generations of computers used dedicated
video clocks in their video circuitry to allow the CPU and the video to
run at independent rates.)

Either way, we have this dedicated video display circuitry which can generate
a video signal without taking up any of the CPU's time.  How does it generate
the display?  There were many possible tricks it could use, but the basic
idea is that there is a chunk of RAM dedicated to holding a bit-map
representation of the display — the "video RAM" — and this circuitry reads it
and derives the signal that will modulate the beam which will make the various
points on the screen either bright or dark (or colour, but we'll just ignore
such fancy complications for this.)

The contents of this RAM are relatively persistent — the video circuitry
just reads it over and over and generate the frames from it over and over
and if nothing changes the contents of the RAM, the frames don't change
either and the picture looks still.  And a program (running on the CPU)
only has to write a different value to one of the bytes of RAM, and that
part of the screen will look different on the next frame.

Vertical blanking interval
--------------------------

I say "next frame" but of course, since the CPU doesn't have direct
control over when the video circuitry will turn any given part of video
RAM into a video signal, there is no guarantee that the current frame
won't be based partly on the newly updated video image.  When that happens,
the viewer sees just that — partial images.  A particularly egregious
instance of this effect is "CGA snow".  How do we prevent this?

There's one thing I've omitted, and it comes from the fact that in an
analog TV, the beam can't travel instantaneously.  Each time it gets to
the right side of the screen, it "blanks" as it travels back to the left
for the next scan line.  Ditto each time it gets to the bottom, it "blanks"
while travelling back to the top.  These are called the
_horizontal blanking interval_ and the _vertical blanking interval_, and
the latter is very important for video games.

The key idea is that if you wait for the vertical blanking interval before
making changes to video RAM, and get all those changes done before the
top scan line starts being displayed, you will get a smoothly animated
display.

To enable this, the computer architecture is usually wired up such that
an _interrupt_ is issued when the vertical blanking interval begins.
So the game program can, when it starts up, install a handler for this
interrupt — a bit of code which runs immediately when the interrupt happens,
regardless of what the CPU is doing.
There are different ways to set it up, but perhaps all this interrupt does
is set a global variable, and perhaps all the main code does is wait
for this variable in a busy loop.

At any rate, when the vertical blanking interval begins, that is the time
that the program should, as quickly as possible, update the display by
writing new values to the video RAM.  And as soon as the vertical blanking
interval ends, the program should avoid changing video RAM, to avoid flicker
and snow.

But there is this entire screen that is being updated at this point!
Does the CPU just sit there, waiting for the next vertical blanking
interrupt?  No, that would be wasteful.  It should use this time
productively by computing the next state of the game.  i.e. what will
be the player's new position based on their velocity, did they collect
a treasure and should we increase their score... that sort of thing.

Then when the next VBI does come, we will update the display from that
new game state we computed.

So in some sense, the history of video games has been "how much processing
can you get done in 1/n'th of a second?"

State
-----

Now that we've made it clear, hopefully, how dependent a video game is on
translating the game state into video updates, and updating the game state
in a timely manner, we should probably talk about how the game state can be
structured.

This section is TBW.
