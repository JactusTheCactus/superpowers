#!/bin/bash
OUT="logs"
THORN=$'\u00de'
thorn=$'\u00fe'
primaryPower() {
	clear
	echo "Pick A Primary Power"
	echo
	echo "Tier-3"
	echo -e "\t1) Petra"
	echo -e "\t2) Ignis"
	echo -e "\t3) ${THORN}alass"
	echo -e "\t4) Anemos"
	echo
	echo "Tier-2"
	echo -e "\t5) Tonit"
	echo
	echo "Tier-1"
	echo -e "\t6) Solis"
	echo -e "\t7) Skia"
	read -n1 -s i
	case $i in
		1)	X="Petra";;
		2)	X="Ignis";;
		3)	X="${THORN}alass";;
		4)	X="Anemos";;
		5)	X="Tonit";;
		6)	X="Solis";;
		7)	X="Skia";;
		*)	echo "Invalid Choice: $i";	primaryPower;;
	esac
	if [[ "${X:0:1}" == "S" ]]; then
		X0="${X:1:1}"
	else
		X0="${X:0:1}"
	fi
	X0="${X0^}"
}
primaryRank() {
	clear
	echo "Pick A Primary Rank"
	echo
	echo "1) I"
	echo "2) II"
	echo "3) III"
	echo "4) IV"
	echo "5) V"
	echo "6) VI"
	echo "7) VII"
	echo "8) VIII"
	echo "9) IX"
	echo "0) X"
	echo "-) XI"
	echo "=) XII"
	read -n1 -s i
	case $i in
		1)	Y="I";		Y0="01";;
		2)	Y="II";		Y0="02";;
		3)	Y="III";	Y0="03";;
		4)	Y="IV";		Y0="04";;
		5)	Y="V";		Y0="05";;
		6)	Y="VI";		Y0="06";;
		7)	Y="VII";	Y0="07";;
		8)	Y="VIII";	Y0="08";;
		9)	Y="IX";		Y0="09";;
		0)	Y="X";		Y0="10";;
		-)	Y="XI";		Y0="11";;
		=)	Y="XII";	Y0="12";;
		*)	echo "Invalid Choice: $i";	primaryRank;;
	esac
}
secondaryPower() {
	clear
	echo "Pick A Secondary Power"
	echo
	echo "Tier-3"
	echo -e "\t1) Petra"
	echo -e "\t2) Ignis"
	echo -e "\t3) ${THORN}alass"
	echo -e "\t4) Anemos"
	echo
	echo "Tier-2"
	echo -e "\t5) Tonit"
	echo
	echo "Tier-1"
	echo -e "\t6) Solis"
	echo -e "\t7) Skia"
	read -n1 -s i
	case $i in
		1)	Z="Petra";;
		2)	Z="Ignis";;
		3)	Z="${THORN}alass";;
		4)	Z="Anemos";;
		5)	Z="Tonit";;
		6)	Z="Solis";;
		7)	Z="Skia";;
		*)	echo "Invalid Choice: $i";	secondaryPower;;
	esac
	if [[ "${Z:0:1}" == "S" ]]; then
		Z0="${Z:1:1}"
	else
		Z0="${Z:0:1}"
	fi
	Z0="${Z0,}"
}
main() {
	primaryPower
	primaryRank
	secondaryPower
	ID="$X0:$Y0|$Z0"
	FILE="$X0$Y0$Z0"
	FILE="${FILE^^}"
	clear
	mkdir -p $OUT
	echo -e "Your powers are:\n$X $Y & $Z\nID:[$ID]"
	echo "ID:[$ID]" > "$OUT/$FILE.txt"
}
main