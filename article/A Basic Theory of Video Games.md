A Basic Theory of Video Games
=============================

*   status: draft

Modern computers are extremely powerful.  But they weren't always so, and
video games were invented back in an age when processing power was still
rather modest.  But they were still capable of fast and frenetic action,
demanding of the player's reflexes.  So one might wonder: How did they work?

The operative word is _video_.  Understanding how a television works will
really help in understanding how a video game works.

Video
-----

How an old-school black-and-white analog television generates its glowing
screen is not too complicated.  At the back there's a "gun" that shoots a
beam of electrons forward, and where this beam hits the screen from behind,
it makes a glowing spot.  The intensity of glow can be varied by changing
the intensity of the beam.  And there are some magnets along the sides which
can bend the beam before it hits the screen and thus determine where on the
screen the spot appears.

But, there can only be one spot that is being hit like this at any one time,
so to create the illusion that the whole screen is glowing, the trick it to
move the spot around very, very quickly.

So what we need is a good method for covering the entire screen in an
orderly fashion.  And what we have is this: each _frame_ starts at the top,
and is composed of successive left-to-right _scan lines_, each of which is
slightly lower down on the screen.  Then when we get to the bottom-right of
the screen, the beam goes back up to the top-left for the next frame.
[(Footnote 1)](#footnote-1)

While there are certainly some differences, modern displays work very similary.
[(Footnote 2)](#footnote-2)

That glowing spot is fairly small, so to get a nice, solid-looking frame, we
should space the scan lines closely together.  Say that there are 200
scan lines on our picture tube.  And, remember we're varying the intensity of
the beam as it goes along the scan line, in order to draw individual pixels;
say there are 200 pixels on a scan line.  (Note that I'm just making up
representative numbers in this section; they don't necessarily correspond to
the specs of any real video equipment.)

As I said, the frame must be drawn quickly to make it look solid, and further,
if we want the impression of smooth movement in the video, the frames must
done in quick succession as well.  Say we want to draw 30 frames per second.

Therefore, each frame must be drawn in 1/30 of a second, and each scan
line must be drawn in 1/6000 of a second.  That's a really short time —
one-sixth of a millisecond.  And since each scan line contains 200 pixels, the
beam must be able to change in intensity 1.2 million times a second.

Video display circuitry
-----------------------

1.2 million times per second is a lot of times per second to do anything,
and while it's not too difficult to pack this many changes into an analog TV
signal, if you wanted a *computer* to generate this signal, it would really
help matters if it had some dedicated hardware to do that, because you'd use
up a lot of cycles if you were to task the CPU with controlling every pixel
individually.

So early computers, or at least the kind inside video arcade games and home
units that were meant to be hooked up to TVs, often had a significant amount
of their electronics dedicated to the problem of generating the video display.

In fact, to appreciate how video-oriented the early computers were,
consider that the Commodore 64's clock speed in North America was
1.023 MHz.  Why such a weird number, especially when the CPU was capable
of 2 MHz?  Because the clock was also being used to generate the video signal,
which had to match the NTSC standard, and 1.023 MHz, when divided in the
right way, does that.  (Later generations of computers used dedicated
video clocks in their video circuitry to allow the CPU and the video to
run at independent rates.)

Either way, we have this dedicated video display circuitry which can generate
a video signal without taking up any of the CPU's time.  How does it generate
the display?  There were many possible tricks it could use [(Footnote 3)](#footnote-3),
but the basic idea is that there is a chunk of RAM dedicated to holding a
representation of the display — the "video RAM" — and this circuitry reads it
and derives the signal that will modulate the beam which will make the various
points on the screen either bright or dark (or different colours, but we can
ignore that complication for our purposes).

The contents of the video RAM are relatively persistent — the video circuitry
just reads it over and over and generate the frames from it over and over
and, if nothing changes the contents of the video RAM, the frames don't change
either and the picture looks still.  And a program (running on the CPU)
only has to write a different value to one of the bytes of RAM, and the
part(s) of the screen that correspond to that byte will look different when
the next frame is drawn.

Vertical blanking interval
--------------------------

I say "next frame" but of course, since the CPU doesn't have direct
control over when the video circuitry will turn any given part of video
RAM into a video signal, there is no guarantee that the video RAM won't
be updated right when the frame is being drawn.  When that happens, the
frame is based partly on the previous state of the video RAM, and
partly on the new state of the video RAM, and the viewer sees just that —
a flickering between partial images.  (A particularly egregious instance
of this effect is "CGA snow".)  How do we prevent this?

There's one thing I've omitted, and it comes from the fact that in an
analog TV, the beam can't travel around the screen instantaneously.  It
takes a bit of time, however small it might be, to change the power to
the magnets, and that glowing spot always must make a continuous path
from one point to another.

So what happens is, each time the beam gets to the right side of the screen,
it "blanks" (becomes intensity zero = no glow) as it travels back to the left
for the next scan line.  Ditto each time it gets to the bottom, it "blanks"
while travelling back to the top.  These short periods of time are called the
_horizontal blanking interval_ (HBI) and the _vertical blanking interval_
(VBI), respectively.  The latter, especially, is very important for video games.

The key idea is that *if you wait for the vertical blanking interval before
making changes to video RAM and get all those changes done before the
top scan line of the next frame starts being displayed, you will get a
smoothly-drawn and smoothly-animated display*.

To enable this, the computer architecture is usually wired up such that
the CPU is able to detect when a VBI has begun.  Often this is done with an
_interrupt_, which is a way to alert the CPU of an external event regardless
of what it is doing at the time.

But regardless of how it's implemented exactly, the idea is that the CPU
waits for the VBI to start, and then gets to work writing new values to the
video RAM that reflect what the screen should look like next.  It is also
important that it should finish this work before the VBI is over, because
as soon as the next frame begins being drawn, any updates to video RAM
could cause flickering.  The CPU shouldn't touch the video RAM again until
the next VBI begins.

But there is this entire screen that is being drawn by the video hardware
at this point.  Does the CPU just sit there, waiting idly for the next
VBI to start?  No, that would be wasteful.  Instead, it can use this time
productively by computing the next state of the game.  For example, what
will be the player's new position based on their velocity?  Did they collect
a treasure and should we increase their score?  That sort of thing.
Then, when the next VBI does come, it will update the video RAM from that
new game state that was computed.

So in some sense, the history of video games has been "how much processing
can you get done in 1/*n*'th of a second?"

To recap:

*   Wait for the VBI to begin.
*   Update the video RAM based on the current game state.
*   Before the VBI has ended, stop updating video RAM and start putting
    together the next game state (based on the current game state plus
    the state of any input devices, etc.)
*   Wait for the next VBI to begin.
*   Repeat ad infinitum.

State
-----

Now that we've made it clear, hopefully, how dependent a video game is on
translating the game state into video updates which can occur in a timely
manner, and updating the game state in a timely manner while the screen
is actually being drawn, we should probably talk about how the game state
can be structured to accomplish this.

Saying "the next game state is based on the current game state plus the
state of input devices" is very nice from a sort of mathematical point of
view, but it's far too abstract to do much with.  Computer science provides
us with the concept of the _state machine_ which can help us break it down.

However, note that here the state machine concept is used primarily as a
*concept*, and not as programming abstraction.  That is, you don't tend to
see anything like `class StateMachine { ... }` in a video game's code, at
least not until the 1990's, because the overhead for such a thing would be
prohibitive on (e.g.) an 8-bit processor.

Instead, the state machine is implemented directly in the code, usually
"hand-written" in terms of global variables and execution location.  It's
probably obvious how the former works, but the latter is somewhat more
subtle; it basically comes down to, if we are inside such-and-such part
of the code, we know we must be in such-and-such state (because otherwise,
how did we get here?), so act accordingly.  It's like the information
about current state has been "compiled into" the code.

There are two other things to note about the states of a video game:

*   They extend outside of the game itself.  Arcade games would have
    an "attract mode", which might include a pre-recorded demonstration
    of the game being played, but even simple home games generally have a
    title screen or something before a new game begins, and that title
    screen is a state too.
    
*   They are composed of smaller states, sometimes sub-state machines.
    For instance, in an "attract mode" state, the machine might
    switch between showing a title screen, the list of high scores,
    and a summary of the rules, each showing for 5 seconds — these
    are sub-states of the "attract mode" state.  Or, during the game
    itself, there might be 12 spaceships on the screen, each with
    its own state (position and velocity).  You could also call those
    sub-states, but here they compose differently — the state of
    the "game screen" is a kind of product of those 12 states.

There are virtually an endless number of ways these states can be combined,
and even listing the most common patterns would probably be outside the
scope of this article.  But to try to give a single, illustrative example,
here are how the state logic for a very simple video game might appear
inside the video-updating loop given in the previous section:

*   Wait for the VBI to begin.
*   Update the video RAM based on the current game state:
    *   If we are in attract mode, draw the game's logo.
        (Perhaps the logo is animated, in which case, draw frame _n_
        of it, where _n_ comes from a counter which is incremented each
        time a VBI starts.)
    *   If we are in game-over mode, draw the text "GAME OVER"
        (or again, perhaps a single animation frame thereof)
        on the screen.
    *   If we are in game-play mode, draw the ships on the screen
        based on their position.
*   Update the game state:
    *   If we are in attract mode, check if "Start Game" button is
        being pressed, and if so change to game-play mode.
    *   If we are in game-over mode, check if a certain amount of
        time has elapsed, and if so change to attract mode.
    *   If we are in game-play mode:
        *   compute the new position of each ship based on its current
            position and velocity;
        *   compute the new velocity of the player's ship based on
            the position of the joystick;
        *   compute the new velocity of the enemy ships based on
            the position of the player's ship and their "AI"; and
        *   if the player's ship overlaps with one of the enemy ships,
            change from game-play mode to game-over mode.
*   Wait for the next VBI to begin.
*   Repeat ad infinitum.

...and when the machine is powered on (or when this game is loaded from
a cassette tape, or whatever,) there is some startup code that sets
up the initial state (current mode = attract mode, etc.) and jumps
to this loop.

And there's really not much to add after this point.

This has been an exposition of a basic theory of video games.

Footnotes
---------

##### Footnote 1

The similarity between this and how words are written on a page should
not go unnoticed.

Indeed, one wonders if, had television been invented in some other part of
the world, scan lines would instead go right-to-left or up-to-down...

##### Footnote 2

Modern display devices are composed of millions of display elements —
effectively, tiny lights — so in theory they no longer have the restriction
of only being able to make one spot glow at a time.  However, it it still
more energy-efficient to do it that way.  So they still work in basically
the same way, with frames made up of scan lines.

In fact, devices like the 7-segment LED display on, for example, a microwave,
work on the same "scan" principle.  Try moving your eyes rapidly back and
forth when looking at one of these, and you'll notice the afterimage is not
a smooth streak.  It's segmented, meaning parts of it are "blinking" — only
one segment is illuminated at any one time — but it's going too quickly for
you to notice.

##### Footnote 3

Discussing all the tricks that have been used to make it possible to generate
a signal for the entire screen in such a short amount of time on a system with
limited processing power is probably outside the scope of this article, but
they are an interesting subject in their own right, so here is a sampling of
them for anyone who wishes to research them further:

*   programmable characters
*   hardware sprites
*   double-buffering
*   scan line and frame offsets ("smooth scrolling")
