if [ `id -u` -ne 0 ]; then
	echo "This script must be run as root."
	exit 1
fi

# I got fed up of trying to evaluate this in a decent way
scriptDir="/mnt/sda1/boot/extlinux"

echo "Loading Extlinux into the current session (run as the 'tc' user)"

if ! su -c "tce-load -wil syslinux" tc; then
	echo "Failed to load Extlinux"
	exit 1
fi

echo "Installing Extlinux to $scriptDir"

if ! extlinux --install "$scriptDir"; then
	echo "Failed to install Extlinux"
	exit 1
fi

echo "Backing up SDA's Master Boot Record to $scriptDir/mbr-orig.sda"

if ! dd "if=/dev/sda" bs=1 count=440 "of=$scriptDir/mbr-orig.sda"; then
	echo "Failed to back up MBR"
	exit 1
fi

echo "Installing Extlinux's Master Boot Record to SDA"

if ! su -c "cat /usr/local/share/syslinux/mbr.bin > /dev/sda"; then
	echo "Failed to install Extlinux MBR"
	exit 1
fi

echo "Copying Extlinux menu.c32 to bootloader directory"

if ! cp /usr/local/share/syslinux/menu.c32 /mnt/sda/; then
	echo "Failed to copy menu.c32"
	exit 1
fi

echo "Copying Extlinux libutil.c32 to bootloader directory"

if ! cp /usr/local/share/syslinux/libutil.c32.c32 /mnt/sda/; then
	echo "Failed to copy libutil.c32"
	exit 1
fi

echo "Done."
