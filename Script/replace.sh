#!/bin/bash

# Define old and new style strings
old_strings=(
  "Subtitle,Roboto Medium,52,&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2.6,0,2,20,20,46,1"
  "Subtitle-2,Roboto Medium,52,&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2.6,0,2,20,20,46,1"
  "Subtitle-2,Roboto Medium,44,&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2.6,0,2,20,20,46,1"
  "Subtitle-3,Roboto Medium,52,&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2.6,0,2,20,20,46,1"
  "Subtitle-4,Roboto Medium,44,&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2.6,0,2,20,20,46,1"
  "Song,Roboto Medium,44,&H00FFFFFF,&H00FFFFFF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,2.6,0,2,20,20,46,1"
)
new_strings=(
  "Subtitle,Trebuchet MS,48,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,4,2,2,20,20,36,1"
  "Subtitle-2,Trebuchet MS,48,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,4,2,2,20,20,36,1"
  "Subtitle-2,Trebuchet MS,48,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,4,2,8,20,20,36,1"
  "Subtitle-3,Trebuchet MS,48,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,4,2,2,20,20,36,1"
  "Subtitle-4,Trebuchet MS,48,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,0,0,0,100,100,0,0,1,4,2,8,20,20,36,1"
  "Song,Trebuchet MS,48,&H00FFFFFF,&H000000FF,&H00000000,&H00000000,0,-1,0,0,100,100,0,0,1,4,2,2,20,20,36,1"
)

# Prompt user for input file or directory
read -p "Enter Input File or Directory to Replace Subtitles: " input

# Check if input is a directory
if [[ -d "$input" ]]; then
  # Iterate over all .ass files in the directory
  for input_file in "$input"/*.ass; do
    # Make a backup copy of the input file
    cp "$input_file" "${input_file}.bak"
    # Loop over input file and replace old style strings with new style strings
    while IFS= read -r line; do
      # Check if line contains an old style string
      for i in "${!old_strings[@]}"; do
        if [[ "$line" == *"${old_strings[$i]}"* ]]; then
          # Replace old style string with corresponding new style string
          new_line="${line//${old_strings[$i]}/${new_strings[$i]}}"
          line="$new_line"
        fi
      done
      # Write modified line to file
      echo "$line" >> "${input_file}.new"
    done < "$input_file"
    # Replace input file with modified file
    mv "${input_file}.new" "$input_file"
    # Remove backup file
    rm "${input_file}.bak"
  done
# Check if input is a file
elif [[ -f "$input" ]]; then
  # Make a backup copy of the input file
  cp "$input" "${input}.bak"
  # Loop over input file and replace old style strings with new style strings
  while IFS= read -r line; do
    # Check if line contains an old style string
    for i in "${!old_strings[@]}"; do
      if [[ "$line" == *"${old_strings[$i]}"* ]]; then
        # Replace old style string with corresponding new style string
        new_line="${line//${old_strings[$i]}/${new_strings[$i]}}"
        line="$new_line"
      fi
    done
    # Write modified line to file
    echo "$line" >> "${input}.new"
  done < "$input"
  # Replace input file with modified file
  mv "${input}.new" "$input"
  # Remove backup file
  rm "${input}.bak"
else
  # Exit with an error message if input is not a file or directory
  echo "Error: $input is not a valid file or directory"
  exit 1
fi