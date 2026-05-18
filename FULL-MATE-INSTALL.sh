#!/data/data/com.termux/files/usr/bin/bash

pkg update -y && pkg upgrade -y

pkg install -y \
x11-repo \
termux-x11-nightly \
pulseaudio \
virglrenderer-android \
proot-distro \
wget \
curl \
nano

proot-distro install debian

cat > ~/start-mate.sh << 'EOF'
#!/bin/bash

export DISPLAY=:0
export PULSE_SERVER=127.0.0.1
export XDG_RUNTIME_DIR=${TMPDIR}
pulseaudio --start --exit-idle-time=-1

termux-x11 :0 &

sleep 3

proot-distro login debian --shared-tmp -- bash -c "

apt update && apt upgrade -y

apt install -y \
mate-desktop-environment-core \
mate-applets \
mate-media \
mate-control-center \
mate-themes \
papirus-icon-theme \
arc-theme \
caja \
pluma \
eom \
atril \
engrampa \
mate-terminal \
firefox-esr \
vlc \
htop \
neofetch \
network-manager \
network-manager-gnome \
fonts-dejavu \
fonts-noto \
sudo \
wget \
curl \
git

gsettings set org.mate.interface gtk-theme 'Arc-Dark'
gsettings set org.mate.interface icon-theme 'Papirus-Dark'
gsettings set org.mate.interface font-name 'Sans 14'
gsettings set org.mate.interface document-font-name 'Sans 14'
gsettings set org.mate.interface monospace-font-name 'Monospace 13'
gsettings set org.mate.interface toolbar-icons-size 'large'

gsettings set org.mate.background picture-filename '/usr/share/backgrounds/mate/desktop/Ubuntu-Mate-Dark-no-logo.png'

gsettings set org.mate.panel.menubar icon-name 'debian-logo'

echo 'Europe/Oslo' > /etc/timezone
ln -sf /usr/share/zoneinfo/Europe/Oslo /etc/localtime

killall mate-panel marco caja 2>/dev/null

mate-panel &
marco --no-composite --replace &
caja &

mate-session
"
EOF

chmod +x ~/start-mate.sh

echo
echo "DONE!"
echo
echo "START DESKTOP WITH:"
echo
echo "bash ~/start-mate.sh"
