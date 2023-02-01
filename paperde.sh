#!/bin/sh

echo Add Repository
echo "https://dl-cdn.alpinelinux.org/alpine/3.17/community" >> /etc/apk/repositories

echo Installation Dependency
apk add --no-cache \
		qt5-qtdeclarative-dev \
		qt5-qtwebsockets-dev \
		qt5-qtwebchannel-dev \
		qt5-qtwebengine-dev \
		qt5-qtconnectivity-dev \
		qt5-qtcharts-dev \
		qt5-qtvirtualkeyboard-dev \
		qt5-qtlocation-dev \
		qt5-qtquickcontrols2-dev \
		qt5-qtxmlpatterns-dev \
		qt5-qtx11extras-dev \
		qt5-qtserialport-dev \
		qt5-qtsensors-dev \
		qt5-qtmultimedia-dev \
		qt5-qtspeech-dev \
		qt5-qtremoteobjects-dev \
		qt5-qtscript-dev \
		qt5-qtimageformats \
		qt5-qttranslations \
		qt5-qtgraphicaleffects 

apk add git meson wlroots ninja qt5-qtbase-x11 qt5-qtbase qt5-qtbase-dev qt5-qtwayland qt5-qtwayland-dev qt5-qtsvg qt5-qtsvg-dev qt5-qttools-dev libdbusmenu-qt-dev wayland-protocols wayland libcprime libcprime-dev libcsys libcsys-dev xdg-desktop-portal xdg-desktop-portal-kde xdg-desktop-portal-gtk xdg-desktop-portal-wlr make g++ swaylock swayidle brightnessctl mako playerctl cmake

echo Edge repository
apk add wayfire --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
apk add clipman --repository=https://dl-cdn.alpinelinux.org/alpine/edge/testing
cd ..

echo Installation of WayQT
git clone https://gitlab.com/desktop-frameworks/wayqt.git wayqt
cd wayqt && meson .build --prefix=/usr --buildtype=release
ninja -C .build -k 0 -j $(nproc) && ninja -C .build install
cd ..

echo Installation of DFL Applications
git clone https://gitlab.com/desktop-frameworks/applications dfl-applications
cd dfl-applications && meson .build --prefix=/usr --buildtype=release -Duse_qt_version=qt5
ninja -C .build -k 0 -j $(nproc) && ninja -C .build install
cd ..

echo Installation of DFL IPC
git clone https://gitlab.com/desktop-frameworks/ipc.git df5ipc
cd df5ipc && meson .build --prefix=/usr --buildtype=release
ninja -C .build -k 0 -j $(nproc) && ninja -C .build install

echo Installation of DFL Login1
git clone https://gitlab.com/desktop-frameworks/login1.git dfl-login1
cd dfl-login1 && meson .build --prefix=/usr --buildtype=release
ninja -C .build -k 0 -j $(nproc) && ninja -C .build install
cd ..

echo Installation of DFL Settings
git clone https://gitlab.com/desktop-frameworks/settings.git dfl-settings
cd dfl-settings && meson .build --prefix=/usr --buildtype=release
ninja -C .build -k 0 -j $(nproc) && ninja -C .build install
cd ..

echo Installation of DFL SNI
git clone https://gitlab.com/desktop-frameworks/status-notifier.git dfl-sni
cd dfl-sni && meson .build --prefix=/usr --buildtype=release
ninja -C .build -k 0 -j $(nproc) && ninja -C .build install
cd ..


echo Installation PaperDE
git clone https://gitlab.com/cubocore/paper/paperde paperde
cd paperde && mkdir build && cd build

cmake -DCMAKE_INSTALL_PREFIX=/usr -DCMAKE_INSTALL_LIBDIR=lib -DPKGCONFPATH=/etc/xdg/paperde -DPKGSHAREDPATH=share/paperde -GNinja ..
ninja -k 0 -j $(nproc)
ninja install

