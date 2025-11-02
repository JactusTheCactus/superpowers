#!/usr/bin/env bash
set -euo pipefail
flag() {
	for f in "$@"; do
		[[ -e ".flags/$f" ]] || return 1
	done
}
OUT="logs"
THORN=$'\u00de'
thorn=$'\u00fe'
primaryPower() {
	clear
	cat << EOF
Pick A Primary Power

Tier-3
	1) Petra
	2) Ignis
	3) ${THORN}alass
	4) Anemos

Tier-2
	5) Tonit

Tier-1
	6) Solis
	7) Skia
EOF
	read -n1 -s i
	case $i in
		1) X="Petra";;
		2) X="Ignis";;
		3) X="${THORN}alass";;
		4) X="Anemos";;
		5) X="Tonit";;
		6) X="Solis";;
		7) X="Skia";;
		*) echo "Invalid Choice: $i";	primaryPower;;
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
	cat << EOF
Pick A Primary Rank

1) I
2) II
3) III
4) IV
5) V
6) VI
7) VII
8) VIII
9) IX
0) X
-) XI
=) XII
EOF
	read -n1 -s i
	case $i in
		1) Y="I";		Y0="01";;
		2) Y="II";		Y0="02";;
		3) Y="III";		Y0="03";;
		4) Y="IV";		Y0="04";;
		5) Y="V";		Y0="05";;
		6) Y="VI";		Y0="06";;
		7) Y="VII";		Y0="07";;
		8) Y="VIII";	Y0="08";;
		9) Y="IX";		Y0="09";;
		0) Y="X";		Y0="10";;
		-) Y="XI";		Y0="11";;
		=) Y="XII";		Y0="12";;
		*)	echo "Invalid Choice: $i";
			primaryRank;;
	esac
	Y0="${Y0#0}"
}
secondaryPower() {
	clear
	cat << EOF
Pick A Secondary Power

Tier-3
	1) Petra
	2) Ignis
	3) ${THORN}alass
	4) Anemos

Tier-2
	5) Tonit

Tier-1
	6) Solis
	7) Skia
EOF
	read -n1 -s i
	case $i in
		1) Z="Petra";;
		2) Z="Ignis";;
		3) Z="${THORN}alass";;
		4) Z="Anemos";;
		5) Z="Tonit";;
		6) Z="Solis";;
		7) Z="Skia";;
		*) echo "Invalid Choice: $i";
			secondaryPower;;
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
	ID="$X0$Y0$Z0"
	FILE="$X0${Y0}_$Z0"
	FILE="${FILE^^}"
	mkdir -p $OUT
	clear
	cat << EOF
Your powers are:
$X $Y & $Z
ID:[$ID]
EOF
	cat << EOF > "$OUT/$FILE.yml"
id: $ID
powers:
  primary:
    name: $X
    rank:
      - $Y
      - $Y0
  secondary:
    name: $Z
EOF
}
if flag local; then
	rm -rf logs
	main
else
	:
fi
./page.sh