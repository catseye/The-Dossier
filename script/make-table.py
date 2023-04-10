#!/usr/bin/env python


import json
import os
import re
import subprocess
import sys
try:
    from urllib import quote
except ImportError:
    from urllib.parse import quote
assert quote

from feedmark.checkers import Schema
from feedmark.formats.markdown import feedmark_markdownize
from feedmark.loader import read_document_from, read_refdex_from


def main(args):
    articles_doc = read_document_from('README.md')
    articles_data = articles_doc.to_json_data()
    # print(json.dumps(articles_data, indent=4))

    print("Link | Published on | Subjects |")
    print("-----|--------------|----------|")
    for section in articles_doc.sections:
        properties = section.properties
        if "A Note on Items" in section.title:
            continue
        assert "link" in properties, "No link on {}".format(section)
        print(
            "{} | {} | {} |".format(
                properties["link"],
                properties.get("publish-date", "(draft)"),
                properties.get("subjects", ""),
            )
        )

if __name__ == '__main__':
    main(sys.argv)
