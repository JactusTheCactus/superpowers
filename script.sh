#!/bin/bash

echo "Pick a fruit by pressing 1–4:"
echo "1) Apple"
echo "2) Banana"
echo "3) Cherry"
echo "4) Dragonfruit"
read -n1 -s choice
echo
case $choice in
    1) selected="Apple" ;;
    2) selected="Banana" ;;
    3) selected="Cherry" ;;
    4) selected="Dragonfruit" ;;
    *) echo "Invalid choice"; exit 1 ;;
esac
echo "You picked: $selected"
