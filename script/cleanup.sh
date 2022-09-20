#!/bin/sh -x

ARTICLES=../The-Dossier/article

(cd $ARTICLES && feedmark --output-refdex --output-refdex-single-filename \
                          "20th-Century Visual Artists of Note.md" \
                          "An Esolang Reading List.md" \
                 >../dossier-refdex.json) || exit 1

REFDEXES=dossier-refdex.json,../Chrysoberyl/misc-refdex/sgon-refdex.json

# non-lists
feedmark --input-refdexes=$REFDEXES \
         "$ARTICLES/A Basic Theory of Video Games.md" \
         "$ARTICLES/Blurry Memories of DOS Programming.md" \
         "$ARTICLES/Perspective on Text Adventures.md" \
         "$ARTICLES/The Aesthetics of Esolangs.md" \
         "$ARTICLES/Retrospective on Language Design.md" \
         "$ARTICLES/Befunge Silver Jubilee Retrospective.md" \
         --rewrite-markdown || exit 1

#lists
feedmark --input-refdexes=$REFDEXES \
         --check-against-schema=schema/Text\ adventure.md \
         $ARTICLES/Text\ Adventures\ of\ Note.md \
         $ARTICLES/Classic\ Text\ Adventures.md \
         --rewrite-markdown || exit 1

feedmark --input-refdexes=$REFDEXES \
         --check-against-schema=schema/Book.md \
         "$ARTICLES/An Esolang Reading List.md" \
         --rewrite-markdown || exit 1

feedmark --input-refdexes=$REFDEXES \
         --check-against-schema=schema/Video\ game.md \
         "$ARTICLES/Some Modern Retrogames.md" \
         "$ARTICLES/Commodore 64 Games of Note.md" \
         "$ARTICLES/Apple II Games of Note.md" \
         "$ARTICLES/Atari 2600 Games of Note.md" \
         "$ARTICLES/Computer Sports Games of Note.md" \
         --rewrite-markdown || exit 1

feedmark --input-refdexes=$REFDEXES \
         --check-against-schema=schema/Computer\ game.md \
         "$ARTICLES/Classic Computer Games.md" \
         "$ARTICLES/Computer Games of Note.md" \
         --rewrite-markdown || exit 1

feedmark --input-refdexes=$REFDEXES \
         --check-against-schema=schema/Lost\ game.md \
         "$ARTICLES/Lost Games.md" \
         --rewrite-markdown || exit 1
