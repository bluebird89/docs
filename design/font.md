# Font

* [cascadia-code](https://github.com/microsoft/cascadia-code):This is a fun, new monospaced font that includes programming ligatures and is designed to enhance the modern look and feel of the Windows Terminal.
* [FiraCode](https://github.com/tonsky/FiraCode):Monospaced font with programming ligatures
* [JetBrains Mono](https://www.jetbrains.com/lp/mono/)
* [Source Code Pro](https://github.com/adobe-fonts/source-code-pro/):Monospaced font family for user interface and coding environments
* [Space Mono](https://fonts.google.com/specimen/Space+Mono)
* [inter](https://github.com/rsms/inter):The Inter UI font family <http://rsms.me/inter/>
* [nerd-fonts](https://github.com/ryanoasis/nerd-fonts#option-3-install-script):Iconic font aggregator, collection, & patcher. 3,600+ icons, 50+ patched fonts: Hack, Source Code Pro, more. Glyph collections: Font Awesome, Material Design Icons, Octicons, & more <https://NerdFonts.com>
* [Font-Awesome](https://github.com/FortAwesome/Font-Awesome):The iconic font and CSS toolkit <https://fontawesome.com/>
* [powerline](https://github.com/powerline/fonts):Patched fonts for Powerline users.
* [operator-mono-lig](https://github.com/kiliman/operator-mono-lig):Add ligatures to Operator Mono similar to Fira Code
* [google](https://github.com/google/fonts):Font files available from Google Fonts <https://fonts.google.com>
* [powerline](https://github.com/powerline/fonts):Patched fonts for Powerline users.
* [iconfont](https://www.iconfont.cn/)
* [visualhunt](https://visualhunt.com/)
* font-hack-nerd-font

```sh
sudo apt install fonts-firacode

# validate font support
echo "\ue0b0 \u00b1 \ue0a0 \u27a6 \u2718 \u26a1 \u2699"

# somre font not support powerline
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf

mv PowerlineSymbols.otf ~/.local/share/fonts/
fc-cache -vf ~/.local/share/fonts/
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
```

## 工具

* [fonttools](https://github.com/fonttools/fonttools):A library to manipulate font files from Python.

## theme

* [dracula-theme](https://github.com/dracula/dracula-theme):😱 A dark theme for all the things! <https://draculatheme.com>
