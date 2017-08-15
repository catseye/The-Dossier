#!/bin/sh -x

ARTICLES=../The-Dossier/article

(cd $ARTICLES && feedmark --output-refdex *\ of\ Note.md \
                          Recollected\ Games.md \
                          Some\ Modern\ Retrogames.md \
                          Classic\ Computer\ Games.md \
                          Classic\ Text\ Adventures.md \
                 >../refdex.json)

# non-lists
feedmark --input-refdex=refdex.json \
         "$ARTICLES/A Basic Theory of Video Games.md" \
         "$ARTICLES/Blurry Memories of DOS Programming.md" \
         "$ARTICLES/Perspective on Text Adventures.md" \
         "$ARTICLES/The Aesthetics of Esolangs.md" \
         "$ARTICLES/Retrospective on Language Design.md" \
         --rewrite-markdown || exit 1

#lists
feedmark --input-refdex=refdex.json \
         --check-against-schema=schema/Text\ adventure.md \
         $ARTICLES/Text\ Adventures\ of\ Note.md \
         $ARTICLES/Classic\ Text\ Adventures.md \
         --rewrite-markdown || exit 1

feedmark --input-refdex=refdex.json \
         --check-against-schema=schema/Book.md \
         "$ARTICLES/An Esolang Reading List.md" \
         --rewrite-markdown || exit 1

feedmark --input-refdex=refdex.json \
         --check-against-schema=schema/Video\ game.md \
         "$ARTICLES/Some Modern Retrogames.md" \
         "$ARTICLES/Apple II Games of Note.md" \
         --rewrite-markdown || exit 1
