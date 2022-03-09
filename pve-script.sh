###Create a user sysadmin with password "proxmox"#######
adduser sysadmin --gecos "First Last,RoomNumber,WorkPhone,HomePhone" --disabled-password
echo "sysadmin:proxmox" |  chpasswd &&

rm -rf /etc/apt/sources.list.d/pve-enterprise.list && rm -rf /etc/apt/sources.list &&

touch /etc/apt/sources.list &&

echo "deb http://ftp.debian.org/debian bullseye main contrib non-free" >> /etc/apt/sources.list &&
echo "deb http://ftp.debian.org/debian bullseye-updates main contrib non-free" >> /etc/apt/sources.list &&
echo "deb http://ftp.debian.org/debian bullseye-backports main contrib non-free" >> /etc/apt/sources.list &&
echo "deb http://security.debian.org/debian-security bullseye-security main contrib" >> /etc/apt/sources.list && 

apt-get update && apt-get -y install curl gnupg apt-transport-https software-properties-common &&

echo "deb http://download.proxmox.com/debian/pve bullseye pve-no-subscription" >> /etc/apt/sources.list &&
echo "deb https://download.docker.com/linux/debian buster stable" >> /etc/apt/sources.list &&

wget https://enterprise.proxmox.com/debian/proxmox-release-bullseye.gpg -O /etc/apt/trusted.gpg.d/proxmox-release-bullseye.gpg &&
curl -fsSL https://download.docker.com/linux/debian/gpg | apt-key add - &&

apt update && apt -y dist-upgrade && 

wget http://software.virtualmin.com/gpl/scripts/install.sh && chmod a+x install.sh && 

./install.sh -m -f -v &&

apt -y install tasksel docker-ce certbot nfs-kernel-server &&

pveam -u &&

reboot
