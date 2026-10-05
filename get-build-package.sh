#!/bin/bash

# Script that installs build-package.sh to compile glibc packages
# Fork: builds for the AEthX-AEsc app (package name aethx.aesc).

BRANCH="master"
APP_PACKAGE_NAME="${APP_PACKAGE_NAME:=aethx.aesc}"

git clone --depth 1 -b ${BRANCH} --single-branch https://github.com/c10vis-poem/termux-packages.git

sed -i "s/^TERMUX_APP__PACKAGE_NAME=\"com.termux\"$/TERMUX_APP__PACKAGE_NAME=\"${APP_PACKAGE_NAME}\"/" termux-packages/scripts/properties.sh
grep -qx "TERMUX_APP__PACKAGE_NAME=\"${APP_PACKAGE_NAME}\"" termux-packages/scripts/properties.sh || exit 1

for i in build-package.sh clean.sh packages x11-packages root-packages scripts ndk-patches; do
	rm -fr ./${i}
	cp -r ./termux-packages/${i} ./
done

rm -fr termux-packages
