#!/bin/sh -x

feedmark --by-property article/*\ of\ Note.md \
                       article/Recollected\ Games.md \
                       article/Lost\ Games.md \
                       article/Some\ Modern\ Retrogames.md \
                       article/Classic\ Computer\ Games.md article/Classic\ Text\ Adventures.md >/dev/null

feedmark --check-against-schema=schema/Text\ adventure.md \
         ../The-Dossier/article/Text\ Adventures\ of\ Note.md ../The-Dossier/article/Classic\ Text\ Adventures.md \
         --rewrite-markdown || exit 1

feedmark --check-against-schema=schema/Book.md \
         ../The-Dossier/article/An\ Esolang\ Reading\ List.md \
         --rewrite-markdown || exit 1

feedmark --check-against-schema=schema/Video\ game.md \
         ../The-Dossier/article/Some\ Modern\ Retrogames.md \
         --rewrite-markdown || exit 1

