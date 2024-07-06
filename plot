#!/usr/bin/env python3
# -*- coding: utf-8 -*-

"""
Write_description_and_usage_example_here
"""

import argparse
import csv
import logging
import re
import sys
from datetime import datetime
import pandas as pd

import matplotlib.pyplot as plt

LOG = logging.getLogger()
LOG.setLevel("INFO")
formatter = logging.Formatter("%(asctime)s - %(levelname)s - %(message)s")
ch = logging.StreamHandler()
ch.setFormatter(formatter)
LOG.addHandler(ch)


def parse_args():
    parser = argparse.ArgumentParser(
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "-d",
        "--debug",
        action="store_true",
        help="enable debug logging information",
    )
    parser.add_argument(
        "--discard-rows",
        help="don't process these rows"
    )
    parser.add_argument(
        "--discard-cols",
        help="don't process these rows"
    )
    parser.add_argument(
        "-t",
        "--title",
        default='Graph Title',
        help="graph title"
    )
    parser.add_argument("files", nargs="*", help="graph these files or stdin if no files are provided")
    args = parser.parse_args()
    if args.debug:
        LOG.setLevel(logging.DEBUG)
    return args


def plotdata(filehandle, graphtitle, discard_rows=None, discard_cols=None):
    data = pd.read_csv(filehandle)

    if discard_cols:
        for col in data.columns:
            if discard_cols.match(col):
                data.drop(col, axis=1, inplace=True)

    if discard_rows:
        for row in data.iterrows():
            if discard_rows.match(row[1].iloc[0]):
                data.drop(row[0], axis=0, inplace=True)


    #firstrow = ["x-axis", "y-axis"]


    # Extract dates and values
    #dates = [datetime.strptime(row[0], "%Y-%m-%d") for row in data]
    #values = [[float(val if val != "" else 0) for val in row[1:]] for row in data if discard_rows.match(row[0])]

    fig, ax = plt.subplots(figsize=(12, 6))

    data.plot(x=data.columns[0], y=data.columns[1:],  kind='line', marker='o', linestyle='-', ax=ax)

    # Plot the data
    plt.xlabel(data.columns[0])
    plt.ylabel(data.columns[1:])
    plt.title(graphtitle)
    ax.legend(loc='upper left', bbox_to_anchor=(.95,0.9))
    plt.show()


def main():
    args = parse_args()

    discard_rows = re.compile(args.discard_rows) if args.discard_rows else None
    discard_cols = re.compile(args.discard_cols) if args.discard_cols else None

    if len(args.files) > 0:
        for input_file in args.files:
            with open(input_file) as f:
                plotdata(f, args.title, discard_rows, discard_cols)
    else:
        plotdata(sys.stdin, args.title, discard_rows, discard_cols)


if __name__ == "__main__":
    main()
