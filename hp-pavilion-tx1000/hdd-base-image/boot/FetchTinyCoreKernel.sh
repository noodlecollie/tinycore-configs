if [ `id -u` -ne 0 ]; then
	echo "This script must be run as root."
	exit 1
fi

DownloadTCFile() {
	echo "Downloading $tcv TinyCore kernel file: $1"

	local scriptDir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
	local baseURL="http://distro.ibiblio.org/tinycorelinux/$tcv.x/x86_64/release/distribution_files"
	local fullURL="$baseURL/$1"

	if ! wget -O "$scriptDir/$1" "$fullURL"; then
		echo "Failed to download $fullURL"
		exit 1
	fi
}

read -p "TinyCore version to download: " tcv

if [ -z "$tcv" ]; then
	echo "No version was provided."
	exit 1:
fi

DownloadTCFile "corepure64.gz"
DownloadTCFile "vmlinuz64"

echo "Done."
