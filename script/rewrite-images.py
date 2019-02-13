#!/usr/bin/env python3

# Invoke like the following, rewrites the file in-place:
# PYTHONPATH=../Feedmark/src ./script/rewrite-images.py article/Some\ Modern\ Retrogames.md

import json
import sys

from argparse import ArgumentParser

from feedmark.checkers import Schema
from feedmark.loader import read_document_from
from feedmark.formats.markdown import feedmark_markdownize


def main(args):
    argparser = ArgumentParser()

    argparser.add_argument('docs', nargs='+', metavar='FILENAME', type=str)

    options = argparser.parse_args(args)

    for filename in options.docs:
        document = read_document_from(filename)

        schema = None
        schema_name = document.properties.get('schema')
        if schema_name:
            schema_filename = "schema/{}.md".format(schema_name)
            schema_document = read_document_from(schema_filename)
            schema = Schema(schema_document)
            results = schema.check_documents([document])
            if results:
                sys.stdout.write(json.dumps(results, indent=4, sort_keys=True))
                sys.exit(1)
        else:
            continue
        for section in document.sections:
            new_images = []
            for alt_text, url in section.images:
                rewritten_url = url
                new_images.append((alt_text, rewritten_url))
            section.images = new_images
        s = feedmark_markdownize(document, schema=schema)
        with open(document.filename, 'w') as f:
            f.write(s)


if __name__ == '__main__':
    main(sys.argv[1:])


