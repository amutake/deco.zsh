deco.zsh
========

Enjoy your CUI life with text-decoration!


Examples
--------

```
deco -f red -b 233 -u -B foobar                # print decorated 'foobar'
echo "foobar" | deco -f red -b 233 -u -B       # can also be used with pipe
echo "$(deco -f red red)$(deco -f blue blue)"  # 'reset' command is not needed unlike zsh buildin 'colors' or 'tput' etc
```


Options
-------

### `-f, --fg, --foreground <color>`

Set foreground color. Available `<color>` attributes are the followings.

- `default`
- `black`, `red`, `green`, `yellow`, `blue`, `magenta`, `cyan`, `white`
- `bright-black`, `bright-red`, `bright-green`, `bright-yellow`, `bright-blue`, `bright-magenta`, `bright-cyan`, `bright-white`
- 0 to 255

### `-b, --bg, --background <color>`

Set background color. See `--foreground` section for available `<color>` attributes.

### `-u, --underline`

Draw underline.

### `-B, --blink`

Blink text.

### `-r, --reverse`

Reverse foreground color and background color.

### `-n, --no-newline`

Print text without newline.

### `-h, --help`

Show help text and exit.

### `-v, --version`

Show the version and exit.


Installation
------------

### Antigen

```
antigen bundle amutake/decorate.zsh
antigen apply
```

### Manual Installation

```
git clone git://github.com/amutake/deco.zsh
source /path/to/deco.zsh/deco.plugins.zsh # edit your .zshrc and put this line
```


License
-------

MIT


Reference
---------

- https://en.wikipedia.org/wiki/ANSI_escape_code#graphics
