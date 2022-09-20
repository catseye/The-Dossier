#!/usr/bin/env python3

import json


def read_refdex(filename):
    with open(filename, 'r') as f:
        data = json.loads(f.read())
    return data


def compare():
    old_refdex = read_refdex('old-dossier-games-refdex.json')
    new_refdex = read_refdex('../Chrysoberyl/misc-refdex/sgon-refdex.json')

    # # new not in old
    # for k, v in new_refdex.items():
    #     if k not in old_refdex:
    #         print(k)

    # old not in new
    for k, v in old_refdex.items():
        if k not in new_refdex:
            print(k)


if __name__ == '__main__':
    compare()
