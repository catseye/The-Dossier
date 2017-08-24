Computer Music Formats
======================

*   status: under construction
*   common: type: Music Format

This is a list of formats in which computers store music, and some software that
plays and/or edits music in these formats.  Indeed, sometimes the format is
named after the software.

### SID Player

Commodore 64.

There was an editor for this format called SID Editor, which was written largely
in Commodore BASIC 2.0 (there were some machine-language subroutines, but it was
largely BASIC.)

### MIDI

*   specification-link: https://www.midi.org/specifications/category/smf-specifications
*   wikipedia: https://en.wikipedia.org/wiki/MIDI

This one's pretty well standardized, I think.

I did a lot of MIDI sequencing with a Roland JV-30 and Cakewalk, back in the Windows 95 era.

MIDI files can be rendered to digital audio using a "soundfont" such as "freepats" and a
renderer like [TiMidity++][].

[TiMidity++]: http://timidity.sourceforge.net/

### DMCS

*   wikipedia: https://en.wikipedia.org/wiki/Deluxe_Music_Construction_Set

By Electronic Arts.  For the Amiga and the Apple Macintosh.

It could export to MIDI.

### Noisetracker MOD

*   specification-link (broken): http://www.programmersheaven.com/download/15948/0/ZipView.aspx

This is what we talk about when we talk about MOD files, I think.

There's an open-source audio player called [xmp][] that can play MED, Noisetracker MOD,
and many other formats.

[xmp]: http://xmp.sourceforge.net/

### MED

*   specification-link (broken): http://www.programmersheaven.com/download/2173/download.aspx

Amiga.  The editor is called MED.  There was a MED Player.

MED has a "transpose" command, but not all players honour it, and when they don't,
well, one of the voices is in the wrong key.

There's an open-source audio player called [xmp][] that can play MED, Noisetracker MOD,
and many other formats.

[xmp]: http://xmp.sourceforge.net/

### MP3

*   wikipedia: https://en.wikipedia.org/wiki/MP3

Yeah.  Obviously.

### Sonant Tracker Format

*   specification-link: http://sonantlive.bitsnbites.eu/

[Sonant Live][] runs in a browser (Javascript and HTML5) and synthesizes its voices.
There is also a [Sonant Tracker][] which uses the same format and runs on Windows.

[Sonant Tracker]: http://www.pouet.net/prod.php?which=53615
[Sonant Live]: http://sonantlive.bitsnbites.eu/

### Csound

I always want to capitalize it as "cSound", for what are probably obvious reasons.

It's the FORTRAN of computer music languages.

### MML

*   wikipedia: https://en.wikipedia.org/wiki/Music_Macro_Language

I've seen music written in this in BASIC programs, but only learned that it was
called "MML" fairly recently.  The Wikipedia article is worth a read.
