if [ `id -u` -ne 0 ]; then
	echo "This script must be run as root."
	exit 1
fi

DownloadTCFile() {
	echo "Downloading v$1 TinyCore kernel file: $2"

	local scriptDir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
	local baseURL="http://distro.ibiblio.org/tinycorelinux/$1.x/x86_64/release/distribution_files"
	local fullURL="$baseURL/$2"

	if ! wget -O "$scriptDir/$2" "$fullURL"; then
		echo "Failed to download $fullURL"
		exit 1
	fi
}

read -p "TinyCore version to download: " tcv

if [ -z "$tcv" ]; then
	echo "No version was provided."
	exit 1:
fi

DownloadTCFile "$tcv" "corepure64.gz"
DownloadTCFile "$tcv" "vmlinuz64"

echo "Done."
