#!/bin/bash

# This script provides common customization options for the ISO
# 
# Usage: Copy this file to config.sh and make changes there.  Keep this file (default_config.sh) as-is
#   so that subsequent changes can be easily merged from upstream.  Keep all customiations in config.sh

# The version of Ubuntu to generate.  Successfully tested: bionic, cosmic, disco, eoan, focal, groovy
# See https://wiki.ubuntu.com/DevelopmentCodeNames for details
export TARGET_UBUNTU_VERSION="jammy"

# The Ubuntu Mirror URL. It's better to change for faster download.
# More mirrors see: https://launchpad.net/ubuntu/+archivemirrors
export TARGET_UBUNTU_MIRROR="http://mirrors.ustc.edu.cn/ubuntu/"

# The packaged version of the Linux kernel to install on target image.
# See https://wiki.ubuntu.com/Kernel/LTSEnablementStack for details
export TARGET_KERNEL_PACKAGE="linux-generic"

# The file (no extension) of the ISO containing the generated disk image,
# the volume id, and the hostname of the live environment are set from this name.
export TARGET_NAME="ubuntu"

# The text label shown in GRUB for booting into the live environment
export GRUB_LIVEBOOT_LABEL="Try Ubuntu without installing"

# The text label shown in GRUB for starting installation
export GRUB_INSTALL_LABEL="Install Ubuntu"

# Packages to be removed from the target system after installation completes succesfully
export TARGET_PACKAGE_REMOVE="
    ubiquity \
    casper \
    discover \
    laptop-detect \
    os-prober \
"

# Package customisation function.  Update this function to customize packages
# present on the installed system.
function customize_image() {
    # install graphics and desktop
    apt-get install -y \
    plymouth-theme-ubuntu-logo \
    ubuntu-gnome-desktop \
    ubuntu-gnome-wallpapers \
    unity-control-center

    # useful tools
    apt-get install -y \
    clamav-daemon \
    terminator \
    apt-transport-https \
    curl \
    vim \
    nano \
    less 

    # custom of me
    apt-get install -y --fix-missing \
    git \
    neofetch \
    python3-pip \
    openjdk-8-jdk \
    openjdk-8-jre-headless \
    libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2 \
    libfuse2

    apt-add-repository -y ppa:fish-shell/release-3
    apt install -y fish
    chsh -s /usr/bin/fish

    apt-get install -y fcitx fcitx-frontend-gtk2 fcitx-frontend-gtk3 fcitx-frontend-qt5 fcitx-module-x11
    wget http://rjiicku82.hn-bkt.clouddn.com/sogoupinyin_4.0.1.2800_x86_64.deb -O sogoupinyin.deb
    dpkg -i sogoupinyin.deb
    apt-get install -y fcitx5 fcitx5-frontend-qt5 libfcitx5-qt-data libfcitx5-qt-dev libfcitx5-qt1 libgsettings-qt1 libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2
    rm -f sogoupinyin.deb
    #apt-get install -f -y
    #echo 'GTK_IM_MODULE=fcitx' >> /etc/environment 
    #echo 'QT_IM_MODULE=fcitx' >> /etc/environment 
    #echo 'XMODIFIERS="@im=fcitx"' >> /etc/environment 
    #apt-get purge -y ibus

    # theme ant https://www.gnome-look.org/p/1099856
    #wget http://rjiicku82.hn-bkt.clouddn.com/Ant-slim.tar.xz -O Ant-slim.tar.xz
    wget http://rjiicku82.hn-bkt.clouddn.com/Ant-standard-buttons.tar -O Ant-standard-buttons.tar
    wget http://rjiicku82.hn-bkt.clouddn.com/Ant.tar -O Ant.tar
    #tar -xzf Ant-slim.tar.xz -C /usr/share/themes/
    tar -xf Ant-standard-buttons.tar -C /usr/share/themes/
    tar -xf Ant.tar -C /usr/share/themes/
    gsettings set org.gnome.desktop.interface gtk-theme "Ant"
    gsettings set org.gnome.desktop.wm.preferences theme "Ant"
    rm -f Ant-standard-buttons.tar Ant.tar

    wget http://rjiicku82.hn-bkt.clouddn.com/google-chrome-stable_current_amd64.deb -O google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb

    # purge
    apt-get purge -y \
    aisleriot \
    brasero \
    cheese \
    deja-dup \
    empathy \
    gedit* \
    gnome-mahjongg \
    gnome-mines \
    gnome-orca \
    gnome-sudoku \
    hitori \
    libreoffice* \
    onboard \
    remmina \
    rhythmbox \
    simple-scan \
    thunderbird \
    totem \
    terminator \
    transmission-gtk \
    transmission-common \
    unity-webapps-common \
    wodim
    
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.4"
