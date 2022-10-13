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
export TARGET_UBUNTU_MIRROR="https://mirrors.ustc.edu.cn/ubuntu/"

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
    ubuntu-gnome-wallpapers

    # useful tools
    apt-get install -y \
    clamav-daemon \
    terminator \
    apt-transport-https \
    curl \
    vim \
    nano \
    less \

    # custom of me
    apt-get install -y \
    git \
    chromium-browser \
    openjdk-8-jdk \
    openjdk-8-jre-headless

    #apt-get install -y fcitx5 fcitx5-frontend-qt5 libfcitx5-qt-data libfcitx5-qt-dev libfcitx5-qt1 libgsettings-qt1 libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2
    #wget http://rjiicku82.hn-bkt.clouddn.com/sogoupinyin_4.0.1.2800_x86_64.deb -O sogoupinyin.deb
    #dpkg -i sogoupinyin.deb
    #apt-get install -f -y
    #echo 'GTK_IM_MODULE=fcitx' >> /etc/environment 
    #echo 'QT_IM_MODULE=fcitx' >> /etc/environment 
    #echo 'XMODIFIERS="@im=fcitx"' >> /etc/environment 
    #apt-get purge -y ibus

    # purge
    apt-get purge -y \
    transmission-gtk \
    transmission-common \
    gnome-mahjongg \
    gnome-mines \
    gnome-sudoku \
    aisleriot \
    hitori \
    libreoffice* \
    thunderbird \
    rhythmbox \
    deja-dup \
    remmina \
    simple-scan \
    gedit* \
    gnome-orca \
    onboard \
    wodim
    
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.4"
