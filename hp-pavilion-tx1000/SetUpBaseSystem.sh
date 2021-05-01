InstallExtForBoot() {
	echo "Installing OnBoot extension: $1"

	if ! tce-load -wi $1; then
		echo "Failed to install OnBoot extension: $1"
		exit 1
	fi
}

echo "Installing base system extensions."
echo

echo "Category: Display and Window System"
InstallExtForBoot Xorg-7.7
InstallExtForBoot graphics-5.10.3-tinycore64

echo "Category: Openbox Window Manager"
InstallExtForBoot openbox
InstallExtForBoot openbox-config
InstallExtForBoot obconf

echo "Category: Terminals"
InstallExtForBoot aterm
