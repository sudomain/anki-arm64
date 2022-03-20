# anki-arm64

Building and running latest Anki on arm64 linux.

# Install latest Anki on arm64 linux
## Install on Arch Linux
### 1. Install required packages
```
pacman -Sy --noconfirm python-pyqt5 python-pyqtwebengine
```
### 2. Download anki and aqt wheel from release page
- [aqt-2.1.47-py3-none-any.whl](https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-archarm/aqt-2.1.47-py3-none-any.whl)
- [anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl](https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-archarm/anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl)

```
wget https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-archarm/aqt-2.1.47-py3-none-any.whl

wget https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-archarm/anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl
```

### 3. Install the wheel using pip
Note: Install first anki then aqt wheel

```
pip install anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl
pip install aqt-2.1.47-py3-none-any.whl
```
### 4. Run anki
```
anki
```

### 5. Add shortcut 
Download this repository and copy anki.desktop to `/usr/share/applications/` and copy anki.png to `/usr/share/pixmaps/`.

Also command can be run to copy these files.

```
mv anki.desktop /usr/share/applications/anki.desktop
mv anki.png /usr/share/pixmaps/anki.png
```

## Install latest Anki on Ubuntu 20.04
### 1. Install required packages
```
apt install python3-pyqt5 python3-pyqt5.qtwebengine python3-pip
```

### 2. Download anki and aqt wheel from release page
- [aqt-2.1.47-py3-none-any.whl](https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-ubuntu20.04/aqt-2.1.47-py3-none-any.whl)
- [anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl](https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-ubuntu20.04/anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl)

```
wget https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-ubuntu20.04/aqt-2.1.47-py3-none-any.whl

wget https://github.com/infinyte7/anki-arm64/releases/download/v0.0.1-ubuntu20.04/anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl
```

### 3. Install the wheel using pip
Note: Install first anki then aqt wheel

```
pip install anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl
pip install aqt-2.1.47-py3-none-any.whl
```
### 4. Run anki
```
anki
```

### 5. Add shortcut 
Download this repository and copy anki.desktop to `/usr/share/applications/` and copy anki.png to `/usr/share/pixmaps/`.

Also command can be run to copy these files.

```
mv anki.desktop /usr/share/applications/anki.desktop
mv anki.png /usr/share/pixmaps/anki.png
```


# Building latest Anki from source
## Build on Arch Linux
### 1. Install required packages
```
pacman -Sy --noconfirm rsync curl git rust cargo nodejs

pacman -Sy --noconfirm python-pyqt5 python-pyqt3d python-pyqt5-networkauth python-pyqtchart python-pyqtdatavisualization python-pyqtpurchasing python-pyqtwebengine

pacman -Sy --noconfirm --needed base-devel
```

### 2. Build latest Anki
```
export BAZELISK_VER=1.9.0

curl -L https://github.com/bazelbuild/bazelisk/releases/download/v${BAZELISK_VER}/bazelisk-linux-arm64 -o ./bazel

chmod +x bazel && mv bazel /usr/local/bin/

git clone --depth=1 https://github.com/ankitects/anki

cd anki

echo "build --action_env=PYTHON_SITE_PACKAGES=/usr/lib/python3.9/site-packages" >> user.bazelrc

rm -rf bazel-dist

bazel build -k --config opt dist
```

After build completed, there are two wheel file in bazel-dist which can be shared with others. 
```
aqt-2.1.47-py3-none-any.whl
anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl
```

## Build on Ubuntu-20.04
### 1. Install required packages
```
apt-get update -q -y 
apt-get install -q -y apt-utils git rsync findutils curl gcc g++ rustc cargo nodejs
apt-get install -q -y python3 python3-pip python3-pyqt5 pyqt5-dev-tools
apt-get install -q -y python-is-python3
```

### 2. Build latest Anki
```
export BAZELISK_VER=1.9.0

curl -L https://github.com/bazelbuild/bazelisk/releases/download/v${BAZELISK_VER}/bazelisk-linux-arm64 -o ./bazel

chmod +x bazel && mv bazel /usr/local/bin/

git clone --depth=1 https://github.com/ankitects/anki

cd anki

echo "build --action_env=PYTHON_SITE_PACKAGES=/usr/lib/python3/dist-packages" >> user.bazelrc

rm -rf bazel-dist

bazel build -k --config opt dist
```

After build completed, there are two wheel file in bazel-dist which can be shared with others. 
```
aqt-2.1.47-py3-none-any.whl
anki-2.1.47-cp38-abi3-manylinux2014_aarch64.whl
```

## Install in Termux PRoot environment and connect to the desktop using VNC
This repo contains a shell script to install Anki in a PRoot environment (similar chroot without root privileges) in Termux.

Disclaimer: To get Anki to work in this environment, Qt's GPU rendering and security sandbox need to be disabled. Because of this, if there's malicious code in your collection or an add-on, it could cause damage to your collection. Running Anki with the sandbox disabled means you accept the risk that damage could be done to your collection. Keep backups handy. Disabling the sandbox (and thus this warning) may not be necessary when Anki upgrades to Qt version 6.2.

Installing Anki in a PRoot will require a few GB's of internal storage because a full OS (Ubuntu), desktop environment (Xfce), and Anki (and thus Qt) will be installed. Consider that this doesn't even include your collection and media. A small VNC server (tigervnc) will also be installed in order to access the desktop and Anki, but remote connections are disabled by default using the `-localhost` option. Also consider turning off your mobile data and use wifi for the duration of the install. 

### 1. Install and open Termux
Termux:Widgets can be installed if you want an icon on your homescreen rather than typing the command in step 3 each time.

### 2. Execute the following code to download and run the install script.
If you're prompted to configure your timezone (for `tzdata` package) or keyboard layout, you can configure them if you wish or ignore them by pressing `CTRL` +  `d`.

If you're not an existing Termux user, it's ok to select `Y` or `Yes` if you're prompted to upgrade packages or replace default config files. If you're already a Termux user, this script doesn't touch your config files but sometimes changes are made by Termux maintainers via apt.

```
pkg upgrade && pkg in git ;
git clone --depth 1 https://github.com/infinyte7/anki-arm64 ;
bash ~/anki-arm64/termux-proot-distro-install/install.sh
```
If any of the above commands fail, check your internet connection and run again.

### 3. Execute the following code to run Anki.
The first time you do this, you will be asked to create a password for the VNC server. Keep this password as it will be needed by VNC client needed in the next step. If you configured a custom user, change `abki-user`. If this project switches from ubuntu to another proot-distro, change `ubuntu`.

```
proot-distro login --user anki-user ubuntu -- sh bin/run-anki.sh
```

The above command can be put in a script for Termux:Widget to avoid copy/pasting it each time. Follow Termux:Widget instructions for this.

### 4. Install a VNC client app
FOSS options include AVNC and MultiVNC. Try both- they have very different controls.

### 5. Connect to the local VNC server using the VNC client app.
Settings:
Address: `localhost` or `127.0.0.1`
Port: `5901
Password: `Password you created in step 3`

### Uninstalling
If you have no other use for Termux, uninstalling the app will remove everything installed by this install script. If you want to keep Termux but uninstall Anki and its dependencies, run `proot-distro uninstall DISTRO` where DISTRO is the Linux distro installed by this script (currently `ubuntu`).
