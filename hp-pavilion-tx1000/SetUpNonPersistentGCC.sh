InstallExtNonPersistent() {
	echo "Installing non-persistent extension: $1"

	if ! tce-load -wil $1; then
		echo "Failed to install non-persistent extension: $1"
		exit 1
	fi
}

InstallExtNonPersistent gcc
InstallExtNonPersistent glibc_base-dev