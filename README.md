# 🔧Necessary pack:

I thought you should know before I let you download it:

`````````
　 　　/ﾞﾐヽ､,,_\_\_,,／ﾞヽ
　 　　i ノ　　 川　 ｀ヽ
　 　　/　｀　◉　 ．◉ i､
　 　彡,　　 ミ(_,人\_)彡ミ
∩, 　/　ヽ､,　　 　　　ノ
丶ニ|　　　 ````````´　ﾉ
　　∪⌒∪￣￣￣∪

## skhd

      skhd is a simple hotkey daemon for macOS that allows you to define global and application-specific keyboard shortcuts. It is highly customizable and is often used in conjunction with window managers like yabai to enhance productivity by providing quick and efficient keyboard navigation.

## yabai

      yabai is a tiling window manager for macOS that makes it possible to control and manage application windows with a high degree of customization and flexibility. It allows users to arrange windows automatically in various layouts, similar to tiling window managers on Linux, and is designed to be scriptable and integrated with other tools like skhd.

## sketchybar

      sketchybar is a customizable status bar for macOS that provides a highly configurable and scriptable interface to display information like system stats, application notifications, and more. It’s designed to be minimal and lightweight, allowing users to tailor the bar to fit their workflow and aesthetic preferences.
`````````

## Let's download it:

```bash
    brew install lua yabai skhd
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

## fonts

```bash
    cd dotfile
    ./font.sh
```

## CLI tool to print CPU and GPU temperature of macOS

```bash
   git clone https://github.com/narugit/smctemp
   cd smctemp
   sudo make install
   cd ..
   sudo rm -rf smctemp
```

# 📖MakeInstall

```bash
    cd dotfile/sketchybar/helpers
    make
```

# 🎯config setting

cd into dotfile and run the shell script,it will ask you if you want to overwrite your local config, only for yabai & skhd & sketchybar:

```bash
   ./config.sh
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

1. lazynvim's symbol only works on nerdfonts > V3.0, same for yazi
2. remember to hide MacOs bar
   ![Local Image](./MacBar.png "Example of how")
3. I am using 4K Dynamic Wallpaper
   ![Local Image](./Wallpaper.png "My Wallpaper")
4. The Font I am Using is "Terminess Nerd Font Mono"
5. I highly recommend adjusting the transparency of iTerm.
   ![Local Image](./ITerm.png "My ITerm")
6. If you are good at CSS, I recommend to try "Arc Browser"
