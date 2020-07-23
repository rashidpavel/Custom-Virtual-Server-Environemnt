###Create a user sysadmin with password "proxmox"#######
adduser sysadmin --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "sysadmin:proxmox" |  chpasswd &&

rm -rf /etc/apt/sources.list.d/pve-enterprise.list && rm -rf /etc/apt/sources.list &&

touch /etc/apt/sources.list &&

echo "deb http://deb.debian.org/debian/ stable-updates main contrib non-free" >> /etc/apt/sources.list &&
echo "deb http://deb.debian.org/debian-security stable/updates main" >> /etc/apt/sources.list &&
echo "deb http://ftp.debian.org/debian buster-backports main" >> /etc/apt/sources.list &&
echo "deb http://deb.debian.org/debian/ stable main contrib non-free" >> /etc/apt/sources.list &&

apt-get update && apt-get -y install curl gnupg apt-transport-https software-properties-common &&

echo "deb http://download.proxmox.com/debian/pve buster pve-no-subscription" >> /etc/apt/sources.list &&
echo "deb https://download.docker.com/linux/debian buster stable" >> /etc/apt/sources.list &&

wget http://download.proxmox.com/debian/proxmox-ve-release-6.x.gpg -O /etc/apt/trusted.gpg.d/proxmox-ve-release-6.x.gpg &&
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&

apt update && apt -y dist-upgrade && 

wget http://software.virtualmin.com/gpl/scripts/install.sh && chmod a+x install.sh && 

./install.sh -m -f -v &&

apt -y install tasksel docker-ce certbot nfs-kernel-server &&

reboot
