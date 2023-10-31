A Basic Theory of Video Games
=============================

*   publication-date: 3 May 2017
*   revision @ 12 Mar 2020 (added illustrations, more footnotes, edited for clarity)

In the modern era, computers are extremely powerful.  But they weren't always so,
and video games were invented back in an age when processing power was still
quite modest.  But they were still capable of fast and frenetic action,
demanding of the player's reflexes.  So one might wonder: How did they do that?

The operative word is _video_.  Understanding how a television works will
really help in understanding how a video game works.

### Video

How an old-school analogue television tube generates images on
its glowing screen is not too complicated.  At the back of the tube there's
a "gun" that shoots a beam of electrons forward, and where this beam hits the
screen from behind, it makes a glowing spot.  The intensity of the beam can
be changed to vary the brightness of the glow, and there are some magnets along the
sides of the tube which can bend the beam before it hits the screen, and thus determine
where on the screen the spot appears.  (It's a little more complicated for
colour TVs, but let's ignore those for now to keep things simple.)

But — at any given time there can only be *one* spot on the screen that's being
hit by the beam like this.  So to create the illusion that the whole screen is
glowing, the trick is to move the spot around *very, very quickly*.

To make an image that fills the screen, we need a good method for
covering the the entire screen in an orderly fashion.  The method developed
for television broadcasting is one such method.  Each _frame_ starts at the
top-left of the screen, and is composed of successive left-to-right _scan lines_,
each of which is slightly lower down on the screen than the one before it.  Then,
when we get to the bottom-right of the screen, the beam goes back up to the
top-left for the next frame.
[(Footnote 1)](#footnote-1)

![Diagram of video frame scan lines](https://static.catseye.tc/images/illustrations/617px-Raster-scan.svg.png)

While there are certainly some differences, modern displays work quite
similarly. [(Footnote 2)](#footnote-2)

That glowing spot is fairly small, so to get a nice, solid-looking frame, we
should space the scan lines closely together.  For the sake of concreteness,
let's say there are 200 scan lines on our picture tube, and that we will
vary the intensity of the beam 200 times during each scan line.
Each frame must be drawn quickly to make it look like a solid image, and
if we want the impression of smooth motion in the video, the frames must be
generated in quick succession, as well — say, 30 frames per second.

Crunching these numbers, we find that each frame must be drawn in 1/30 of a
second, and each of its 200 scan lines must be drawn in 1/6000 of a second.
That's a really short time — one-sixth of a millisecond.  And since each scan
line contains 200 pixels, the beam must be able to change in intensity
1.2 million times a second!

### Video display circuitry

1.2 million times per second is a lot of times per second to do anything.
It's not too difficult to pack this many changes into an analogue signal
that's being transmitted via radio waves (as TV signals originally
were), but if you need a *computer* to generate such a signal, that's
a slightly different story.

In the 80's it was not unusual for a CPU to have a clock speed of 4MHz,
that is, four million times per second.  But it would take several
clock cycles to perform a single instruction.  Let's say it took 4
on average, so the CPU could execute one million instructions per
second.

This CPU would be *almost* fast enough to control the intensity of
the video beam to generate our 200 scan lines of 200 pixels each.
But — if it were tasked with doing that, we would have another problem:
it wouldn't have any time left over to do anything else!

To solve this problem, early computers, or at least the kind meant to be
hooked up to a television tube (arcade games and home computers),
often had a significant amount of electronics inside them dedicated
solely to the task of generating the video signal.

In fact, some of the architectural designs of these older computers
are so video-oriented that they feel like devices designed to
generate a video signal with a general-purpose computer strapped
onto them, rather than the other way around.

Consider, for example, that the processor clock speed of a Commodore 64
in North America was 1.023 MHz.  Why such a weird number, especially when the
CPU was capable of 2 MHz?  Because the clock signal that was driving the CPU was
obtained by scaling down a master clock whose frequency was 14.31818 MHz.
And why did it have such a master clock?  So that it could generate frequencies
matching the NTSC standard, to make the video signal for the North American
TV set that it would typically be hooked up to. [(Footnote 3)](#footnote-3)

At any rate, instead of making it the CPU's responsibility to generate the video signal,
the computer would have dedicated video display circuitry to generate
the video signal without taking up any of the CPU's time.

But how does this circuitry generate the display?  There are many possible tricks it
can use [(Footnote 4)](#footnote-4),
but the general idea is that in the computer there is some RAM dedicated to holding a
representation of the display — the "video RAM" — that both the CPU and this
circuitry can access.  The CPU writes some values to it describing what should
be displayed, and the video display circuitry reads these values and uses them to
derive the signal that will modulate the beam that will make the various
points on the screen either bright or dark.

The contents of the video RAM persist while the computer is powered on.
The video display circuitry reads the video RAM (over and over and over), and
generates the video signal from it (over and over and over), and
if nothing changes the contents of the video RAM, the frames don't change
either, and the picture on the screen looks still.  A program running on the CPU
only has to write a different value to one of the locations in video RAM, and the
part(s) of the screen that correspond to that location will look different when
the next frame is drawn. [(Footnote 5)](#footnote-5)

### Vertical blanking interval

I say "next frame" but of course, since the CPU doesn't have direct
control over when the video circuitry will turn any given part of video
RAM into a video signal, there is no guarantee that the CPU won't update
the video RAM at the exact moment when the frame is being drawn.  When
that happens, the frame is based partly on the previous state of the
video RAM, and partly on the new state of the video RAM, and what do you
suppose the viewer sees on the screen when that happens?  Generally speaking,
they see a choppy flickering between partial images, and generally
speaking, it's unpleasant.  (A particularly egregious instance
of this effect is the so-called [CGA snow](https://en.wikipedia.org/wiki/Color_Graphics_Adapter#Limitations.2C_bugs_and_errata).)
So, how can this unpleasantness be prevented?

There's one detail I've omitted in the description of how the television
works: the beam can't travel around the screen instantaneously.  It
takes a bit of time, however small it might be, to change the power to
the magnets.  That glowing spot can't teleport; it always takes a
continuous path from one point to another.

So what happens is, each time the beam gets to the right side of the screen,
it "blanks" (becomes intensity zero = no glow) as it "retraces" (travels back)
to the left for the next scan line.  Ditto, each time it gets to the bottom, it
"blanks" as it "retraces" to the top-left.  The short periods of time when these
retraces are happening are called the _horizontal blanking interval_ (HBI) and
the _vertical blanking interval_ (VBI), respectively.  The latter, especially,
is very important for video games.

The key idea is that *if you wait for the vertical blanking interval before
making changes to video RAM, and also get all your changes done before the
first scan line of the next frame starts being displayed, you will get a
smoothly-drawn and smoothly-animated display*.

To enable this, the computer architecture is usually wired up such that
the CPU is able to detect when a VBI has begun.  Often this is done with an
_interrupt_, which is a way to alert the CPU of an external event no matter
what the CPU is doing at the time.

But regardless of how it's implemented exactly, the idea is that the CPU
waits for the VBI to start, and then gets to work writing new values to the
video RAM that reflect what the screen should look like next.  It's
important that it should finish this work before the VBI is over, too,
because as soon as the next frame begins being drawn, any updates to video
RAM could cause flickering.  And the CPU shouldn't touch the video RAM again
until the next VBI begins.

In the time between VBIs, there's this entire screen being drawn, scan line
by scan line, by the video display circuitry, and the CPU can't touch the
video RAM.  So does the CPU just sit there, waiting idly
for the next VBI to start?  No, that would be wasteful.  Instead, it can
use this time productively by computing the next state of the game.  For
example, what will be the player's new position based on their velocity?
Did they collect a treasure and should we increase their score?  That sort
of thing.  Then, when the next VBI does come, it will update the video RAM
from that new game state that was computed.  And if the new game state has
been completely computed by that time, it can perform the display updates
quickly — within the space provided by the VBI. [(Footnote 6)](#footnote-6)

So in some sense, the history of video games can be summed up as: "How
much processing can you get done in 1/*n*'th of a second?"

To recap:

*   Wait for the VBI to begin.
*   Update the video RAM based on the current game state.
*   Before the VBI has ended, stop updating video RAM and start putting
    together the next game state (based on the current game state plus
    the state of any input devices, etc.)
*   Wait for the next VBI to begin.
*   Repeat ad infinitum.

### State

Hopefully the above has made it clear just how dependent a video game is on
translating the game state into a set of video updates which can occur in a timely
manner, as well as updating the game state in a timely manner during the
period that the screen is actually being drawn.  Now let's discuss
how the game state can be structured to actually accomplish this.

Saying "the next game state is based on the current game state plus the
state of input devices" is very nice from a mathematical point of
view, but it's rather abstract to work with.  Computer science provides
us with the concept of the _state machine_ which can help us break it down.

Note, however, that here the state machine concept is used primarily as a
*design pattern* rather than as a reusable framework.  There are many, many
ways to implement a state machine, and you don't tend to see anything
as elaborate and refined as `class StateMachine { ... }` in a video game's code, at
least not until the 1990's, because the overhead for such a thing would be
prohibitive on (e.g.) an 8-bit processor.

Instead, the state machine is implemented directly in the code, usually
"hand-written" in terms of global variables and execution location.  It's
probably obvious how the former works, but the latter is somewhat more
subtle; it basically comes down to, if we are inside such-and-such part
of the code, we know we must be in such-and-such state (because otherwise,
how did we get here?), so act accordingly.  It's like the information
about the current state has been "compiled into" the code.

This sort of code-to-state association also leads to a neat trick where the
address of the routine that handles a particular state can be used to uniquely
identify that state; you can store the address of the routine directly in the
"current state" variable, and make comparisons on it.  This saves having to
establish an extra enumeration of values to represent the state.

There are a couple of other things about the state structure of a video game
that might be easy to miss:

*   They extend outside of the game itself.  Coin-op arcade games have
    an "attract mode", which might include a pre-recorded demonstration
    of the game being played, but even simple home games generally have a
    title screen or something before a new game begins, and that title
    screen is a state too.
*   They are composed of smaller states, sometimes sub-state machines.
    For instance, in the "attract mode" state, the machine might
    switch between showing a title screen and the list of high scores,
    each displayed for 5 seconds — these
    are sub-states of the "attract mode" state.  Or, during the game
    itself, there might be 12 antagonists on the screen, each with
    its own state (position and velocity).  You could also call those
    sub-states of the game, but here they compose differently — you could
    say the state of the game includes the [Cartesian product][] of those 12
    states.

There are virtually an endless number of ways these configurations of
states can be combined and implemented, and even listing the most common 
patterns would probably be outside the scope of this article.

But as a concrete example, here is the diagram of a nested state machine describing
the _Asteroids_-like game [Cosmos Boulders](https://codeberg.org/catseye/Cosmos-Boulders):

![State machine diagram for the game "Cosmos Boulders"](https://codeberg.org/catseye/Cosmos-Boulders/media/branch/master/images/state-machine-diagram.png?raw=true)

And here's a rough description of how the state logic in the above
diagram might be coded inside the video-updating loop we talked about in
the previous section.  (In a few places in it I've not included
every last detail, so as not to be bogged down while getting the main points
across. If it's the sort of thing that appeals to you, you can say that filling
in every last detail here is left as an exercise for the reader.)

*   Wait for the VBI to begin.
*   Update the video RAM based on the current game state:
    *   If we are in attract mode, draw either the game's logo,
        or the list of high scores, depending on the sub-state.
    *   If we are in game-over mode, draw the text "GAME OVER"
        on the screen.
    *   If we are in game-on mode, draw the ship, boulders, and missiles
        on the screen, based on their position and their individual
        states (i.e. if they're exploding, draw an explosion instead).
*   Update the game state:
    *   If we are in attract mode, check if the "Start Game" button is
        being pressed, and if so change to game-on mode.  If not,
        check if a certain amount of time has passed, and if so,
        switch from showing the logo to showing the high scores, or
        vice versa.
    *   If we are in game-over mode, check if a certain amount of
        time has elapsed, and if so change to attract mode.
    *   If we are in game-on mode:
        *   If the player is in playing mode, compute the new velocity
            of the player's ship based on the position of the joystick;
            Also, if the player's ship overlaps with one of the boulders,
            change the player from playing mode to exploding mode.
        *   If the player is in exploding mode, check to see if a certain
            amount of time has passed.  If it has, decrement the number of
            lives of the player.  If it is above zero, go back to playing
            mode, else go to game-over mode.
        *   For each boulder, if the boulder is in moving mode,
            compute its new position based on its current
            position and velocity.
        *   For each missile, if the missile is in moving mode,
            compute its new position based on its current
            position and velocity.
*   Wait for the next VBI to begin.
*   Repeat ad infinitum.

...and when the machine is powered on (or when this game is loaded from
a cassette tape, or whatever,) there is some startup code that sets
up the initial state (current mode = attract mode, etc.) and jumps
into this loop.

### Conclusion

And there's really not much to add after this point.

This has been an exposition of a basic theory of video games.

It in itself is not Earth-shattering, of course, and there are dozens
of little holes that have been glossed over — but knowing about it
might give you a deeper appreciation of the medium.

For example, it gives some insight as to why there are bars of
"dead space" above and below the main display on many older
home computers: it effectively makes the VBI longer.  Some games
also update only the top half of the screen regularly, and
fill the bottom half with an ornate, but largely static,
"status display", which is another way to artificially lengthen
the amount of time they have to update video RAM before the
display circuitry gets to converting it to a video signal.

Or, have you ever been playing a first-person shooter and you
trigger some kind of boobytrap and a bunch of antagonists appear and
everything gets all choppy?  You might know that that's called "frame drop",
and you probably guessed it's because the computer now has "too much to do".
But knowing this theory, you can see that it *literally* has too much
to do — more game state to compute than it can process in 1/*n*th of a
second, before the next VBI.  So it fails to update the screen on that
VBI, but it does get it done before the *next* VBI.  So effectively the
frame rate drops to half, accounting for the choppiness.

Are things really very different in the modern age?  Well, yes and no.

Yes, because the dedicated video hardware is now immensely complex and
capable of doing all kinds of things completely independently of the
CPU, and because games often now run under multitasking operating systems
that try to fairly distribute resources like processing time (and
the video display!) to multiple programs at once, and that require
these programs to access these resources via abstractions
that distance them significantly from the hardware.

But also no, because you don't have to look far to see many of the
same ideas, just in a different guise.  For example, in Javascript in
a modern web browser you can [request an animation frame][], which is
an awful lot like waiting for the VBI.

[Cartesian product]: https://en.wikipedia.org/wiki/Cartesian_product
[request an animation frame]: https://developer.mozilla.org/en-US/docs/Web/API/window/requestAnimationFrame

### Footnotes

##### Footnote 1

The similarity between this and how words are written on a page of text
should not go unnoticed.  Indeed, one wonders if, had television been
invented in some other part of the world, scan lines would instead go
right-to-left or top-to-bottom...

##### Footnote 2

Modern display devices are composed of millions of display elements —
effectively, tiny lights — so in theory they no longer have the restriction
of only being able to make one spot glow at a time.  However, it's still
more energy-efficient to do it that way.  So they still work in basically
the same way, with frames made up of scan lines.

In fact, devices like the 7-segment LED display on, for example, a microwave,
work on the same "scan" principle.  Try moving your eyes rapidly back and
forth when looking at one of these, and you'll notice the afterimage is not
a smooth streak.  It's segmented, meaning parts of it are "blinking" — only
one segment is illuminated at any one time — but it's going too quickly for
you to notice.

##### Footnote 3

[This StackExchange answer](https://retrocomputing.stackexchange.com/questions/2146/reason-for-the-amiga-clock-speed)
has a detailed exposition of this approach as it applies to the Amiga.
Later generations of computers used dedicated video
clocks in their video circuitry to allow the CPU and the video hardware
to run at independent rates.

##### Footnote 4

Discussing all the tricks that have been used to make it possible to generate
a signal for the entire screen in such a short amount of time on a system with
limited processing power is probably outside the scope of this article, but
they are an interesting subject in their own right, so here is a sampling of
them for anyone who wishes to research them further:

*   programmable characters
*   hardware sprites
*   double-buffering
*   scan line and frame offsets ("smooth scrolling")

##### Footnote 5

The seperation wasn't always as clean as this makes it sound.  The Atari 2600,
for example, did have some dedicated hardware for displaying some "players and
missiles" without the CPU's involvement, and the registers in this chip were in
some sense the machine's "video RAM"; but that's effectively *all* it had.  If
you wanted to display other graphics, such as a background, the CPU *would* have
that responsibility.  The CPU would need to execute instructions to change the
video signal at certain points on each scan line, as it was being drawn,
sometimes executing dummy instructions to make sure it was in sync with where the
scan line was at all times — a technique that has been called "racing the beam".

##### Footnote 6

It's probably worth noting that, once RAM became affordable enough, the
double-buffering technique came to dominate, as it makes this much easier.
The machine's memory essentially contains two banks of video RAM.
When bank 1 is being displayed, the CPU updates bank 2, and vice versa.
When the VBI comes, all that has to happen is, the video hardware is told
to display the other bank, and the CPU is likewise told to to update the
other bank, for the next frame.
