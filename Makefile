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
