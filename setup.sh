#!/bin/sh
CISS="/etc/cls"
mkdir $CISS
mv www $CISS/
MYIP=$(wget -qO- ipinfo.io/ip);
echo $MYIP > /etc/cls/ip.txt
ln -fs /usr/share/zoneinfo/Asia/Jakarta /etc/localtime
mkdir $CISS/bin
mv udpgw $CISS/bin
chmod +x $CISS/bin/udpgw
mv dropbear $CISS/bin
chmod +x $CISS/bin/dropbear
mv key /etc/smile
mv ws.py /etc/cls
cat > /etc/systemd/system/rc-local.service <<-END
[Unit]
Description=/etc/rc.local
ConditionPathExists=/etc/rc.local
[Service]
Type=forking
ExecStart=/etc/rc.local start
TimeoutSec=0
StandardOutput=tty
RemainAfterExit=yes
SysVStartPriority=99
[Install]
WantedBy=multi-user.target
END
# nano /etc/rc.local
cat > /etc/rc.local <<-END
#!/bin/sh -e
# rc.local
# By default this script does nothing.
exit 0
END
cat > /etc/cls/b.txt <<-END
<p style="text-align:center">
<font color="cyan"><b>Welocome To Premium Vpn Account</b></font><br>
END
# Ubah izin akses
chmod +x /etc/rc.local
# enable rc local
systemctl enable rc-local
systemctl start rc-local.service
apt install python2 -y
apt-get remove --purge ufw firewalld -y
apt-get remove --purge exim4 -y
apt autoclean -y
apt -y remove --purge unscd
apt-get -y --purge remove samba*;
apt-get -y --purge remove apache2*;
apt-get -y --purge remove bind9*;
apt-get -y remove sendmail*
apt autoremove -y
sed -i '$ i\screen -dmS badvpn /etc/cls/bin/udpgw --listen-addr 127.0.0.1:7100 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn /etc/cls/bin/udpgw --listen-addr 127.0.0.1:7200 --max-clients 500' /etc/rc.local
sed -i '$ i\screen -dmS badvpn /etc/cls/bin/udpgw --listen-addr 127.0.0.1:7300 --max-clients 500' /etc/rc.local
sed -i '$ i\/etc/cls/bin/dropbear -b /etc/cls/b.txt -p23' /etc/rc.local
sed -i '$ i\screen -dmS sslh sslh -f -p :::2052 --http 127.0.0.89:89' /etc/rc.local
sed -i '$ i\screen -dmS php php -S 127.0.0.89:89 -t /etc/cls/www'
echo "/bin/false" >> /etc/shells
apt install php sslh --no-install-recommends -y
cat > /etc/systemd/system/ws.service << END
[Unit]
Description=Python Proxy
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python2 -O /etc/cls/ws.py 80
Restart=on-failure
[Install]
WantedBy=multi-user.target
END
cat > /etc/systemd/system/wss.service << END
[Unit]
Description=Python Proxy
After=network.target nss-lookup.target
[Service]
Type=simple
User=root
CapabilityBoundingSet=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
AmbientCapabilities=CAP_NET_ADMIN CAP_NET_BIND_SERVICE
NoNewPrivileges=true
ExecStart=/usr/bin/python2 -O /etc/cls/ws.py 2082
Restart=on-failure
[Install]
WantedBy=multi-user.target
END
systemctl daemon-reload
systemctl enable ws
systemctl restart ws
systemctl daemon-reload
systemctl enable wss
systemctl restart wss
systemctl restart rc-local
cat > /etc/cls/log.txt <<-END
Port: 2082,80
UDPGW: 7100,7200,7300
WCS: 89 or 2052
Dropbear,ws.py,badvpn,sslh,php Success
END
echo "Done."
cat /etc/cls/log.txt
echo "Rebooting in 10 secs"
sleep 10
reboot