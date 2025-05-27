#!/usr/bin/env bash

FILE="$1"

#检查prettier是否存在
if ! command -v prettier &> /dev/null; then
  echo "Error:prettier not found"
  echo "npm install -g prettier"
  exit 1
fi

#检查文件是否存在
if [ ! -f "$FILE" ]; then
  echo "Error:file $FILE not found"
  exit 1
fi

prettier --tab-width 4 --use-tabs false --write "${FILE}"
