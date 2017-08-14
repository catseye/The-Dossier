#!/bin/sh -x

ARTICLES=../The-Dossier/article

feedmark --by-property article/*\ of\ Note.md \
                       article/Recollected\ Games.md \
                       article/Lost\ Games.md \
                       article/Some\ Modern\ Retrogames.md \
                       article/Classic\ Computer\ Games.md article/Classic\ Text\ Adventures.md >/dev/null

# non-lists
feedmark "$ARTICLES/A Basic Theory of Video Games.md" \
         "$ARTICLES/Blurry Memories of DOS Programming.md" \
         "$ARTICLES/Perspective on Text Adventures.md" \
         "$ARTICLES/The Aesthetics of Esolangs.md" \
         "$ARTICLES/Retrospective on Language Design.md" \
         --rewrite-markdown || exit 1

feedmark --check-against-schema=schema/Text\ adventure.md \
         ../The-Dossier/article/Text\ Adventures\ of\ Note.md ../The-Dossier/article/Classic\ Text\ Adventures.md \
         --rewrite-markdown || exit 1

feedmark --check-against-schema=schema/Book.md \
         ../The-Dossier/article/An\ Esolang\ Reading\ List.md \
         --rewrite-markdown || exit 1

feedmark --check-against-schema=schema/Video\ game.md \
         "$ARTICLES/Some Modern Retrogames.md" \
         "$ARTICLES/Apple II Games of Note.md" \
         --rewrite-markdown || exit 1
