#!/bin/sh

echo Add Repository
echo "http://dl-cdn.alpinelinux.org/alpine/3.17/community" >> /etc/apk/repositories

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

apk add git meson wlroots ninja qt5-qtbase-x11 qt5-qtbase qt5-qtbase-dev qt5-qtwayland qt5-qtwayland-dev qt5-qtsvg qt5-qtsvg-dev qt5-qttools-dev libdbusmenu-qt-dev wayland-protocols wayland libcprime libcprime-dev libcsys libcsys-dev xdg-desktop-portal xdg-desktop-portal-kde xdg-desktop-portal-gtk xdg-desktop-portal-wlr make g++ swaylock swayidle brightnessctl mako playerctl cmake pango pango-dev glm glm-dev libinput libinput-dev hwdata-dev hwdata libseat-dev libseat xwayland-dev xwayland xcb-util-renderutil-dev xcb-util-renderutil libevdev-dev libevdev xcb-util-wm-dev xcb-util-wm doctest-dev doctest doxygen inotify-tools inotify-tools-dev inotify-tools-libs libconfig-dev libconfig

apk add --update alpine-sdk && apk add libffi-dev openssl-dev && apk --no-cache --update add build-base

#libexecinfo-dev libexecinfo xcb-util-errors

apk add --no-cache \
    build-base cairo-dev cairo cairo-tools jpeg-dev zlib-dev freetype-dev lcms2-dev openjpeg-dev tiff-dev tk-dev tcl-dev

echo Edge repository
## apk add wayfire --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
apk add clipman --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
apk add wlroots --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
apk add wlroots-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community
apk add libudev-zero --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
apk add libudev-zero-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
apk add libwf-utils --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
apk add wayfire-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
#apk add libexecinfo-dev --repository=http://dl-cdn.alpinelinux.org/alpine/3.16/main


apk add libexecinfo-dev --repository=http://dl-cdn.alpinelinux.org/alpine/edge/community

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
cd ..

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

CMAKE_INSTALL_LIBDIR = ${CMAKE_INSTALL_PREFIX}/lib/x86_64-linux-gnu
PKGCONFPATH = /etc/xdg/paperde
PKGSHAREDPATH = ${CMAKE_INSTALL_PREFIX}/share/paperde
CONF_INSTALL_PATH = /etc/xdg/paperde


meson .build --prefix=/usr --buildtype=release
ninja -C .build -k 0 -j $(nproc) && ninja -C .build install


