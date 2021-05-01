DownloadTCFile() {
	echo "Downloading v$1 TinyCore kernel file: $2"

	scriptDir=$(cd $(dirname "${BASH_SOURCE[0]}") && pwd)
	baseURL="http://distro.ibiblio.org/tinycorelinux/$1.x/x86_64/release/distribution_files"
	fullURL="$baseURL/$2"

	if ! wget "$fullURL" "$scriptDir"; then
		echo "Failed to download $fullURL"
		exit 1
	fi
}

read -p "TinyCore version to download: " tcv

if [ -z "$tcv" ]; then
	echo "No version was provided."
	exit 1:was
fi

DownloadTCFile $tcv "corepure64.gz"
DownloadTCFile $tcv "vmlinuz64"

echo "Done."
