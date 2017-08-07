#!/bin/sh

feedmark --by-property article/*\ of\ Note.md \
                       article/Recollected\ Games.md \
                       article/Lost\ Games.md \
                       article/Some\ Modern\ Retrogames.md \
                       article/Classic\ Computer\ Games.md article/Classic\ Text\ Adventures.md

# ./bin/feedmark --output-markdown ../The-Dossier/article/Text\ Adventures\ of\ Note.md --property-priority-order='written by,published by,available for,date released,written using,with graphics,treasure-oriented,personally finished,wikipedia,entry,walkthrough,play online'
