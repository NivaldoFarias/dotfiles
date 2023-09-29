## Shortcuts

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

# Get current IP
alias ip="curl -s ipinfo.io | jq -r '.ip'"

# List current IP details
alias ipl="ifconfig | grep -Eo 'inet (addr:)?([0-9]*\.){3}[0-9]*' | grep -Eo '([0-9]*\.){3}[0-9]*' | grep -v '127.0.0.1'"

# Miscellaneous
alias hosts="sudo $EDITOR /etc/hosts"
alias quit="exit"
alias week="date +%V"
alias speedtest="wget -O /dev/null http://speed.transip.nl/100mb.bin"

## Functions

# Create a new directory and enter it
mk() {
  mkdir -p "$@" && cd "$@"
}

# Show disk usage of current folder, or list with depth
duf() {
  du --max-depth=${1:-0} -c | sort -r -n | awk '{split("K M G",v); s=1; while($1>1024){$1/=1024; s++} print int($1)v[s]"\t"$2}'
}

# Get gzipped file size
gz() {
  local ORIGSIZE=$(wc -c < "$1")
  local GZIPSIZE=$(gzip -c "$1" | wc -c)
  local RATIO=$(echo "$GZIPSIZE * 100/ $ORIGSIZE" | bc -l)
  local SAVED=$(echo "($ORIGSIZE - $GZIPSIZE) * 100/ $ORIGSIZE" | bc -l)
  printf "orig: %d bytes\ngzip: %d bytes\nsave: %2.0f%% (%2.0f%%)\n" "$ORIGSIZE" "$GZIPSIZE" "$SAVED" "$RATIO"
}

# Get IP from hostname
hostname2ip() {
  ping -c 1 "$1" | egrep -m1 -o '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}'
}