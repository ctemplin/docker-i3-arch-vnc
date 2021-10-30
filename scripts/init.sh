#!/bin/bash

set -e

export noVNC_version=1.2.0
export websockify_version=0.10.0

# Install apps
pacman -Syu --noconfirm xorg-server \
	wget tigervnc alacritty which \
	i3-wm python-setuptools ttf-dejavu

# Install noVNC
if [ "$DISABLE_NOVNC" != "true" ]; then
	wget https://github.com/novnc/websockify/archive/v${websockify_version}.tar.gz -O /websockify.tar.gz \
		&& tar -xvf /websockify.tar.gz -C / \
		&& cd /websockify-${websockify_version} \
		&& python setup.py install \
		&& cd / && rm -r /websockify.tar.gz /websockify-${websockify_version} \
		&& wget https://github.com/novnc/noVNC/archive/v${noVNC_version}.tar.gz -O /noVNC.tar.gz \
		&& tar -xvf /noVNC.tar.gz -C / \
		&& mv /noVNC-${noVNC_version} /noVNC \
		&& cd /noVNC \
		&& ln -s vnc.html index.html \
		&& rm /noVNC.tar.gz
fi
