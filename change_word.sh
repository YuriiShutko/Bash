#!/bin/bash

# Hide errors
exec 2>/dev/null

new_word=$1
word_to_change=$2
path=$3

# Check if path exists
check_path=$(ls "$3")
if [ $new_word ] && [ $word_to_change ] && [ $path ]
then
  if [ ! $check_path ]
  then
    echo "Such path not exists!"
    exit
  fi
  # Use our commands for each file in folder,recursively
  for file in $(find $path -type f)
  do
    echo ""
    printf "Do you want to change $new_word to $word_to_change in $file? (Y/N): "
    read user_choice
    if [ $user_choice = "Y" ] || [ $user_choice = "y" ]
    then
      # sed - text editor, that provides us to change some word
      sed -i.bak "s/$new_word/$word_to_change/g" "$file"
      # In progress it creates a temporary file *.bak that provide to make changes using our main file.
      # Next command will delete it.
      rm "$file.bak"
      echo "$file was changed"
    else
      continue
    fi
  done
else
  echo "One or several parameters are not provided!"
fi


