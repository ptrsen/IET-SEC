#!/bin/bash
set -e

# Skip if reboot already done
if [ -f /etc/vagrant-setup-done ]; then
    echo "[setup.sh] Skipping: already done."
    exit 0
fi

# Create marker file to tell other setup is done and skip next time
touch /etc/vagrant-setup-done
touch /etc/vagrant-utils-done


# Setup commands
echo -e "\033[1;33m[*] kernel upgrade ...\033[0m"
apt-get update -y
apt-get install -y linux-image-amd64 linux-headers-amd64

echo -e "\033[0;32m[✓] kernel upgraded. Run 'vagrant reload --provision'\033[0m"

