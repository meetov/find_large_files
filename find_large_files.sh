#!/bin/sh
## Usage: find_large_files START_DIR [LIMIT]
## Description: Find large files up to LIMIT and display them to stdout.
## Author: Mario Mitov

SCRIPT_NAME=$(basename $0)
START_DIR=$1
LIMIT=$2
DEFAULT_LIMIT=10

if [ ! $START_DIR ]; then
	echo "Usage: $SCRIPT_NAME START_DIR [LIMIT]"
	exit 1
fi

if [ ! $LIMIT ]; then
	LIMIT=$DEFAULT_LIMIT
fi

find $START_DIR -type f -exec du -hs {} \;  2>/dev/null | sort -h | tail -n $LIMIT
