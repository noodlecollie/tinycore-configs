InstallExtForBoot() {
	echo "Installing OnBoot extension: $1"

	if ! tce-load -wi $1; then
		echo "Failed to install OnBoot extension: $1"
		exit 1
	fi
}

echo "This script will set up the base system."
echo "It is assumed that a minimal TinyCore system"
echo "exists, with no Xorg server or desktop environment."
echo "Press Return or Spacebar to continue, or any other"
echo "key to cancel."

read -rsn1 input

if [ -n "$input" ]; then
	echo "Exiting"
	exit 1
fi

echo "========== OnBoot Extensions =========="
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
