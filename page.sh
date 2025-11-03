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
README="$(cat _README.md | sed -E 's/\{\{([a-z_,]+?)\}\}/${\1}/g')"
eval "echo \"$README\"" > README.md
T_=$'\u0009'
FMT() {
	echo "$(eval echo "$1")"
}
log() {
	echo "$(FMT "$1")" >> README.md
}
DATA="$(cat "data.json")"
echo "# Powers" >> README.md
while IFS= read -r a_; do
	N_=$(($(jq -c ".key" <<< "$a_")+1))
	TIER=$(jq -r ".value" <<< "$a_")
	log "\\#\\# Tier-$N_:"
	while IFS= read -r POWER; do
		NAME="$(jq -r ".key" <<< "$POWER")"
		DETAILS="$(jq -r ".value" <<< "$POWER")"
		log "\\#\\#\\# $NAME:"
		indent+=$T_
		EL=$(echo "$DETAILS" | jq -r ".element")
		log "- Element: **$EL**"
		VUL="$(echo "$DETAILS" | jq -r ".vulnerability")"
		log "- Vulnerability: **$VUL**"
		log "- Powers:"
		while IFS= read -r ABILITY; do
			echo "$T_- **$ABILITY**" >> README.md
		done < <(jq -r ".powers[]" <<< "$DETAILS")
	done < <(jq -c "to_entries[]" <<< "$TIER")
done < <(jq -c "to_entries[]" <<< "$DATA")
font="Noto Sans"
STYLE=$(cat << EOF
@import url("https://fonts.googleapis.com/css2?family=Noto+Sans:ital,wght@0,100..900;1,100..900&display=swap");
body {
	font: 20pt "$font", sans-serif
}
EOF
)
STYLE="<style>$(node -e "console.log(require(\"sass\").compileString(\`$STYLE\`).css)")</style>"
echo $STYLE > index.md
cat "README.md" >> index.md
cat index.md > index.html
echo "$(cat index.html | sed -E 's/`/\\`/g')" > index.html
INDEX="$(cat index.html | sed -E 's/ / /g')"
echo "$(node -e "(async()=>{await import(\"marked\").then(marked=>console.log(marked.parse(\`$INDEX\`.replace(/\`/g,\"\\\`\").replace(/\"/g,\"\\\"\"))))})()")" > index.html
INDEX="$(cat index.html)"
INDEX="console.log(\`"$INDEX"\`.normalize(\"NFD\"))"
INDEX="$(node -e "$INDEX")"
echo $INDEX > index.html