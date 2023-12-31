#!/bin/bash

## Alises

# List declared aliases
alias aliases="alias | sed 's/=.*//'"

# List declared functions
alias functions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'"

# List declared paths
alias paths='echo -e ${PATH//:/\\n}'

# Run apt update, upgrade, autoclean and autoremove
alias apt-routine="sudo apt update && sudo apt upgrade -y && sudo apt autoclean && sudo apt autoremove -y"

# Open current folder in file explorer
alias file-explorer="xdg-open ."

# List external IP
alias ip="curl -s ipinfo.io | jq -r '.ip'"

# List external, internal and local IP
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Miscellaneous
alias quit="exit"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"

# Directory listing/traversal
alias l="ls -lahA --color -G --time-style=long-iso --group-directories-first"
alias ll="ls -lA --color -G"
alias lt="ls -lhAtr --color -G --time-style=long-iso --group-directories-first"
alias ld="ls -ld --color -G */"
alias lp="stat -c '%a %n' *"

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

## Functions

# Create a new directory and enter it
mk() {
  mkdir -p "$@" && cd "$@" || exit
}

# Show disk usage of current folder, or list with depth
duf() {
  du --max-depth="${1:-0}" -c | sort -r -n | awk '{split("K M G",v); s=1; while($1>1024){$1/=1024; s++} print int($1)v[s]"\t"$2}'
}

# Get gzipped file size
gz() {
  local ORIGSIZE
  local GZIPSIZE
  local RATIO
  local SAVED

  ORIGSIZE=$(wc -c <"$1")
  GZIPSIZE=$(gzip -c "$1" | wc -c)
  RATIO=$(echo "$GZIPSIZE * 100/ $ORIGSIZE" | bc -l)
  SAVED=$(echo "($ORIGSIZE - $GZIPSIZE) * 100/ $ORIGSIZE" | bc -l)

  printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "$ORIGSIZE" "$GZIPSIZE" "$SAVED" "$RATIO"
}

# Get IP from hostname
hostname2ip() {
  ping -c 1 "$1" | grep -E -m1 -o '\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'
}

# Switch to short prompt
ps0() {
  unset PROMPT_COMMAND
  PS1='$ '
}

# Switch to long prompt
ps1() {
  # shellcheck source=/dev/null
  source "$(pwd)"/.prompt
}

# Get named var (usage: get "VAR_NAME")
get() {
  echo "${!1}"
}

# Add to path
prepend-path() {
  [ -d "$1" ] && PATH="$1:$PATH"
}

# Show 256 TERM colors
colors() {
  local X
  local Y

  X=$(tput op)
  Y=$(printf %$((COLUMNS - 6))s)

  for i in {0..256}; do
    o=00$i
    echo -e "${o:${#o}-3:3}" "$(
      tput setaf "$i"
      tput setab "$i"
    )""${Y// /=}""$X"
  done
}

# Calculator
calc() {
  echo "$*" | bc -l
}

# Count the number of files in a directory with a given extension
# if a directory is not specified, the current directory is used
count-files() {
  local EXTENSION
  local DIRECTORY

  EXTENSION=${1:-*}
  DIRECTORY=${2:-.}

  find "$DIRECTORY" -maxdepth 1 -type f -name "$EXTENSION" | wc -l
}

# Count the number of lines in each file for a given extension
# if a directory is not specified, the current directory is used
# print the parsed filename and line count for each file found
count-lines() {
  local EXTENSION
  local DIRECTORY

  EXTENSION=${1:-*}
  DIRECTORY=${2:-.}

  find "$DIRECTORY" -maxdepth 1 -type f -name "$EXTENSION" -exec wc -l {} \;
}

# Show line, optionally show surrounding lines
line() {
  local LINE_NUMBER
  local LINES_AROUND

  LINE_NUMBER=$1
  LINES_AROUND=${2:-0}

  sed -n "$((LINE_NUMBER - LINES_AROUND)),$((LINE_NUMBER + LINES_AROUND))p"
}

# Show duplicate lines
duplines() {
  sort "$1" | uniq -d
}

# Show unique lines
uniqlines() {
  sort "$1" | uniq -u
}

# Generate a specified themed mermaid diagram asset
mermaid-theme() {
  local DIR
  local DARK
  local LIGHT
  local BOTH

  DIR=$(pwd)
  DARK="--dark"
  BOTH="--both"
  LIGHT="--light"

  function dark_diagram() {
    mmdc -i "$DIR"/"$1".mmd -o "$DIR"/"$1"-dark.svg -t dark
    rsvg-convert "$DIR"/"$1"-dark.svg -o "$DIR"/"$1"-dark.png -b black
  }

  function light_diagram() {
    mmdc -i "$DIR"/"$1".mmd -o "$DIR"/"$1".svg -b white
    rsvg-convert "$DIR"/"$1".svg -o "$DIR"/"$1".png -b white
  }

  if [ $# -ge 2 ]; then
    if [ "$2" = "$DARK" ]; then
      dark_diagram "$1"
    elif [ "$2" = "$BOTH" ]; then
      light_diagram "$1"
      dark_diagram "$1"
    elif [ "$2" = "$LIGHT" ]; then
      light_diagram "$1"
    fi
  else
    light_diagram "$1"
  fi
}
