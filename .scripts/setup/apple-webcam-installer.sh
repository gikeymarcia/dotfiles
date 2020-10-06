#!/bin/bash
# Mikey Garcia, @gikeymarcia
# install firmware and drivers for apple macbook webcam in Ubuntu
# dependencies: automatically installed
# adapted from https://askubuntu.com/a/1215628

# dependencies
sudo apt install git curl xz-utils cpio kmod libssl-dev checkinstall -y

# remove existing dir and clone into it
clean_clone () {
    repo=$1; dir=$2
    sudo rm -r "$dir"
    git clone "$repo" "$dir"
}

# extract firmware
firmware=/tmp/apple-webcam/firmware
clean_clone https://github.com/patjak/facetimehd-firmware.git "$firmware"
cd "$firmware" || exit
make
sudo make install

# install drivers
drivers=/tmp/apple-webcam/drivers
clean_clone https://github.com/patjak/bcwc_pcie.git "$drivers"
cd "$drivers" || exit
make
sudo make install
sudo depmod
sudo modprobe -r bdc_pci
sudo modprobe facetimehd
echo "~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-~-"
if [ "$(grep -c ^facetimehd /etc/modules)" -eq 0 ]; then
    echo "adding 'facetimehd' to /etc/modules"
    echo "facetimehd" | sudo tee -a /etc/modules
else
    echo "'facetimehd' already in /etc/modules"
fi
cat /etc/modules
