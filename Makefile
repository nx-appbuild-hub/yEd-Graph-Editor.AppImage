# This software is a part of the A.O.D apprepo project
# Copyright 2015 Alex Woroschilow (alex.woroschilow@gmail.com)
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
OUTPUT="yEd-Graph-Editor.AppImage"


all:
	wget --no-check-certificate --output-document=build.zip --continue https://www.yworks.com/resources/yed/demo/yEd-3.20.zip
	unzip -o build.zip

	wget --no-check-certificate --output-document=build.rpm --continue https://forensics.cert.org/centos/cert/8/x86_64/jdk-12.0.2_linux-x64_bin.rpm
	rpm2cpio build.rpm | cpio -idmv


	mkdir -p AppDir/application
	mkdir -p AppDir/jre

	cp --recursive --force usr/java/jdk-12.0.2/* AppDir/jre
	cp --recursive --force yed-3.20/* AppDir/application

	chmod +x AppDir/AppRun

	export ARCH=x86_64 && bin/appimagetool.AppImage AppDir $(OUTPUT)
	chmod +x $(OUTPUT)

	rm -f *.rpm *.zip *.deb
	rm -rf AppDir/application
	rm -rf AppDir/jre
	rm -rf yed-3.20
	rm -rf usr
