__deco_version="0.1.0"

# <color> -> <integer>
__deco_foreground_color_number() {
  case $1 in
    default) echo 39;;
    black) echo 30;;
    red) echo 31;;
    green) echo 32;;
    yellow) echo 33;;
    blue) echo 34;;
    magenta) echo 35;;
    cyan) echo 36;;
    white) echo 37;;
    bright-black) echo 90;;
    bright-red) echo 91;;
    bright-green) echo 92;;
    bright-yellow) echo 93;;
    bright-blue) echo 94;;
    bright-magenta) echo 95;;
    bright-cyan) echo 96;;
    bright-white) echo 97;;
    *) echo 0;;
  esac
}

# (fg|bg) -> (<color>|<number>) -> <attr>
__deco_build_color() {
  if [[ $2 =~ '^([0-9]|[1-9][0-9]|1[0-9][0-9]|2[0-4][0-9]|25[0-5])$' ]]; then
    if [[ $1 = "fg" ]]; then
      echo "38;5;$2"
    elif [[ $1 = "bg" ]]; then
      echo "48;5;$2"
    fi
  else
    local num=$(__deco_foreground_color_number $2)
    if [[ $1 = "bg" ]]; then
      num=$(($num + 10))
    fi
    echo ${num}
  fi
}

__deco_build_attrs() {
  local attrs="0"
  # foreground color
  if [[ -n ${1[(i)-f]} ]]; then
    local fg=$(__deco_build_color fg ${1[-f]})
    if [[ -n $fg ]]; then
      attrs="$attrs;$fg"
    fi
  fi
  # background color
  if [[ -n ${1[(i)-b]} ]]; then
    local bg=$(__deco_build_color bg ${1[-b]})
    if [[ -n $bg ]]; then
      attrs="$attrs;$bg"
    fi
  fi
  # underline
  if [[ -n ${1[(i)-u]} ]]; then
    attrs="$attrs;4"
  fi
  # blink
  if [[ -n ${1[(i)-B]} ]]; then
    attrs="$attrs;5"
  fi
  # reverse
  if [[ -n ${1[(i)-r]} ]]; then
    attrs="$attrs;7"
  fi
  echo $attrs
}

__deco_help() {
  echo "deco: text-decoration for terminal"
  echo ""
  echo "Usage: deco [options] [text]"
  echo ""
  echo "Options:"
  echo "  -f, --fg, --foreground <color>       set foreground color"
  echo "  -b, --bg, --background <color>       set background color"
  echo "  -u, --underline                      draw underline"
  echo "  -B, --blink                          blink text"
  echo "  -r, --reverse                        swap foreground color and background color"
  echo "  -n, --no-newline                     without newline"
  echo "  -h, --help                           show this help text"
  echo "  -v, --version                        print the version"
}

deco() {
  local -A opts
  zparseopts -D -M -A opts -- \
             f: -fg:=f -foreground:=f \
             b: -bg:=b -background:=b \
             u -underline=u \
             B -blink=B \
             r -reverse=r \
             n -no-newline=n \
             h -help=h \
             v -version=v

  if [[ -n ${opts[(i)-h]} ]]; then
    __deco_help
  elif [[ -n ${opts[(i)-v]} ]]; then
    echo $__deco_version
  else
    local attrs="0"
    # foreground color
    if [[ -n ${opts[(i)-f]} ]]; then
      local fg=$(__deco_build_color fg ${opts[-f]})
      if [[ -n $fg ]]; then
        attrs="$attrs;$fg"
      fi
    fi
    # background color
    if [[ -n ${opts[(i)-b]} ]]; then
      local bg=$(__deco_build_color bg ${opts[-b]})
      if [[ -n $bg ]]; then
        attrs="$attrs;$bg"
      fi
    fi
    # underline
    if [[ -n ${opts[(i)-u]} ]]; then
      attrs="$attrs;4"
    fi
    # blink
    if [[ -n ${opts[(i)-B]} ]]; then
      attrs="$attrs;5"
    fi
    # reverse
    if [[ -n ${opts[(i)-r]} ]]; then
      attrs="$attrs;7"
    fi

    printf "\e[${attrs}m"
    if [[ -t 0 ]]; then
      # not pipe
      printf "$@"
      # no newline
      if [[ -n ${opts[(i)-n]} ]]; then
        printf "\e[0m"
      else
        print "\e[0m"
      fi
    else
      # pipe
      cat
      printf "\e[0m"
    fi
  fi
}
