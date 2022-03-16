#!/bin/sh
# A script to setup the minimum proot environment for Anki. Namely a X11/VNC server to connect to, a window manager, and set variables that Qt / Anki need.

export DISPLAY=":1"

# A couple hacks for Qt to work
export QTWEBENGINE_CHROMIUM_FLAGS="--disable-gpu"

# Disabling sandbox is a security risk, but we might not have to do this when Anki goes to Qt 6.2
# https://forums.ankiweb.net/t/setting-disable-seccomp-filter-sandbox-by-default-on-linux/13765
export QTWEBENGINE_DISABLE_SANDBOX=1

# ANKI_BASE is a configurable path to the directory containing profiles (User 1, User 2, ...), add-ons (addons21/), and the prefs.db file. Depending on your Android version, you might be able to set this to shared storage to possibly prevent the collection from being deleted if Termux is accidentally uninstalled.
# export ANKI_BASE="/sdcard/Anki/"

# Width and Height of the VNC desktop to be created, thus the size of windows when maximized (minus panel / window manager decorations). 1080x1920 is a reasonable assumption for phones in portrait mode at the time of this writing, but can be changed to match your display.
export DESKTOP_GEOMETRY="1080x1920"

# Connections are bound to localhost for security, but secure remote connections could be made using ssh port forwarding.
tigervncserver -localhost -xstartup /usr/bin/xfce4-session -geometry "$DESKTOP_GEOMETRY" $DISPLAY

# Run the Anki in the installed virtual environment.
/home/anki-user/pyenv/bin/anki

#TODO `am start` to start a vnc-viewer app would be a nice touch

