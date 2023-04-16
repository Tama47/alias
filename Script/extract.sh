#!/bin/bash

read -p "Enter Input File or Directory to Extract Subtitles: " input

if [[ -d "$input" ]]; then
  # If the input is a directory
  for input_file in "$input"/*.mkv; do
    output="${input_file%.*}.eng.ass"
    ffmpeg -i "$input_file" -map 0:s:0 "$output"
  done
elif [[ -f "$input" ]]; then
  # If the input is a file
  output="${input%.*}.eng.ass"
  ffmpeg -i "$input" -map 0:s:0 "$output"
else
  echo "Invalid input: $input is not a file or a directory"
  exit 1
fi
