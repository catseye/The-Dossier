#!/bin/sh -x

ARTICLES=../The-Dossier/article

(cd $ARTICLES && feedmark --output-refdex --output-refdex-single-filename \
                          "20th-Century Visual Artists of Note.md" \
                          "An Esolang Reading List.md" \
                 >../dossier-refdex.json) || exit 1

REFDEXES=dossier-refdex.json

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
         --check-against-schema=schema/Book.md \
         "$ARTICLES/An Esolang Reading List.md" \
         --rewrite-markdown || exit 1
