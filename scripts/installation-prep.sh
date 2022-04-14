#!/usr/bin/env bash

# Based on https://www.linuxbabe.com/centos/install-avideo-youphptube-centos-8-server
dnf update -y

dnf module enable mariadb:10.5 -y
dnf module enable php:7.4 -y
#dnf module enable ruby:2.6 -y 

dnf install oracle-epel-release-el8 -y

dnf config-manager --set-enabled ol8_codeready_builder

dnf install bash-completion htop fish vim wget git rsync ruby ruby-devel unzip tree \
	httpd php-fpm php-json php-xml php-mysqlnd php-cli php-common php-zip php-opcache php-readline php-curl php-gd mariadb-server mariadb-server-utils python3-pip -y

systemctl enable --now httpd mariadb php-fpm

pip3 install --upgrade pip
pip3 install mycli

cat > /etc/sysctl.d/10-avideo.conf <<EOF
net.core.default_qdisc=fq
net.ipv4.tcp_congestion_control=bbr
EOF

sysctl --system

mkdir /opt/src

curl -I http://gogs.ngtech.home/NgTech-Home/AVideo && git clone http://gogs.ngtech.home/NgTech-Home/AVideo /opt/src/AVideo
curl -I http://gogs.ngtech.home/NgTech-Home/AVideo-Encoder && git clone http://gogs.ngtech.home/NgTech-Home/AVideo-Encoder /opt/src/AVideo-Encoder

stat /opt/src/AVideo || git clone https://github.com/WWBN/AVideo /opt/src/AVideo
stat /opt/src/AVideo-Encoder || git clone https://github.com/WWBN/AVideo-Encoder /opt/src/AVideo-Encoder

rsync -av /opt/src/{AVideo,AVideo-Encoder} /var/www/
chown apache:apache /var/www -R
chcon -t httpd_sys_rw_content_t /var/www/AVideo -R
chcon -t httpd_sys_rw_content_t /var/www/AVideo-Encoder -R

cd /var/www/AVideo && ln -s ../AVideo-Encoder && cd -

dnf install perl-Image-ExifTool libexif -y

pip3 install youtube-dl

curl -I http://gogs.ngtech.home && wget https://www.ngtech.co.il/static/ffmpeg/ffmpeg-release-amd64-static.tar.xz -O /opt/src/ffmpeg-release-amd64-static.tar.xz
stat /opt/src/ffmpeg-release-amd64-static.tar.xz || wget https://johnvansickle.com/ffmpeg/releases/ffmpeg-release-amd64-static.tar.xz -O /opt/src/ffmpeg-release-amd64-static.tar.xz

tar xvf /opt/src/ffmpeg-release-amd64-static.tar.xz -C /opt/src/
cp -v /opt/src/ffmpeg-*amd64-static/{ffmpeg,ffprobe,qt-faststart} /usr/local/bin/

cat > /etc/cron.d/youtube-dl <<EOF
# Run youtub-dl cron jobs
SHELL=/bin/bash
PATH=/sbin:/bin:/usr/sbin:/usr/bin:/usr/local/bin:/usr/local/sbin
MAILTO=root
@daily pip3 install --upgrade youtube-dl > /dev/null
EOF

cat > /opt/src/create-avideo-dbs.sql << EOF
CREATE DATABASE AVideo CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
create user AVideo@localhost identified by 'your-password';
grant all privileges on AVideo.* to AVideo@localhost;
CREATE DATABASE AVideoEncoder CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
create user AVideoEncoder@localhost identified by 'your-password';
grant all privileges on AVideoEncoder.* to AVideoEncoder@localhost;
flush privileges;
EOF

mysql < /opt/src/create-avideo-dbs.sql

cat > /etc/httpd/conf.d/avideo.conf <<EOF
<VirtualHost *:80>
    ServerName tube.yourdomain.com
    DocumentRoot /var/www/AVideo

    <Directory /var/www/AVideo>
       DirectoryIndex index.php
       Options +FollowSymLinks
       AllowOverride All
       Require all granted
    </Directory>
    
    <Directory /var/www/AVideo-Encoder>
       DirectoryIndex index.php
       Options +FollowSymLinks
       AllowOverride All
       Require all granted
    </Directory>

</VirtualHost>
EOF

httpd -S

systemctl restart httpd
setsebool -P httpd_can_network_connect 1

sed -i -e "s@^post_max_size.*@post_max_size = 1024M@g" \
    -e "s@^upload_max_filesize.*@upload_max_filesize = 1024M@g" \
    -e "s@^memory_limit.*@memory_limit = 1024M@g" \
    -e "s@^max_execution_time.*@max_execution_time = 7200@g" /etc/php.ini
sed -i -e "s@^\;env\[PATH\]@env[PATH]@g" /etc/php-fpm.d/www.conf
systemctl restart php-fpm

# Install

# OR, import a pre populated DB
mysql AVideo < /vagrant/sql/avideo-post-encoder.sql
mysql AVideoEncoder < /vagrant/sql/avideo-encoder.sql

# Cleanup directories
rm /var/www/AVideo/install/ -rfv
rm /var/www/Avideo-Encoder/install/ -rfv

tar xvf /vagrant/archives/videos.tar.gz -C /var/www/AVideo/
tar xvf /vagrant/archives/encoder-videos.tar.gz -C /var/www/AVideo-Encoder/
