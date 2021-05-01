if [ `id -u` -ne 0 ]; then
	echo "This script must be run as root."
	exit 1
fi

# I got fed up of trying to evaluate this in a decent way
scriptDir="/mnt/sda1/boot"

read -p "TinyCore version to download: " tcv

if [ -z "$tcv" ]; then
	echo "No version was provided."
	exit 1:
fi

baseURL="http://distro.ibiblio.org/tinycorelinux/$tcv.x/x86_64/release/distribution_files"

echo "Downloading v$tcv TinyCore kernel file: corepure64.gz"

if ! wget -O "$scriptDir/corepure64.gz" "$baseURL/corepure64.gz"; then
	echo "Failed to download $baseURL/corepure64.gz"
	exit 1
fi

echo "Downloading v$tcv TinyCore kernel file: vmlinuz64"

if ! wget -O "$scriptDir/vmlinuz64" "$baseURL/vmlinuz64"; then
	echo "Failed to download $baseURL/vmlinuz64"
	exit 1
fi

echo "Done."
