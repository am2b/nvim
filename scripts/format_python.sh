#!/usr/bin/env bash

FILE="$1"

#检查isort,black是否存在
if ! command -v isort &> /dev/null; then
  echo "Error:isort not found"
  exit 1
fi

if ! command -v black &> /dev/null; then
  echo "Error:black not found"
  exit 1
fi

#检查文件是否存在
if [ ! -f "$FILE" ]; then
  echo "Error:file $FILE not found"
  exit 1
fi

isort "${FILE}"
black "${FILE}"
