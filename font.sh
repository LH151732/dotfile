#!/bin/bash

# Array of Nerd Fonts to install
fonts=(
  font-0xproto-nerd-font
  font-3270-nerd-font
  font-agave-nerd-font
  font-anonymice-nerd-font
  font-arimo-nerd-font
  font-aurulent-sans-mono-nerd-font
  font-bigblue-terminal-nerd-font
  font-bitstream-vera-sans-mono-nerd-font
  font-blex-mono-nerd-font
  font-caskaydia-cove-nerd-font
  font-caskaydia-mono-nerd-font
  font-code-new-roman-nerd-font
  font-comic-shanns-mono-nerd-font
  font-commit-mono-nerd-font
  font-cousine-nerd-font
  font-d2coding-nerd-font
  font-daddy-time-mono-nerd-font
  font-dejavu-sans-mono-nerd-font
  font-droid-sans-mono-nerd-font
  font-envy-code-r-nerd-font
  font-fantasque-sans-mono-nerd-font
  font-fira-code-nerd-font
  font-fira-mono-nerd-font
  font-geist-mono-nerd-font
  font-go-mono-nerd-font
  font-gohufont-nerd-font
  font-hack-nerd-font
  font-hasklug-nerd-font
  font-heavy-data-nerd-font
  font-hurmit-nerd-font
  font-im-writing-nerd-font
  font-inconsolata-go-nerd-font
  font-inconsolata-lgc-nerd-font
  font-inconsolata-nerd-font
  font-intone-mono-nerd-font
  font-iosevka-nerd-font
  font-iosevka-term-nerd-font
  font-iosevka-term-slab-nerd-font
  font-jetbrains-mono-nerd-font
  font-lekton-nerd-font
  font-liberation-nerd-font
  font-lilex-nerd-font
  font-m+-nerd-font
  font-martian-mono-nerd-font
  font-meslo-lg-nerd-font
  font-monaspace-nerd-font
  font-monocraft-nerd-font
  font-monofur-nerd-font
  font-monoid-nerd-font
  font-mononoki-nerd-font
  font-noto-nerd-font
  font-open-dyslexic-nerd-font
  font-overpass-nerd-font
  font-profont-nerd-font
  font-proggy-clean-tt-nerd-font
  font-recursive-mono-nerd-font
  font-roboto-mono-nerd-font
  font-sauce-code-pro-nerd-font
  font-shure-tech-mono-nerd-font
  font-space-mono-nerd-font
  font-symbols-only-nerd-font
  font-terminess-ttf-nerd-font
  font-tinos-nerd-font
  font-ubuntu-mono-nerd-font
  font-ubuntu-nerd-font
  font-ubuntu-sans-nerd-font
  font-victor-mono-nerd-font
  font-zed-mono-nerd-font
)

# Loop through the array and install each font
for font in "${fonts[@]}"; do
  brew install --cask "$font"
done
