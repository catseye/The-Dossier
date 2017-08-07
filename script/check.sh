#!/bin/sh

feedmark --by-property article/*\ of\ Note.md \
                       article/Recollected\ Games.md \
                       article/Lost\ Games.md \
                       article/Some\ Modern\ Retrogames.md \
                       article/Classic\ Computer\ Games.md article/Classic\ Text\ Adventures.md

feedmark --check-against schema/Text\ adventure.md ../The-Dossier/article/Text\ Adventures\ of\ Note.md ../The-Dossier/article/Classic\ Text\ Adventures.md
