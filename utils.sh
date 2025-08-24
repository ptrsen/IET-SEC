#!/bin/bash
set -e

if [ -f /etc/vagrant-setup-done ] && [ -f /etc/vagrant-utils-done ] ; then
    echo "[util.sh] Reboot not done yet, skipping."
    rm -rf /etc/vagrant-utils-done 
    exit 0
fi


# Create marker file to tell other utils is done and skip next time
touch /etc/vagrant-utils-done

# Installing utils 
echo -e "\033[1;33m[*] Installing dependencies ...\033[0m" 
apt-get update -y
apt-get install -y wget curl gpg apt-transport-https ca-certificates software-properties-common debconf-utils unzip megatools
apt-get install -y dkms bridge-utils cpu-checker 
apt-get install -y build-essential expect xterm aptitude python3 python3-pip python3-venv python3-dev firejail 
apt-get install -y kali-linux-default



#echo -e "\033[1;33m[*] Installing Virtual Box ...\033[0m" 
#curl -fsSL https://www.virtualbox.org/download/oracle_vbox_2016.asc | gpg --dearmor -o /usr/share/keyrings/oracle-virtualbox-2016.gpg
#echo "deb [arch=amd64 signed-by=/usr/share/keyrings/oracle-virtualbox-2016.gpg] https://download.virtualbox.org/virtualbox/debian bookworm contrib" | tee /etc/apt/sources.list.d/virtualbox.list
#apt-get update -y 
#echo "virtualbox-ext-pack virtualbox-ext-pack/license select true" | debconf-set-selections
#DEBIAN_FRONTEND=noninteractive apt-get install -y virtualbox virtualbox-ext-pack



echo -e "\033[1;33m[*] Installing Docker ...\033[0m"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | gpg --dearmor -o /usr/share/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  noble stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
apt-get update -y
apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
usermod -aG docker vagrant
systemctl enable docker



echo -e "\033[1;33m[*] Installing GNS3 ...\033[0m"

#MODPROBE_DIR="/etc/modprobe.d"
#BAD_DIR="$MODPROBE_DIR/virtualbox-dkms.conf"
#CONF_FILE="$BAD_DIR/virtualbox-dkms.conf"
#TARGET_FILE="$MODPROBE_DIR/virtualbox-dkms.conf"

#if [ -d "$BAD_DIR" ]; then
#  if [ -f "$CONF_FILE" ]; then
#    mv "$CONF_FILE" "$TARGET_FILE"
#  fi
#  rm -r "$BAD_DIR"
#  modprobe vboxdrv
#fi

apt-get install -y python3 python3-pip pipx python3-pyqt5 python3-pyqt5.qtwebsockets python3-pyqt5.qtsvg qemu-kvm qemu-utils libvirt-clients libvirt-daemon-system virtinst virt-manager dynamips software-properties-common ca-certificates curl gnupg2
curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0xB83AAABFFBD82D21B543C8EA86C22C2EC6A24D7F" \
 | gpg --dearmor | tee /usr/share/keyrings/gns3-ppa.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/gns3-ppa.gpg] https://ppa.launchpadcontent.net/gns3/ppa/ubuntu noble main" | tee /etc/apt/sources.list.d/gns3.list
apt-get update -y


echo "ubridge ubridge/install-setuid boolean true" | debconf-set-selections
echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections
DEBIAN_FRONTEND=noninteractive apt-get install -y gns3-gui gns3-server 
dpkg --add-architecture i386
apt-get update -y
apt-get install -y gns3-iou

TARGET_USER="vagrant"
sudo -u "$TARGET_USER" --login bash <<'EOF'
set -e

pipx install gns3-server
pipx install gns3-gui
pipx inject gns3-gui gns3-server PyQt5
EOF

usermod -aG ubridge,libvirt,kvm,wireshark,docker vagrant

