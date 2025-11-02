#!/usr/bin/env bash
set -euo pipefail
flag() {
	for f in "$@"; do
		[[ -e ".flags/$f" ]] || return 1
	done
}
__=$'\u0323'
t=$'\u00FE'
T="${t^}"
a=$'\u00E6'
A="${a^}"
s=$'\u017F'
S="${s^}"
o=$'\u00F3'
O="${o^}"
i=$'\u00ED'
I="${i^}"
solis="${S}o${__}li$s"
solis_="${solis:1:1}"
solis_="${solis_^}"
skia="${S}k$i${__}a"
skia_="${skia:1:1}"
skia_="${skia_^}"
tonit="To${__}nit"
tonit_="${tonit:0:1}"
petra="Pe${__}tra"
petra_="${petra:0:1}"
ignis="I${__}gni$s"
ignis_="${ignis:0:1}"
talas="$T$a${__}l$a$s"
talas_="${talas:0:1}"
anemos="$A${__}nem$o$s"
anemos_="${anemos:0:1}"
exec > README.md
cat << EOF
All super powered individuals are sorted by two stats; Their power, and the strength of that power. There are SEVEN different classifications of power one can have; $petra, $ignis, $talas, $anemos, $tonit, $solis, $skia. These powers are divided into three tiers, each rarer than the last:
- Tier-2 is 100 times rarer than Tier-3
- Tier-1 is 100 times rarer than Tier-2
- Tier-1 is 10,000 times rarer than Tier-3

Each power can be ranked from 1-10, using roman numerals, with \`X\` being the strongest, and \`I\` being the weakest. Powers can also be shown as an initial and a rank. Here are some examples:
- $petra I / ${petra_}1
- $ignis II / ${ignis_}2
- $talas III / ${talas_}3
- $anemos IV / ${anemos_}4
- $tonit V / ${tonit_}5
- $solis VI / ${solis_}6
- $skia VII / ${skia_}7

An individuals class and rank is written into their genetics and, thus, cannot be changed. The rarity of being born a certain rank is logarithmic, i.e:
- II is 10 times rarer than I
- IV is 100 times rarer than II
- VII is 1,000 times rarer than IV

Those with higher ranks often heavily rely on their strength, while lower ranks are forced to be smart or creative, making lower ranks often a misnomer.

Powers each have a symbol that is, generally, the first initial:
- $petra_: $petra
- $ignis_: $ignis
- $talas_: $talas
- $anemos_: $anemos
- $tonit_: $tonit
- $solis_: $solis
- $skia_: $skia

It is common to have a secondary power, so that symbol will follow the strength of the first in lowercase form:
- ${petra_}1${anemos_}
- ${ignis_}2${tonit_}
- ${talas_}3${solis_,}
- ${anemos_}4${skia_,}
- ${tonit_}5${petra_,}
- ${solis_}6${ignis_,}
- ${skia_}7${talas_,}
EOF
indent=""
T_="  "
FMT() {
	echo "$(eval echo "$1")"
}
log() {
	echo "$indent$(FMT "$1")"
}
DATA="$(cat "data.json")"
echo "# Powers"
echo \`\`\`yml
while IFS= read -r a_; do
	indent=""
	N_=$(($(jq -c ".key" <<< "$a_")+1))
	TIER=$(jq -r ".value" <<< "$a_")
	log "Tier-$N_:"
	while IFS= read -r POWER; do
		indent=$T_
		NAME="$(jq -r ".key" <<< "$POWER")"
		DETAILS="$(jq -r ".value" <<< "$POWER")"
		log "$NAME:"
		indent+=$T_
		EL=$(echo "$DETAILS" | jq -r ".element")
		log "Element: $EL"
		VUL="$(echo "$DETAILS" | jq -r ".vulnerability")"
		log "Vulnerability: $VUL"
		log "Powers:"
		indent+=$T_
		while IFS= read -r ABILITY; do
			log "- $ABILITY"
		done < <(jq -r ".powers[]" <<< "$DETAILS")
	done < <(jq -c "to_entries[]" <<< "$TIER")
done < <(jq -c "to_entries[]" <<< "$DATA")
echo \`\`\`
cat << EOF > index.md
<style>
@import url('https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&family=Noto+Sans+Mono:wght@100..900&display=swap');
body {
	font: 20pt "Noto Sans", sans-serif
}
code {
	font: 1em "Noto Sans Mono", monospace
}
</style>
$(cat "README.md")
EOF
INDEX=$(cat "index.md")
INDEX="${INDEX//\`/\\\`}"
INDEX="${INDEX//  /$'\t'}"
SCRIPT="console.log(\`"$INDEX"\`.normalize(\"NFD\"))"
node -e "$SCRIPT" > index.md