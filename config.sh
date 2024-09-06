#!/bin/bash

echo "If you do this, it will overwrite your 'ybai', 'sketchybar', 'skhd' config. Do you wish to continue? (Y/N)"
read -r answer

if [[ "$answer" == "Y" || "$answer" == "y" ]]; then
  echo "Continuing with the operation..."
  cp -i -r 'yabai' 'sketchybar' ~/.config/
  cp -i 'skhdrc' ~/.skhdrc
else
  echo "Operation cancelled."
fi
