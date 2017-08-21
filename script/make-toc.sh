#!/bin/sh

ARTICLES=article

echo "*   **Games of Note**"
echo "    "
feedmark --output-toc --include-section-count \
    "$ARTICLES/Video Games of Note.md" \
    "$ARTICLES/Commodore 64 Games of Note.md" \
    "$ARTICLES/Apple II Games of Note.md" \
    "$ARTICLES/Role-Playing Games of Note.md" \
    "$ARTICLES/Text Adventures of Note.md" \
    | sed -e 's/^/    /'
echo ""
echo "*   **Classics**"
echo "    "
feedmark --output-toc --include-section-count \
    "$ARTICLES/Classic Computer Games.md" \
    "$ARTICLES/Classic Text Adventures.md" \
    | sed -e 's/^/    /'
echo ""
feedmark --output-toc --include-section-count \
    "$ARTICLES/Lost Games.md" \
    "$ARTICLES/Recollected Games.md" \
    "$ARTICLES/Some Modern Retrogames.md" \
