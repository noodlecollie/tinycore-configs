Installing TinyCore x64 on HP Pavillion tx1000
==============================================

This document describes how to set up a minimal TinyCore installation on the HP Pavilion tx1000 laptop. This is specific to my needs, so if anyone else happens to be using this, you may need to tweak certain instructions (eg. for partitions) to apply to your use cases.

This document was based on the following guides:

* [TinyCore x64 Install Guide for Beginners](https://www.linuxsecrets.com/tinycorelinux-wiki/wiki:microcore64_kiss_install_guide.html)
* [dCore Installation to Hard Drive Without Boot Loader](https://www.linuxsecrets.com/tinycorelinux-wiki/dcore:installation_from_iso_without_boot_loader.html)

## 0. Prerequisites

This document assumes that you have the following set up:

1. A bootable USB with TinyCore present.
2. A hard disk in the laptop, set up with a main data partition on `sda1`, and a swap partition on `sda2`. If this is not the case for you, **any scripts referenced in this document will need to be adjusted. Do not run them as they are or they will wreck your file system.**

## 1. Boot Into the TinyCore Live USB

Any choice in the boot menu will do - we only need the core, but pre-installed extensions may make things quicker.

Note that the `embed` boot code may be required, to ensure that the hard disk is not mounted.

## 2. Format Partitions

Here, `sda1` is formatted as the data partition, and `sda2` as the swap partition.

```
sudo mkfs.ext4 /dev/sda1
sudo mkswap /dev/sda2
```

After this, rebuild `fstab` using:

```
sudo rebuildfstab
```

The reboot using:

```
sudo reboot
```

Make sure to boot into the live USB again when the system comes back up.

## 3. Install Extlinux Bootloader

Enter the following to install `git` to the TinyCore live session. The installation will only be installed to RAM, so will not persist.

```
tce-load -wil git
```

Next, make sure `sda1` is mounted:

```
sudo mount /dev/sda1
```

Clone this repo to the live USB's home directory (again, this will reside in RAM and will not persist), and copy the contents of `hp-pavilion-tx1000/hdd-base-iamge` to `/mnt/sda1`:

```
git clone https://github.com/x6herbius/tinycore-configs.git ~/tinycore-configs
sudo cp -r ~/tinycore-configs/hp-pavilion-tx1000/hdd-base-image/* /mnt/sda1/
```

Then, fetch the TinyCore kernel files by running:

```
sudo /mnt/sda1/FetchTinyCoreKernel.sh
```

This will ask for the desired TinyCore version (the most current version as time of writing is `12`), and will download the relevant files to the `/mnt/sda1` directory.

After this, install Extlinux by running:

```
sudo /mnt/sda1/boot/InstallExtlinux.sh`
```

This will load Extlinux into the current session, install it to `/mnt/sda1/boot`, and write an MBR header to the disk.

After all is done, run `sudo reboot` and remove the live USB. TinyCore should now boot from the hard disk.

## 3. Setting Up a Base System

Once booted from the hard disk, install Git as an on-boot extension:

```
tce-load -wi git
```

If you would like SSH support, you can also install OpenSSH

```
tce-load -wi openssh

# Start the SSH agent:
eval $(ssh-agent)

# If required, limit permissions on the SSH directory and files:
chmod 700 ~/.ssh
chmod 644 ~/.ssh/public_key_file
chmod 600 ~/.ssj/private_key_file

# Load a private key:
ssh-add ~/.ssh/private_key_file
```

Clone this repo into the home directory:

```
# HTTPS:
git clone https://github.com/x6herbius/tinycore-configs.git ~/tinycore-configs

# SSH:
git clone git@github.com:x6herbius/tinycore-configs.git ~/tinycore-configs
```

Then run `SetUpBaseSystem.sh`. This will set up a basic GUI-based system using X and Openbox, and will install some commonly-used utilities like a terminal.

```
~/tinycore-configs/hp-pavilion-tx1000/SetUpBaseSystem.sh
```

After this has completed, restart using `sudo reboot`. After rebooting, The Openbox desktop should load.
