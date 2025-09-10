#!/bin/bash
echo "Pick an option:"
echo "1) A"
echo "2) B"
echo "3) C"
echo "4) D"
read -n1 -s C
echo
case $C in
    1)
        S="A";;
    2)
        S="B";;
    3)
        S="C";;
    4)
        S="D";;
    *)
        echo "Invalid choice";
        exit 1;;
esac
echo "You picked: $S"
