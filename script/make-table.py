#!/usr/bin/env python3


import sys

from feedmark.loader import read_document_from


def main(args):
    articles_doc = read_document_from('README.md')
    # print(json.dumps(articles_doc.to_json_data(), indent=4))

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
