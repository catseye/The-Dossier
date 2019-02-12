#!/usr/bin/env python3

# Invoke like the following, rewrites the file in-place:
# PYTHONPATH=../Feedmark/src ./script/rewrite-images.py article/Some\ Modern\ Retrogames.md
# NOTE: not ready for prime time.  Needs to take a --schema argument.

import sys

from argparse import ArgumentParser

from feedmark.loader import read_document_from
from feedmark.formats.markdown import feedmark_markdownize


def main(args):
    argparser = ArgumentParser()

    argparser.add_argument('docs', nargs='+', metavar='FILENAME', type=str)

    options = argparser.parse_args(args)

    for filename in options.docs:
        document = read_document_from(filename)
        for section in document.sections:
            new_images = []
            for alt_text, url in section.images:
                rewritten_url = "https://wow." + url
                new_images.append((alt_text, rewritten_url))
            section.images = new_images
        s = feedmark_markdownize(document)
        with open(document.filename, 'w') as f:
            f.write(s)


if __name__ == '__main__':
    main(sys.argv[1:])