# Cisco Images
mkdir -p /home/vagrant/ciscoImages
cd /home/vagrant/ciscoImages
CISCO_IMG="https://irkr.fei.tuke.sk/SmerovacieAlgoritmyVpocitacovychSietach/IOSs/Cisco%20Images%20for%20GNS3%20-%20VIRL%20IOU%20IOS/IOU/IOU/scripts/keygen.py"
wget "$CISCO_IMG" -O keygen.py
CISCO_IMG="https://irkr.fei.tuke.sk/SmerovacieAlgoritmyVpocitacovychSietach/IOSs/Cisco%20Images%20for%20GNS3%20-%20VIRL%20IOU%20IOS/IOU/IOU/bin/i86bi-linux-l2-adventerprisek9-15.1a.bin"
wget "$CISCO_IMG" -O i86bi-linux-l2-adventerprisek9-15.1a.bin
chmod +x i86bi-linux-l2-adventerprisek9-15.1a.bin 
chown vagrant:vagrant i86bi-linux-l2-adventerprisek9-15.1a.bin
CISCO_IMG="https://irkr.fei.tuke.sk/SmerovacieAlgoritmyVpocitacovychSietach/IOSs/Cisco%20Images%20for%20GNS3%20-%20VIRL%20IOU%20IOS/IOU/IOU/bin/i86bi-linux-l3-adventerprisek9-15.4.2T.bin"
wget "$CISCO_IMG" -O i86bi-linux-l3-adventerprisek9-15.4.2T.bin
chmod +x i86bi-linux-l3-adventerprisek9-15.4.2T.bin
chown vagrant:vagrant i86bi-linux-l3-adventerprisek9-15.4.2T.bin
CISCO_IMG="https://mega.nz/#!VMlihIAa!vjDORuGV6DCFXpWEbEJ1PPB9F-V5CFzcyOJYhtf_Wis"
megadl "$CISCO_IMG" --path asav981.zip
unzip asav981.zip
rm -rf asav981.zip 
python2 keygen.py | sed -n '/^\[license\]/,+1p' > iourc.txt
cp iourc.txt /home/vagrant/iourc
cp iourc.txt /root/iourc
chmod 666 /home/vagrant/iourc /root/iourc
chown -R vagrant:vagrant /home/vagrant/ciscoImages /home/vagrant/iourc
cd ~

# https://hub.docker.com/u/gns3
docker pull gns3/ubuntu:noble
docker pull gns3/endhost
docker pull accetto/ubuntu-vnc-xfce-chromium-g3:latest


echo -e "\033[1;33m[*] Installing Packet Tracer ...\033[0m"
LIBGL_DEB_URL="http://archive.ubuntu.com/ubuntu/pool/universe/m/mesa/libgl1-mesa-glx_23.0.4-0ubuntu1~22.04.1_amd64.deb" 
DIALOG_DEB_URL="http://archive.ubuntu.com/ubuntu/pool/universe/d/dialog/dialog_1.3-20240101-1_amd64.deb"
LIBXCB_DEB_URL="http://archive.ubuntu.com/ubuntu/pool/main/libx/libxcb/libxcb-xinerama0-dev_1.15-1ubuntu2_amd64.deb"
PT_DEB_URL="https://archive.org/download/cpt822/CiscoPacketTracer822_amd64_signed.deb"

mkdir -p /ptlibs
wget "$LIBGL_DEB_URL" -O /ptlibs/libgl1-mesa-glx.deb 
wget "$DIALOG_DEB_URL" -O /ptlibs/dialog.deb
wget "$LIBXCB_DEB_URL" -O /ptlibs/libxcb-xinerama0-dev.deb
wget "$PT_DEB_URL" -O /ptlibs/CiscoPacketTracer822_amd64_signed.deb

dpkg -i /ptlibs/libgl1-mesa-glx.deb || apt-get install -f -y
dpkg -i /ptlibs/dialog.deb || apt-get install -f -y
dpkg -i /ptlibs/libxcb-xinerama0-dev.deb || apt-get install -f -y  

mkdir -p /root/.config
touch /root/.config/mimeapps.list

echo "PacketTracer_822_amd64 PacketTracer_822_amd64/show-eula note ''" |  debconf-set-selections
echo "PacketTracer_822_amd64 PacketTracer_822_amd64/accept-eula boolean true" |  debconf-set-selections
DEBIAN_FRONTEND=noninteractive dpkg -i /ptlibs/CiscoPacketTracer822_amd64_signed.deb || apt-get install -f -y
rm -rf /ptlibs

sed -i -E 's|^Exec=.*|Exec=firejail --net=none /opt/pt/packettracer %f|' /usr/share/applications/cisco-pt821.desktop 
sed -i -E 's|^Exec=.*|Exec=firejail --net=none /opt/pt/packettracer -uri=%u|' /usr/share/applications/cisco-ptsa821.desktop




echo -e "\033[1;33m[*] Installing VS Code ...\033[0m" 
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
install -D -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/microsoft.gpg
rm -f microsoft.gpg
sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
apt-get update -y
apt-get install -y code




echo -e "\033[1;33m[*] Cleaning up...\033[0m"
apt-get clean

echo -e "\033[0;32m[✓] Tools installed. '\033[0m"

