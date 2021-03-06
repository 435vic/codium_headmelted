export BUILDARCH=arm64_archie
export ARCHIE_ARCH=arm64
export ARCHIE_STRATEGY=hybrid
export ARCHIE_HOST_DEPENDENCIES="git curl gnupg pkg-config software-properties-common xvfb wget python zip p7zip-full rpm graphicsmagick libwww-perl libxml-libxml-perl libxml-sax-expat-perl dpkg-dev perl libconfig-inifiles-perl libxml-simple-perl liblocale-gettext-perl libdpkg-perl libconfig-auto-perl libdebian-dpkgcross-perl ucf debconf dpkg-cross tree libx11-dev libxkbfile-dev libc6-dev ruby-full"
export ARCHIE_TARGET_DEPENDENCIES="libgtk2.0-0 libglib2.0-dev libsecret-1-0 libsecret-1-dev libxkbfile-dev libx11-dev libxdmcp-dev libdbus-1-3 libpcre3 libcomerr2 libk5crypto3 libselinux1 libp11-kit0 libxcursor1 libxfixes3 libfreetype6 libkrb5-3 libpango-1.0-0 libpangocairo-1.0-0 libpangoft2-1.0-0 libavahi-client3 libtiff5 fontconfig-config libgssapi-krb5-2 libgdk-pixbuf2.0-common libgdk-pixbuf2.0-0 libfontconfig1 libcups2 libcairo2 linux-libc-dev libatk1.0-0 libc6-dev libx11-xcb-dev libxtst6 libxss-dev libxss1 libgconf-2-4 libasound2 libnss3"  
export docker_image="headmelted/codebuilder:$ARCHIE_ARCH"

# Run the container unconfined and with CAP_SYS_ADMIN, for bind mounts
echo "Binding workspace and executing script for [${ARCHIE_STRATEGY}/${ARCHIE_ARCH}]";
docker run \
--security-opt apparmor:unconfined --cap-add SYS_ADMIN \
-e ARCHIE_STRATEGY \
-e ARCHIE_ARCH \
-e ARCHIE_HOST_DEPENDENCIES \
-e ARCHIE_TARGET_DEPENDENCIES \
-v $(pwd):/root/build \
-v $(pwd)/out:/root/output \
$docker_image /bin/bash -c "cd /root/build && . /root/kitchen/tools/archie_start_build.sh";