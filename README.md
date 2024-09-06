# 🔧nessesary pack:

```bash
    brew install fd ripgrep eza lua yabai skhd
```

## sketchybar:

```bash
    brew tap FelixKratz/formulae
    brew install sketchybar
    mkdir -p ~/.config/sketchybar/plugins
    cp $(brew --prefix)/share/sketchybar/examples/sketchybarrc ~/.config/sketchybar/sketchybarrc
    cp -r $(brew --prefix)/share/sketchybar/examples/plugins/ ~/.config/sketchybar/plugins/
```

## Terminal

iTerm 2 -- optional

## fots

```bash
    cd dotfile
```

```bash
    ./font.sh
```

## CLI tool to print CPU and GPU temperature of macOS

```bash
   git clone https://github.com/narugit/smctemp
   cd smctemp
   sudo make install
```

# 📖MakeInstall

```bash
    cd dotfile/sketchybar/helpers
    make
```

# 🎯config setiing

folder goes to '~/.config'
file goes to '~/'with a '.':

```bash
   cp skhdrc ~/.skhdrc
```

# ⭐Using

switch on:

```bash
    yabai &
    skhd &
    sketchybar &
```

switch off:

```bash
    pgrep yabai
```

then kill the pid

```bash
   kill <yabai's pid>
```

or you can use 'htop' 'top' 'btop' to find and kill the process

# 🌟Additional

1. lazynvim's symbol only works on nerfonts > V3.0, same for yazi
2. remeber to hide MacOs bar
   ![Local Image](./MacBar.png.png "Example of how")
3. I am using 4K Dynamic Wallpaper
   ![Local Image](./Wallpaper.png.png "My Wallpaper")
4. The Font I am Using is "Terminess Nerd Font Mono"
5. I highly recommend adjusting the transparency of iTerm.
   ![Local Image](./ITerm.png "My ITerm")
6. If you are good at CSS, I recommend to try "Arc Browser"

`````````
　 　　/ﾞﾐヽ､,,_\_\_,,／ﾞヽ
　 　　i ノ　　 川　 ｀ヽ
　 　　/　｀　◉　 ．◉ i､
　 　彡,　　 ミ(_,人\_)彡ミ
∩, 　/　ヽ､,　　 　　　ノ
丶ニ|　　　 ````````´　ﾉ
　　∪⌒∪￣￣￣∪
`````````
