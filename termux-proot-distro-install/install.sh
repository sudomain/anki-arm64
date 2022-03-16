#!/bin/sh
# Commands needed to run once to install Anki in a proot-distro OS. Keeps the run script faster

# $1 - logs in as a particular user in the proot (note root is the root user in the proot, not android)
# $@ - command(s) to run as that user
run_command_in_proot (){
    COMMAND_USER="$1"
    shift 1
    # if you run into issues, try removing --isolated
    proot-distro login --isolated --user "$COMMAND_USER" "$DISTRO" -- "$@"
}

# Package(s) needed in vanilla Termux
TERMUX_PACKAGES="proot-distro"

# proot-distro distribution to install. At the time of this writing, every option has a wrong version of libc that anki needs, with the exception of Ubuntu. This could change.
DISTRO="ubuntu"

# User to install anki under in the proot environment. Probably only useful to existing proot-distro users that have $DISTRO installed
ANKI_INSTALL_USER="anki-user"

# Path to copy the run-anki.sh script to
ANKI_USER_BIN="/home/$ANKI_INSTALL_USER/bin/"

# fyi Termux's pacakge manager "pkg" is a wrapper around apt. apt has an option to automatically upgrade packages (--assume-yes) but I don't think this should be used.
pkg upgrade
pkg install "$TERMUX_PACKAGES"
proot-distro install "$DISTRO"
# From this point on we run code in the proot environment and not Termux itself 

# Qt (and thus Anki) doesn't like running as an user named root, even if it is a fake root like proot.
run_command_in_proot root adduser --disabled-password --gecos "" "$ANKI_INSTALL_USER"
run_command_in_proot "$ANKI_INSTALL_USER" mkdir -p "$ANKI_USER_BIN" &&
cp ~/anki-arm64/termux-proot-distro-install/run-anki.sh "$PREFIX/var/lib/proot-distro/installed-rootfs/$DISTRO$ANKI_USER_BIN"


# Dependencies for Anki under Ubuntu (different distros may not come with the same packages Ubuntu does or have packages with slightly different names). Anki requires an X server at minumum and a somewhat intuitive window manager to be useable. My preference for the X server is tigervnc and to connect to it with a VNC client for Android. For the window manager, xfwm4 fron Xfce will do. Customization/use of lighter-weight software can be done here.
ANKI_PACKAGES="dialog tigervnc-standalone-server xfce4 mpv python3.9-dev python3.9-venv python3-pyqt5.qtwebengine python3-pyqt5.qtmultimedia"

# Anki dependencies
run_command_in_proot root apt update
#run_command_in_proot root apt dist-upgrade
run_command_in_proot root apt install $ANKI_PACKAGES

# Get the latest Anki stable release via pip - https://betas.ankiweb.net/#via-pypipip
run_command_in_proot "$ANKI_INSTALL_USER" python3.9 -m venv --system-site-packages pyenv

# The following is recommended by  the instructions above, but seems to be broken. Can be uncommented once this is fixed: https://github.com/pypa/pip/issues/10887
#run_command_in_proot "$ANKI_INSTALL_USER" pyenv/bin/pip install --upgrade pip

# note adding --pre flag after pip install will get the latest beta. without it, get the latest stable 
run_command_in_proot "$ANKI_INSTALL_USER" pyenv/bin/pip install --upgrade aqt

#TODO handle existing users upgrading their anki using pip
