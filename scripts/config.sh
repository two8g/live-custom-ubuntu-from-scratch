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
    gnome-screenshot

    # useful tools
    apt-get install -y \
    clamav-daemon \
    terminator \
    apt-transport-https \
    curl \
    vim \
    nano \
    less \
	htop \
    dconf-editor \
	tmux \
	btop

    # custom of me
    apt-get install -y --fix-missing \
    git \
    neofetch \
    python3-pip \
    openjdk-8-jdk \
    openjdk-8-jre-headless \
    libfuse2 \
    zsh

    apt-add-repository -y ppa:fish-shell/release-3
    apt install -y fish

    apt-get install -y fcitx fcitx-frontend-gtk2 fcitx-frontend-gtk3 fcitx-frontend-qt5 fcitx-module-x11
    wget http://127.0.0.1:8887/sogoupinyin_4.0.1.2800_x86_64.deb -O sogoupinyin.deb
    dpkg -i sogoupinyin.deb
    apt-get install -y libgsettings-qt1 libqt5qml5 libqt5quick5 libqt5quickwidgets5 qml-module-qtquick2
    rm -f sogoupinyin.deb
    #apt-get install -f -y
    #echo 'GTK_IM_MODULE=fcitx' >> /etc/environment 
    #echo 'QT_IM_MODULE=fcitx' >> /etc/environment 
    #echo 'XMODIFIERS="@im=fcitx"' >> /etc/environment 
    #apt-get purge -y ibus

    # Install Google Chrome
    wget -O google-chrome-stable_current_amd64.deb http://127.0.0.1:8887/google-chrome-stable_current_amd64.deb
    dpkg -i google-chrome-stable_current_amd64.deb
    rm -f google-chrome-stable_current_amd64.deb

    # KVM
    apt-get -y install cpu-checker virt-manager qemu-kvm libvirt-daemon-system libvirt-clients bridge-utils

    # WPS
    wget -O wps-office.deb http://127.0.0.1:8887/wps-office_11.1.0.11664.XA_amd64.deb
    dpkg -i wps-office.deb
    rm -f wps-office.deb

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
    gnome-todo \
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
    wodim \
    ibus \
    snapd
    
}

# Used to version the configuration.  If breaking changes occur, manual
# updates to this file from the default may be necessary.
export CONFIG_FILE_VERSION="0.4"
