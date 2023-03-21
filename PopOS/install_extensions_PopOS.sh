#!/bin/bash

#------------------------------------------------------------------
#Extraindo as extenções para a pasta correta
#------------------------------------------------------------------
var=$(pwd)

unzip $var/extencoes_gnome42/arcmenuarcmenu.com.v44.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/arcmenu@arcmenu.com

unzip $var/extencoes_gnome42/ControlBlurEffectOnLockScreenpratap.fastmail.fm.v19.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/ControlBlurEffectOnLockScreen@pratap.fastmail.fm

unzip $var/extencoes_gnome42/dash-to-dock-cosmic-halfmexicanhalfamazinggmail.com.v23.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/dash-to-dock-cosmic-@halfmexicanhalfamazing@gmail.com

unzip $var/extencoes_gnome42/gnome-clipboardb00f.github.io.v17.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/gnome-clipboard@b00f.github.io

unzip $var/extencoes_gnome42/just-perfection-desktopjust-perfection.v24.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/just-perfection-desktop@just-perfection

unzip $var/extencoes_gnome42/maximize-to-workspaceraonetwo.github.com.v23.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/maximize-to-workspace@raonetwo.github.com

unzip $var/extencoes_gnome42/mediacontrolscliffniff.github.com.v23.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/mediacontrols@cliffniff.github.com

unzip $var/extencoes_gnome42/openweather-extensionjenslody.de.v118.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/openweather-extension@jenslody.de

unzip $var/extencoes_gnome42/rounded-window-cornersyilozt.v11.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/rounded-window-corners@yilozt

unzip $var/extencoes_gnome42/switchWorkSpacesun.wxggmail.com.v35.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/switchWorkSpace@sun.wxg@gmail.com

unzip $var/extencoes_gnome42/timepp-master.zip -d \
 ~/.local/share/gnome-shell/extensions/timepp@zagortenay333

unzip $var/extencoes_gnome42/unitehardpixel.eu.v70.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/unite@hardpixel.eu

unzip $var/extencoes_gnome42/widgetsaylur.v20.shell-extension.zip -d \
 ~/.local/share/gnome-shell/extensions/widgets@aylur




#------------------------------------------------------------------
#Resetando o GNOME shell
#------------------------------------------------------------------

killall -3 gnome-shell



#------------------------------------------------------------------
#Ativando as extensões
#------------------------------------------------------------------
gnome-extensions enable arcmenu@arcmenu.com
gnome-extensions enable ControlBlurEffectOnLockScreen@pratap.fastmail.fm
gnome-extensions enable dash-to-dock-cosmic-@halfmexicanhalfamazing@gmail.com
gnome-extensions enable gnome-clipboard@b00f.github.io
gnome-extensions enable just-perfection-desktop@just-perfection
gnome-extensions enable maximize-to-workspace@raonetwo.github.com
gnome-extensions enable mediacontrols@cliffniff.github.com
gnome-extensions enable openweather-extension@jenslody.de
gnome-extensions enable rounded-window-corners@yilozt
gnome-extensions enable switchWorkSpace@sun.wxg@gmail.com
gnome-extensions enable timepp@zagortenay333
gnome-extensions enable unite@hardpixel.eu
gnome-extensions enable widgets@aylur


