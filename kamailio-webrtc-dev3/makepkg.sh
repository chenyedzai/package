#!/bin/sh

PKG_NAME=kamailio-webrtc
PKG_BUILD=1

if [ -z $PKG_VERSION ]; then
    echo "PKG_VERSION not set"
    exit 1
fi

get() {
	curl -LO https://github.com/kamailio/kamailio/archive/$PKG_VERSION.tar.gz
	tar -xvf kamailio-$PKG_VERSION.tar.gz
}
package() {
	mkdir -pv $PKG_NAME"_"$PKG_VERSION"-"$PKG_BUILD/opt/bin && \
	cp -v kamailio-$PKG_VERSION $PKG_NAME"_"$PKG_VERSION"-"$PKG_BUILD/opt/bin/ && \

    cp -Rv ./DEBIAN  $PKG_NAME"_"$PKG_VERSION"-"$PKG_BUILD/ && \
    sed -i "s/Version: .*/Version: $PKG_VERSION/" $PKG_NAME"_"$PKG_VERSION"-"$PKG_BUILD/DEBIAN/control && \

	cp -Rv etc $PKG_NAME"_"$PKG_VERSION"-"$PKG_BUILD/ && \

	dpkg-deb --build $PKG_NAME"_"$PKG_VERSION"-"$PKG_BUILD
}

package > /dev/null || exit 1
