# 2026-09-13 18:04:22 by RouterOS 7.24.2
# software id = KYRT-WUTM
#
# model = CCR2004-16G-2S+
# serial number = HH80A9NB0CS
/interface bridge
add name=GatewayVPN
add dhcp-agent-circuit-id="\$(INTERFACE):\$(VID)" dhcp-agent-remote-id=\
    "\$(BRIDGEMAC)" name=bridge0-Nusantara46
add name=bridge1-WiFiNU
add disabled=yes name=bridge2-tes
/interface ethernet
set [ find default-name=ether1 ] arp=disabled name=eth1-LDP
set [ find default-name=ether2 ] name=ether2-astinet
set [ find default-name=ether8 ] disabled=yes
set [ find default-name=ether10 ] name=ether10-OLT
set [ find default-name=ether13 ] name=ether13-OLTMng
/interface wireguard
add comment=back-to-home-vpn listen-port=13418 mtu=1420 name=back-to-home-vpn
/interface vlan
add interface=sfp-sfpplus1 name=952 vlan-id=952
add interface=sfp-sfpplus1 name=vlan-950-GMP vlan-id=950
add interface=sfp-sfpplus1 name=vlan-951-GMP-hotspot vlan-id=951
add interface=ether10-OLT name=vlan-1045-BTI vlan-id=1045
add interface=ether10-OLT name=vlan-1046-UUD45 vlan-id=1046
add interface=ether10-OLT name=vlan-1047-NKRI vlan-id=1047
add interface=ether10-OLT name=vlan-1444-WiFiBTI vlan-id=1444
add interface=ether10-OLT name=vlan-1446-WiFiNKRI vlan-id=1446
add interface=ether10-OLT name=vlan-1448-WiFiUUD45 vlan-id=1448
add interface=bridge0-Nusantara46 name=vlan-1449 vlan-id=1449
add interface=ether10-OLT name=vlan-1450-AulaPancasila vlan-id=1450
add interface=ether10-OLT name=vlan-2045-ONT vlan-id=2045
/interface list
add name=int-wan
add name=int-lokal
add name=int-hotspot
/interface lte apn
set [ find default=yes ] ip-type=ipv4 use-network-apn=no
/ip hotspot profile
set [ find default=yes ] html-directory=pusdatin login-by=http-chap
add dns-name=nu.hotspot hotspot-address=10.4.2.1 html-directory=pusdatin \
    login-by=http-chap name=hsprof2-nu
add dns-name=bti.hotspot hotspot-address=10.4.4.1 html-directory=pusdatin \
    login-by=http-chap name=hsprof4-bti
add dns-name=nkri.hotspot hotspot-address=10.4.6.1 html-directory=pusdatin \
    login-by=http-chap name=hsprof6-nkri
add dns-name=uud.hotspot hotspot-address=10.4.8.1 html-directory=pusdatin \
    login-by=http-chap name=hsprof8-uud
add dns-name=gmp.hotspot hotspot-address=10.5.4.1 html-directory=pusdatin \
    login-by=cookie,http-chap,http-pap name=hsprof1
/ip hotspot user profile
add name=gmp rate-limit=5M/5M shared-users=unlimited
/ip ipsec mode-config
add address=10.10.10.8 name=nufail
add address=10.10.10.10 name=khuluq
add address=10.10.10.11 name=huda
add address=10.10.10.12 name=warek3
/ip ipsec policy group
add name=vpn-server
/ip ipsec profile
set [ find default=yes ] dpd-interval=2m dpd-maximum-failures=5
add dh-group=modp2048,modp1536,modp1024 dpd-interval=2m dpd-maximum-failures=\
    5 enc-algorithm=aes-256,aes-192,aes-128 hash-algorithm=sha256 name=\
    profile1
/ip ipsec peer
add exchange-mode=ike2 local-address=103.28.114.157 name=LDP passive=yes \
    profile=profile1
/ip ipsec proposal
add auth-algorithms=sha512,sha256,sha1 enc-algorithms="aes-256-cbc,aes-256-ctr\
    ,aes-256-gcm,aes-192-cbc,aes-192-ctr,aes-192-gcm,aes-128-cbc,aes-128-ctr,a\
    es-128-gcm" lifetime=12h name=proposal1 pfs-group=none
/ip pool
add name=pool-Nusantara46 ranges=10.41.0.21-10.41.0.254
add name=pool-1047-NKRI ranges=10.41.2.151-10.41.2.254
add name=pool-VPN-IPSEC ranges=10.10.10.2-10.10.10.14
add name=pool-modem-remote ranges=10.45.1.2-10.45.1.14
add name=_pool-WiFiNU ranges=10.4.2.21-10.4.3.254
add name=_pool-WiFiBTI ranges=10.4.4.21-10.4.5.254
add name=_pool-WiFiNKRI ranges=10.4.6.21-10.4.7.254
add name=_pool-WiFiUUD45 ranges=10.4.8.21-10.4.9.254
add name=pool-1045-BTI ranges=10.41.4.21-10.41.5.254
add name=pool-1046-UUD45 ranges=10.41.6.21-10.41.6.254
add name=dhcp_pool31 ranges=10.10.11.2-10.10.11.254
add name=dhcp_pool33 ranges=192.168.22.2-192.168.22.254
add name=dhcp_pool36 ranges=192.168.77.2-192.168.77.254
add name=remote_pool952 ranges=10.5.3.2-10.5.3.254
add name=pool-950-GMP ranges=10.50.1.21-10.50.1.254
add name=hs-pool-95 ranges=10.5.4.2-10.5.4.254
/ip dhcp-server
add address-pool=pool-VPN-IPSEC interface=GatewayVPN name=VPN
add address-pool=pool-modem-remote interface=vlan-2045-ONT lease-time=10m \
    name=dhcp2045ONU
add address-pool=_pool-WiFiNU interface=bridge1-WiFiNU name=WiFi-NU
add address-pool=_pool-WiFiBTI interface=vlan-1444-WiFiBTI name=WiFi-BTI
add address-pool=_pool-WiFiNKRI interface=vlan-1446-WiFiNKRI name=WiFi-NKRI
add address-pool=_pool-WiFiUUD45 interface=vlan-1448-WiFiUUD45 name=\
    WiFi-UUD45
add address-pool=dhcp_pool31 disabled=yes interface=ether10-OLT name=dhcp1
add address-pool=dhcp_pool33 interface=ether2-astinet name=dhcp2
add address-pool=dhcp_pool36 disabled=yes interface=ether16 name=dhcp4
add address-pool=remote_pool952 interface=952 name=dhcp5-remote
add address-pool=hs-pool-95 interface=vlan-951-GMP-hotspot name=dhcp3
/ip smb users
set [ find default=yes ] disabled=yes
/port
set 0 baud-rate=auto name=serial0
set 1 baud-rate=auto name=serial1
/ppp profile
add local-address=10.41.15.1 name=profile-200 rate-limit=200M/200M \
    remote-address=10.41.15.2
add local-address=10.41.15.1 name=pro-20 rate-limit=20M/20M remote-address=\
    10.41.15.3
add local-address=10.41.15.1 name=profile-lab-nu rate-limit=30M/30M \
    remote-address=10.41.15.12
add name=pos2 only-one=yes rate-limit=10M/10M
set *FFFFFFFE only-one=yes
/interface pppoe-client
add add-default-route=yes disabled=no interface=eth1-LDP name=01-ISP-LDP \
    profile=default-encryption use-peer-dns=yes user=uyp@ldp.net
/queue simple
add max-limit=300M/300M name=All-Traffic target=""
add name=Lokal-Nusantara parent=All-Traffic target=10.41.0.0/24
add name=Lokal-NKRI parent=All-Traffic target=10.41.2.128/25
add name=Lokal-BTI parent=All-Traffic target=10.41.4.0/23
add name=Lokal-UUD45 parent=All-Traffic target=10.41.6.0/24
add name=local-GMP parent=All-Traffic target=10.50.1.0/24
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="PUSDATIN-KA (2C:33:58:98:89:AB)" parent=\
    Lokal-Nusantara target=10.41.0.76/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="EW1200-C8EEA4 (98:4A:6B:C8:EE:A4)" parent=\
    Lokal-BTI target=10.41.5.254/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="FAI-TU (38:2C:4A:6E:36:DA)" parent=\
    Lokal-NKRI target=10.41.2.183/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="UY-AIPT (A4:6B:B6:4C:24:76)" parent=\
    Lokal-BTI target=10.41.4.227/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="SPI-1 (A4:AE:12:28:30:87)" parent=\
    Lokal-Nusantara target=10.41.0.149/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="SR (04:7C:16:55:A4:35)" parent=Lokal-BTI \
    target=10.41.4.163/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="DESKTOP-NRP82V1 (94:97:4F:11:4B:9F)" \
    parent=Lokal-BTI target=10.41.5.129/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="Mac (6A:E2:16:D0:F1:55)" parent=Lokal-BTI \
    target=10.41.4.50/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="BAU-02 (84:A9:3E:93:54:16)" parent=\
    Lokal-Nusantara target=10.41.0.233/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="endless (D8:B3:2F:31:E4:AB)" parent=\
    Lokal-Nusantara target=10.41.0.73/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="LPM-KA (1C:A0:B8:78:BA:29)" parent=\
    Lokal-Nusantara target=10.41.0.238/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="LPM-KA (A0:51:0B:82:AA:B4)" parent=\
    Lokal-Nusantara target=10.41.0.239/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="WIN-GGPH4A4TOIL (70:B5:E8:60:FC:25)" \
    parent=Lokal-Nusantara target=10.41.0.240/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="server-ai (C8:15:4E:AF:EA:BA)" parent=\
    Lokal-BTI target=10.41.4.137/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="FAI-TU2 (38:2C:4A:6E:37:94)" parent=\
    Lokal-NKRI target=10.41.2.205/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="moto-g45-5G (2A:2F:2C:01:6D:7E)" parent=\
    Lokal-UUD45 target=10.41.6.254/32
/ip dhcp-server
add address-pool=pool-Nusantara46 always-broadcast=yes interface=\
    bridge0-Nusantara46 lease-script="#Lokal-Nusantara\r\
    \n\r\
    \n# Jika lease aktif, buat queue baru\r\
    \n:if (\$leaseBound = \"1\") do={\r\
    \n\t:local hoste [/ip dhcp-server lease get [find where active-mac-address\
    =\$leaseActMAC && active-address=\$leaseActIP] host-name]\r\
    \n\t:local queueName \"\$hoste (\$leaseActMAC)\"\r\
    \n\t\r\
    \n\t:local existingQueue [/queue simple find target=(\$leaseActIP . \"/32\
    \")]\r\
    \n\t:if ([:len \$existingQueue] > 0) do={\r\
    \n\t\t#:log info (\"Queue with name \$hoste already exists, updating it.\"\
    )\r\
    \n\t} else={\r\
    \n\t\t#:log info (\"Queue with name \$hoste doesn't exist, creating a new \
    one.\")\r\
    \n\t\t:if ([:len \$hoste] > 0) do={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=5M/5M max-limit=10M/10M burst-limit=25M/25M burst-threshold=15M\
    /15M burst-time=4/4 parent=\"Lokal-Nusantara\" queue=default-small/default\
    -small\r\
    \n\t\t} else={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=1M/1M max-limit=3M/3M parent=\"Lokal-Nusantara\" queue=default-\
    small/default-small\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t\r\
    \n\t#:if ([:len [/ip firewall address-list find list=dhcp-leased address=\
    \$leaseActIP]] = 0) do={\r\
    \n\t#\t/ip firewall address-list add list=dhcp-leased address=\$leaseActIP\
    \r\
    \n\t\t#:log info (\"IP address \$leaseActIP added to dhcp-leased list.\")\
    \r\
    \n\t#} else={\r\
    \n\t\t#:log info (\"IP address \$leaseActIP already exists in dhcp-leased \
    list.\")\r\
    \n\t} else={\r\
    \n    # Jika lease tidak aktif, cari dan hapus queue berdasarkan target IP\
    \r\
    \n    #:log info (\"IP address \$leaseActIP was deassigned\")\r\
    \n    /queue simple remove [find target=\"\$leaseActIP/32\"]\r\
    \n    #/ip firewall address-list remove [find address=\$leaseActIP list=dh\
    cp-leased]\r\
    \n}" name=dhcp0-LokalNU parent-queue=Lokal-Nusantara
add address-pool=pool-1047-NKRI always-broadcast=yes interface=vlan-1047-NKRI \
    lease-script="# Jika lease aktif, buat queue baru\r\
    \n:if (\$leaseBound = \"1\") do={\r\
    \n\t:local hoste [/ip dhcp-server lease get [find where active-mac-address\
    =\$leaseActMAC && active-address=\$leaseActIP] host-name]\r\
    \n\t:local queueName \"\$hoste (\$leaseActMAC)\"\r\
    \n\t\r\
    \n\t:local existingQueue [/queue simple find target=(\$leaseActIP . \"/32\
    \")]\r\
    \n\t:if ([:len \$existingQueue] > 0) do={\r\
    \n\t\t#:log info (\"Queue with name \$hoste already exists, updating it.\"\
    )\r\
    \n\t} else={\r\
    \n\t\t#:log info (\"Queue with name \$hoste doesn't exist, creating a new \
    one.\")\r\
    \n\t\t:if ([:len \$hoste] > 0) do={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=5M/5M max-limit=10M/10M burst-limit=25M/25M burst-threshold=15M\
    /15M burst-time=4/4 parent=\"Lokal-NKRI\" queue=default-small/default-smal\
    l\r\
    \n\t\t} else={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=1M/1M max-limit=3M/3M parent=\"Lokal-NKRI\" queue=default-small\
    /default-small\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t\r\
    \n\t#:if ([:len [/ip firewall address-list find list=dhcp-leased address=\
    \$leaseActIP]] = 0) do={\r\
    \n\t#\t/ip firewall address-list add list=dhcp-leased address=\$leaseActIP\
    \r\
    \n\t\t#:log info (\"IP address \$leaseActIP added to dhcp-leased list.\")\
    \r\
    \n\t#} else={\r\
    \n\t\t#:log info (\"IP address \$leaseActIP already exists in dhcp-leased \
    list.\")\r\
    \n\t} else={\r\
    \n    # Jika lease tidak aktif, cari dan hapus queue berdasarkan target IP\
    \r\
    \n    #:log info (\"IP address \$leaseActIP was deassigned\")\r\
    \n    /queue simple remove [find target=\"\$leaseActIP/32\"]\r\
    \n    #/ip firewall address-list remove [find address=\$leaseActIP list=dh\
    cp-leased]\r\
    \n}" name=dhcp3-LokalNKRI parent-queue=Lokal-NKRI
add address-pool=pool-1045-BTI always-broadcast=yes interface=vlan-1045-BTI \
    lease-script="# Jika lease aktif, buat queue baru\r\
    \n:if (\$leaseBound = \"1\") do={\r\
    \n\t:local hoste [/ip dhcp-server lease get [find where active-mac-address\
    =\$leaseActMAC && active-address=\$leaseActIP] host-name]\r\
    \n\t:local queueName \"\$hoste (\$leaseActMAC)\"\r\
    \n\t\r\
    \n\t:local existingQueue [/queue simple find target=(\$leaseActIP . \"/32\
    \")]\r\
    \n\t:if ([:len \$existingQueue] > 0) do={\r\
    \n\t\t#:log info (\"Queue with name \$hoste already exists, updating it.\"\
    )\r\
    \n\t} else={\r\
    \n\t\t#:log info (\"Queue with name \$hoste doesn't exist, creating a new \
    one.\")\r\
    \n\t\t:if ([:len \$hoste] > 0) do={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=5M/5M max-limit=10M/10M burst-limit=25M/25M burst-threshold=15M\
    /15M burst-time=4/4 parent=\"Lokal-BTI\" queue=default-small/default-small\
    \r\
    \n\t\t} else={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=1M/1M max-limit=3M/3M parent=\"Lokal-BTI\" queue=default-small/\
    default-small\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t\r\
    \n\t#:if ([:len [/ip firewall address-list find list=dhcp-leased address=\
    \$leaseActIP]] = 0) do={\r\
    \n\t#\t/ip firewall address-list add list=dhcp-leased address=\$leaseActIP\
    \r\
    \n\t\t#:log info (\"IP address \$leaseActIP added to dhcp-leased list.\")\
    \r\
    \n\t#} else={\r\
    \n\t\t#:log info (\"IP address \$leaseActIP already exists in dhcp-leased \
    list.\")\r\
    \n\t} else={\r\
    \n    # Jika lease tidak aktif, cari dan hapus queue berdasarkan target IP\
    \r\
    \n    #:log info (\"IP address \$leaseActIP was deassigned\")\r\
    \n    /queue simple remove [find target=\"\$leaseActIP/32\"]\r\
    \n    #/ip firewall address-list remove [find address=\$leaseActIP list=dh\
    cp-leased]\r\
    \n}\r\
    \n\r\
    \n\r\
    \n" name=dhcp1-LokalBTI parent-queue=Lokal-BTI
add address-pool=pool-1046-UUD45 always-broadcast=yes interface=\
    vlan-1046-UUD45 lease-script="# Jika lease aktif, buat queue baru\r\
    \n:if (\$leaseBound = \"1\") do={\r\
    \n\t:local hoste [/ip dhcp-server lease get [find where active-mac-address\
    =\$leaseActMAC && active-address=\$leaseActIP] host-name]\r\
    \n\t:local queueName \"\$hoste (\$leaseActMAC)\"\r\
    \n\t\r\
    \n\t:local existingQueue [/queue simple find target=(\$leaseActIP . \"/32\
    \")]\r\
    \n\t:if ([:len \$existingQueue] > 0) do={\r\
    \n\t\t#:log info (\"Queue with name \$hoste already exists, updating it.\"\
    )\r\
    \n\t} else={\r\
    \n\t\t#:log info (\"Queue with name \$hoste doesn't exist, creating a new \
    one.\")\r\
    \n\t\t:if ([:len \$hoste] > 0) do={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=5M/5M max-limit=10M/10M burst-limit=25M/25M burst-threshold=15M\
    /15M burst-time=4/4 parent=\"Lokal-UUD45\" queue=default-small/default-sma\
    ll\r\
    \n\t\t} else={\r\
    \n\t\t\t/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\")\
    \_limit-at=1M/1M max-limit=3M/3M parent=\"Lokal-UUD45\" queue=default-smal\
    l/default-small\r\
    \n\t\t}\r\
    \n\t}\r\
    \n\t\r\
    \n\t#:if ([:len [/ip firewall address-list find list=dhcp-leased address=\
    \$leaseActIP]] = 0) do={\r\
    \n\t#\t/ip firewall address-list add list=dhcp-leased address=\$leaseActIP\
    \r\
    \n\t\t#:log info (\"IP address \$leaseActIP added to dhcp-leased list.\")\
    \r\
    \n\t#} else={\r\
    \n\t\t#:log info (\"IP address \$leaseActIP already exists in dhcp-leased \
    list.\")\r\
    \n\t} else={\r\
    \n    # Jika lease tidak aktif, cari dan hapus queue berdasarkan target IP\
    \r\
    \n    #:log info (\"IP address \$leaseActIP was deassigned\")\r\
    \n    /queue simple remove [find target=\"\$leaseActIP/32\"]\r\
    \n    #/ip firewall address-list remove [find address=\$leaseActIP list=dh\
    cp-leased]\r\
    \n}" name=dhcp2-LokalUUD45 parent-queue=Lokal-UUD45
add address-pool=pool-950-GMP always-broadcast=yes interface=vlan-950-GMP \
    name=dhcp4-LokalGMP parent-queue=local-GMP
/ip hotspot user profile
add add-mac-cookie=no idle-timeout=30m insert-queue-before=first \
    keepalive-timeout=5m !mac-cookie-timeout name=uprof0 parent-queue=\
    local-GMP queue-type=default-small rate-limit=5M/5M session-timeout=3h \
    shared-users=unlimited
/queue simple
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="unifi-NU3 (E0:63:DA:64:90:C5)" parent=\
    Lokal-Nusantara target=10.41.0.10/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="unifi-BTI (1C:6A:1B:70:22:0F)" parent=\
    Lokal-BTI target=10.41.5.144/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="MikroTik-CCTV (64:D1:54:01:04:27)" parent=\
    Lokal-NKRI target=10.41.2.195/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="asus (30:5A:3A:75:1B:A7)" parent=\
    Lokal-UUD45 target=10.41.6.30/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="EW1300G-1ECE92 (4C:49:68:1E:CE:92)" parent=\
    Lokal-UUD45 target=10.41.6.63/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="LPPM (58:D6:1F:3E:99:63)" parent=\
    Lokal-Nusantara target=10.41.0.198/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="unifi-NU2 (74:83:C2:9C:E1:CE)" parent=\
    Lokal-Nusantara target=10.41.0.20/32
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="KERJASAMA-LN (C8:7F:54:EA:CF:4C)" parent=\
    Lokal-Nusantara target=10.41.0.82/32
add name=Hotspot-NU parent=All-Traffic target=10.4.2.0/23
add max-limit=10M/10M name=Hotspot-BTI parent=All-Traffic target=10.4.4.0/23
add name=Hotspot-NKRI parent=All-Traffic target=10.4.6.0/23
add name=Hotspot-GMP parent=All-Traffic target=10.5.4.0/23
add name=Hotspot-UUD45 parent=All-Traffic target=10.4.8.0/23
add burst-limit=25M/25M burst-threshold=15M/15M burst-time=4s/4s limit-at=\
    5M/5M max-limit=10M/10M name="PUSDATIN-Server (84:A9:3E:8F:F0:27)" \
    parent=Lokal-Nusantara target=10.41.0.7/32
/ip hotspot user profile
add add-mac-cookie=no address-pool=_pool-WiFiNU idle-timeout=30m \
    insert-queue-before=first keepalive-timeout=5m !mac-cookie-timeout name=\
    uprof2 parent-queue=Hotspot-NU queue-type=default-small rate-limit=5M/5M \
    session-timeout=3h shared-users=unlimited
add add-mac-cookie=no address-pool=_pool-WiFiBTI idle-timeout=30m \
    insert-queue-before=first keepalive-timeout=5m !mac-cookie-timeout name=\
    uprof4 parent-queue=Hotspot-BTI queue-type=default-small rate-limit=5M/5M \
    session-timeout=3h shared-users=unlimited
add add-mac-cookie=no address-pool=_pool-WiFiNKRI idle-timeout=30m \
    insert-queue-before=first keepalive-timeout=5m !mac-cookie-timeout name=\
    uprof6 parent-queue=Hotspot-NKRI queue-type=default-small rate-limit=\
    5M/5M session-timeout=3h shared-users=unlimited
add add-mac-cookie=no address-pool=_pool-WiFiUUD45 idle-timeout=30m \
    insert-queue-before=first keepalive-timeout=5m !mac-cookie-timeout name=\
    uprof8 parent-queue=Hotspot-UUD45 queue-type=default-small rate-limit=\
    5M/5M session-timeout=3h shared-users=unlimited
/queue type
set 0 pfifo-limit=2000000
set 5 pcq-limit=300KiB
set 6 pcq-limit=300KiB
/queue interface
set ether4 queue=default
set ether5 queue=default
set ether6 queue=default
/ip hotspot user profile
set [ find default=yes ] add-mac-cookie=no keepalive-timeout=30m \
    parent-queue=Hotspot-UUD45 queue-type=default rate-limit=10M/10M \
    shared-users=unlimited status-autorefresh=15m
add add-mac-cookie=no address-pool=pool-1047-NKRI !idle-timeout \
    keepalive-timeout=30m !mac-cookie-timeout name=uprof1 parent-queue=\
    Hotspot-UUD45 queue-type=default rate-limit=10M/10M shared-users=\
    unlimited status-autorefresh=15m
/routing bgp template
set default disabled=no output.network=bgp-networks
/routing ospf instance
add disabled=yes name=default-v2
/routing ospf area
add disabled=yes instance=default-v2 name=backbone-v2
/routing table
add fib name=ke-LDP
add fib name=ke-Astinet
/snmp community
set [ find default=yes ] addresses=0.0.0.0/0
/system logging action
set 0 memory-lines=1 memory-stop-on-full=yes
set 3 remote=192.168.2.14
/system script
add dont-require-permissions=no name="WoL TU-2 (Bang Like)" owner=pusdatin \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    source=\
    "/tool wol interface=\"bridge0-Nusantara46\" mac=84-A9-3E-90-A8-DD\r\
    \n"
add dont-require-permissions=no name=removeActHotspot owner=nopel policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="/\
    ip hots cookie remove [find user=\"free\"]\r\
    \n/ip hots cookie remove [find user=\"internal\"]\r\
    \n/ip hots active remove [find]"
add dont-require-permissions=no name=removeSimpleQueue owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    \_Ambil daftar semua queue di bawah parent \"Nusantara\"\r\
    \n:local queues [/queue simple find where parent=\"Nusantara\"]\r\
    \n# Ambil daftar semua lease aktif\r\
    \n:local activeLeases [/ip dhcp-server lease find where status=bound]\r\
    \n\r\
    \n# Loop melalui setiap queue dan periksa apakah ada di daftar lease aktif\
    \r\
    \n:foreach queueId in=\$queues do={\r\
    \n    :local queueName [/queue simple get \$queueId name]\r\
    \n    :local queueTarget [/queue simple get \$queueId target]\r\
    \n    \r\
    \n    :local ipFound false\r\
    \n    # Loop melalui setiap lease aktif dan tambahkan IP ke daftar\r\
    \n    :foreach lease in=\$activeLeases do={\r\
    \n        :local leaseIP [/ip dhcp-server lease get \$lease address]\r\
    \n        :if (\$queueTarget = \$leaseIP.\"/32\") do={\r\
    \n            :set ipFound true\r\
    \n            #:log info \"ketemu : \$queueTarget = \$leaseIP/32\"\r\
    \n        }\r\
    \n    }\r\
    \n\r\
    \n    # Jika IP tidak ditemukan dalam lease aktif, hapus queue\r\
    \n    :if (\$ipFound = false and \$queueName!=\"PUSDATIN-Si\") do={\r\
    \n        /queue simple remove \$queueId\r\
    \n        :log info (\"Removed orphaned queue: \$leaseIP\")\r\
    \n    }\r\
    \n}"
add dont-require-permissions=no name=rmQueueSimple owner=nufail policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    local parent [/queue simple find name=Nusantara]\r\
    \n:local network \"172.16.4.0/24\"\r\
    \n:if ([:len \$parent] = 0) do={/queue simple add name=Nusantara max-limit\
    =60M/60M target=\"\$network\" packet-marks=no-mark parent=\"All-Traffic\" \
    queue=pac-upload/pac-download}\r\
    \n:local queueName \"Client-\$leaseActMAC\";\r\
    \n:local hoste [/ip dhcp-server lease get [find where active-mac-address=\
    \$leaseActMAC && active-address=\$leaseActIP] host-name];\r\
    \n:if (\$leaseBound = \"1\") do={\r\
    \n/queue simple add name=\$queueName target=(\$leaseActIP . \"/32\") limit\
    -at=5M/5M max-limit=10M/10M burst-limit=30M/30M burst-threshold=20M/20M bu\
    rst-time=8/8 parent=Nusantara queue=pcq-upload-default/pcq-download-defaul\
    t packet-marks=no-mark\r\
    \n} else={\r\
    \n/queue simple remove \$queueName\r\
    \n}"
add dont-require-permissions=no name=SimpleQueue owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=":\
    log info \"Running DHCP lease script\"\
    \n\
    \n# Periksa apakah variabel leaseBound, leaseActIP, dan leaseActMAC ada\
    \n:if ([:len \$leaseBound] > 0 && [:len \$leaseActIP] > 0 && [:len \$lease\
    ActMAC] > 0) do={\
    \n    \
    \n    :local parentName \"Nusantara\"\
    \n    :local network \"172.16.4.0/24\"\
    \n    \
    \n    # 1. Pastikan Parent Queue ada\
    \n    :if ([:len [/queue simple find name=\$parentName]] = 0) do={\
    \n        :log info \"Creating parent queue '\$parentName'\"\
    \n        /queue simple add name=\$parentName max-limit=60M/60M target=\$n\
    etwork packet-marks=no-mark parent=\"All-Traffic\" queue=pac-upload/pac-do\
    wnload\
    \n    }\
    \n\
    \n    # 2. Dapatkan hostname, jika kosong gunakan MAC\
    \n    :local hostname [/ip dhcp-server lease get [find where active-mac-ad\
    dress=\$leaseActMAC && active-address=\$leaseActIP] host-name]\
    \n    :if ([:len \$hostname] = 0) do={ :set hostname \$leaseActMAC }\
    \n\
    \n    # Tentukan nama queue yang unik\
    \n    :local queueName (\"Client-\" . \$hostname)\
    \n\
    \n    # 3. Logika Bound (Perangkat Terhubung)\
    \n    :if (\$leaseBound = \"1\") do={\
    \n        # CEK DULU: Jika queue belum ada, baru ADD. Jika sudah ada, SET \
    (Update)\
    \n        :if ([:len [/queue simple find name=\$queueName]] = 0) do={\
    \n            :log info \"Adding new queue for \$leaseActIP (\$hostname)\"\
    \n            /queue simple add name=\$queueName target=(\$leaseActIP . \"\
    /32\") limit-at=5M/5M max-limit=10M/10M burst-limit=30M/30M burst-threshol\
    d=20M/20M burst-time=8/8 parent=\$parentName queue=pcq-upload-default/pcq-\
    download-default packet-marks=no-mark\
    \n        } else={\
    \n            :log info \"Updating existing queue for \$leaseActIP (\$host\
    name)\"\
    \n            /queue simple set [find name=\$queueName] target=(\$leaseAct\
    IP . \"/32\") parent=\$parentName\
    \n        }\
    \n    } else={\
    \n        # 4. Logika Unbound (Perangkat Terputus)\
    \n        :log info \"Removing queue for \$leaseActIP (\$hostname)\"\
    \n        :local queueId [/queue simple find name=\$queueName]\
    \n        :if ([:len \$queueId] > 0) do={\
    \n            /queue simple remove \$queueId\
    \n            :log info \"Queue removed for \$leaseActIP (\$hostname)\"\
    \n        } else={\
    \n            :log info \"Queue not found for removal: \$queueName\"\
    \n        }\
    \n    }\
    \n} else={\
    \n    :log error \"Lease variables not set correctly\"\
    \n}"
add dont-require-permissions=no name=update_ip_meris_botnet owner=nufail \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    source="# Nama address-list yang ingin dikelola\r\
    \n:local listName \"blocked-meris-botnet\"\r\
    \n\r\
    \n# Menonaktifkan dan mengaktifkan kembali semua entri dalam address-list\
    \r\
    \n:foreach entry in=[/ip firewall address-list find list=\$listName] do={\
    \r\
    \n    /ip firewall address-list disable \$entry\r\
    \n    /ip firewall address-list enable \$entry\r\
    \n}\r\
    \n\r\
    \n:log info \"Address-list '\$listName' entries have been refreshed.\""
add dont-require-permissions=no name=block-non-dhcp owner=nufail policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source="#\
    \_Menghapus address list yang lama\r\
    \n/ip firewall address-list remove [find list=dhcp-clients]\r\
    \n\r\
    \n# Menambahkan DHCP clients dari jaringan 172.16.4.0/24 ke address list\r\
    \n:foreach lease in=[/ip dhcp-server lease find] do={\r\
    \n    :if ([/ip dhcp-server lease get \$lease address] ~ \"172.16.4.\") do\
    ={\r\
    \n        /ip firewall address-list add list=dhcp-clients address=[/ip dhc\
    p-server lease get \$lease address]\r\
    \n    }\r\
    \n}\r\
    \n\r\
    \n# Menambahkan rule untuk memblokir non-DHCP clients dalam jaringan 172.1\
    6.4.0/24\r\
    \n/ip firewall filter\r\
    \nadd chain=input src-address-list=dhcp-clients action=accept\r\
    \nadd chain=input src-address=172.16.4.0/24 action=drop\r\
    \n"
add dont-require-permissions=no name=WoL_Server-AI owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=\"eth3-PCNU\" mac=E8:9C:25:2C:F3:B2"
add dont-require-permissions=no name=WoL_PusdatinSe owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=\"bridge0-Nusantara46\" mac=84:A9:3E:8F:F0:27"
add dont-require-permissions=no name=WoL_PusdatinSi owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=\"bridge0-Nusantara46\" mac=94:C6:91:B7:D3:B3"
add dont-require-permissions=no name=WoL_ServerAI owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=\"bridge4-Server79\" mac=E8:9C:25:2C:F3:B2"
add dont-require-permissions=no name=Wol_bikma-ka owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=\"bridge0-Nusantara46\" mac=74:27:EA:59:46:45"
add dont-require-permissions=no name=Wol_PusdatinKA owner=syarwani policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=\"bridge0-Nusantara46\" mac=6C:3C:8C:14:4E:CC"
add dont-require-permissions=no name=rz owner=pusdatin policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon source=\
    "/tool wol interface=\"bridge0-Nusantara46\" mac=AC:B4:80:35:5F:F2\
    \n"
/certificate settings
set builtin-trust-store=untrusted crl-download=yes crl-store=system crl-use=\
    yes
/interface bridge port
add bridge=bridge0-Nusantara46 interface=ether4
add bridge=bridge0-Nusantara46 interface=ether5
add bridge=bridge0-Nusantara46 interface=ether6
add bridge=bridge1-WiFiNU interface=ether9
add bridge=bridge1-WiFiNU interface=ether12
add bridge=bridge1-WiFiNU interface=vlan-1449
add bridge=bridge2-tes disabled=yes interface=ether16
add bridge=bridge0-Nusantara46 disabled=yes interface=sfp-sfpplus1
add bridge=bridge2-tes disabled=yes interface=sfp-sfpplus1
add bridge=bridge2-tes interface=vlan-950-GMP
add bridge=bridge0-Nusantara46 interface=ether14
add bridge=bridge0-Nusantara46 disabled=yes interface=*66
/ip firewall connection tracking
set tcp-established-timeout=6h tcp-syn-received-timeout=2s \
    tcp-syn-sent-timeout=2s udp-timeout=10s
/ip neighbor discovery-settings
set discover-interface-list=all
/ip settings
set max-neighbor-entries=8192 tcp-syncookies=yes
/ipv6 settings
set disable-ipv6=yes max-neighbor-entries=8192 soft-max-neighbor-entries=8191
/interface detect-internet
set detect-interface-list=all
/interface l2tp-server server
set default-profile=default l2tpv3-digest-hash=none use-ipsec=yes
/interface list member
add interface=01-ISP-LDP list=int-wan
add interface=ether2-astinet list=int-wan
add interface=bridge0-Nusantara46 list=int-lokal
add interface=vlan-1045-BTI list=int-lokal
add interface=vlan-1046-UUD45 list=int-lokal
add interface=vlan-1047-NKRI list=int-lokal
add interface=ether13-OLTMng list=int-lokal
add interface=sfp-sfpplus1 list=int-lokal
add interface=ether6 list=int-lokal
add interface=vlan-950-GMP list=int-lokal
add interface=vlan-951-GMP-hotspot list=int-lokal
add interface=952 list=int-lokal
/interface pppoe-server server
add default-profile=default-encryption disabled=no interface=\
    vlan-1450-AulaPancasila service-name=aula-pancasila
add default-profile=profile-lab-nu disabled=no interface=bridge0-Nusantara46 \
    service-name=lab_nu
/interface pptp-server server
# PPTP connections are considered unsafe, it is suggested to use a more modern VPN protocol instead
set authentication=pap,chap,mschap1,mschap2
/ip address
add address=10.41.0.1/24 interface=bridge0-Nusantara46 network=10.41.0.0
add address=10.41.4.1/23 interface=vlan-1045-BTI network=10.41.4.0
add address=10.41.2.129/25 interface=vlan-1047-NKRI network=10.41.2.128
add address=10.10.10.1/28 interface=GatewayVPN network=10.10.10.0
add address=10.45.1.1/28 interface=vlan-2045-ONT network=10.45.1.0
add address=192.168.2.254/24 interface=ether2-astinet network=192.168.2.0
add address=10.4.2.1/23 interface=bridge1-WiFiNU network=10.4.2.0
add address=10.4.4.1/23 interface=vlan-1444-WiFiBTI network=10.4.4.0
add address=10.4.6.1/23 interface=vlan-1446-WiFiNKRI network=10.4.6.0
add address=10.4.8.1/23 interface=vlan-1448-WiFiUUD45 network=10.4.8.0
add address=192.168.0.1/24 interface=ether13-OLTMng network=192.168.0.0
add address=10.41.6.1/24 interface=vlan-1046-UUD45 network=10.41.6.0
add address=10.41.8.1/23 interface=*4F network=10.41.8.0
add address=192.168.1.1/24 disabled=yes interface=sfp-sfpplus1 network=\
    192.168.1.0
add address=10.5.4.1/24 interface=vlan-951-GMP-hotspot network=10.5.4.0
add address=192.168.22.1/24 disabled=yes interface=ether6 network=\
    192.168.22.0
add address=10.50.1.1/24 interface=vlan-950-GMP network=10.50.1.0
add address=192.168.77.1/24 interface=ether16 network=192.168.77.0
add address=10.5.3.1/24 interface=952 network=10.5.3.0
add address=11.4.2.1/26 interface=*66 network=11.4.2.0
/ip cloud
set back-to-home-vpn=enabled ddns-enabled=yes ddns-update-interval=1m
/ip cloud back-to-home-user
add allow-lan=yes comment="MikroTik-Main | CCR2004-16G-2S+" name=V2455 \
    public-key="gETPEasF0d4/pSuIPIBkuHvkFSYxbzKAMW4JnzvUVXM="
add allow-lan=yes comment="MikroTik-Main | CCR2004-16G-2S+" name=\
    "A54 milik Syarwani" public-key=\
    "SXFtgzhCd+GziG9BcDSW9y4NEdD7rsVJ2z9+Cyng23g="
/ip dhcp-server
add address-pool=*1C disabled=yes interface=*56 name=WiFi-MerTih
/ip dhcp-server lease
add address=10.41.0.7 client-id=1:84:a9:3e:8f:f0:27 mac-address=\
    84:A9:3E:8F:F0:27 server=dhcp0-LokalNU
add address=10.41.0.6 client-id=1:6c:3c:8c:14:4e:cc mac-address=\
    6C:3C:8C:14:4E:CC server=dhcp0-LokalNU
add address=10.41.0.9 client-id=1:94:c6:91:b7:d3:b3 mac-address=\
    94:C6:91:B7:D3:B3 server=dhcp0-LokalNU
add address=10.41.0.10 client-id=1:e0:63:da:64:90:c5 mac-address=\
    E0:63:DA:64:90:C5 server=dhcp0-LokalNU
add address=10.41.0.5 client-id=1:84:a9:3e:90:a8:dd mac-address=\
    84:A9:3E:90:A8:DD server=dhcp0-LokalNU
add address=10.45.1.14 client-id=1:ac:64:62:3b:3:16 comment=POS mac-address=\
    AC:64:62:3B:03:16 server=dhcp2045ONU
add address=10.45.1.8 client-id=1:d0:60:8c:6d:4d:74 comment=SEKRET \
    mac-address=D0:60:8C:6D:4D:74 server=dhcp2045ONU
add address=10.4.6.11 client-id=1:54:3d:37:e:97:b0 mac-address=\
    54:3D:37:0E:97:B0 server=WiFi-NKRI
add address=10.4.4.11 client-id=1:e0:63:da:12:b:9f comment=\
    "rusak-dibawah kepusdatin" mac-address=E0:63:DA:12:0B:9F server=WiFi-BTI
add address=10.4.4.14 client-id=1:e0:63:da:12:8:58 comment=\
    "rusak-dibawah kepusdatin" mac-address=E0:63:DA:12:08:58 server=WiFi-BTI
add address=10.4.4.12 client-id=1:68:72:51:7c:c2:de comment=\
    "Mutasi dari Lantai1" mac-address=68:72:51:7C:C2:DE server=WiFi-BTI
add address=10.4.4.13 client-id=1:e0:63:da:12:c:23 comment=\
    "Mutasi dari Lantai4" mac-address=E0:63:DA:12:0C:23 server=WiFi-BTI
add address=10.4.2.11 comment="NU Lantai-4" mac-address=EC:B9:70:4B:40:19 \
    server=WiFi-NU
add address=10.4.2.12 comment="NU Lantai-5" mac-address=EC:B9:70:4B:3F:9C \
    server=WiFi-NU
add address=10.4.8.13 client-id=1:e0:63:da:a9:a4:de mac-address=\
    E0:63:DA:A9:A4:DE server=WiFi-UUD45
add address=10.4.8.12 client-id=1:74:83:c2:c0:22:1f mac-address=\
    74:83:C2:C0:22:1F server=WiFi-UUD45
add address=10.4.8.11 client-id=1:74:83:c2:c0:11:cb comment=\
    "waiting (wajib c3)" mac-address=74:83:C2:C0:11:CB server=WiFi-UUD45
add address=10.4.6.12 client-id=1:84:18:3a:13:11:60 mac-address=\
    84:18:3A:13:11:60 server=WiFi-NKRI
add address=10.4.6.13 client-id=1:84:18:3a:10:7e:40 mac-address=\
    84:18:3A:10:7E:40 server=WiFi-NKRI
add address=10.41.0.8 client-id=1:ac:b4:80:35:5f:f2 mac-address=\
    AC:B4:80:35:5F:F2 server=dhcp0-LokalNU
add address=10.41.0.20 client-id=1:74:83:c2:9c:e1:ce mac-address=\
    74:83:C2:9C:E1:CE server=dhcp0-LokalNU
add address=10.45.1.7 client-id=1:a4:f3:3b:3f:38:67 comment=BTI mac-address=\
    A4:F3:3B:3F:38:67 server=dhcp2045ONU
add address=10.41.6.79 client-id=1:98:29:a6:93:6b:88 comment=\
    serverperpuslokal mac-address=98:29:A6:93:6B:88 server=dhcp2-LokalUUD45
add address=10.41.0.195 client-id=1:4:7c:16:86:59:dd mac-address=\
    04:7C:16:86:59:DD server=dhcp0-LokalNU
add address=10.41.4.137 client-id=1:c8:15:4e:af:ea:ba mac-address=\
    C8:15:4E:AF:EA:BA server=dhcp1-LokalBTI
add address=10.45.1.6 client-id=1:d4:9e:3:67:ee:fc comment=UUD45 mac-address=\
    D4:9E:03:67:EE:FC server=dhcp2045ONU
add address=10.5.3.3 client-id=1:d8:b3:70:cc:2b:56 mac-address=\
    D8:B3:70:CC:2B:56 server=dhcp5-remote
add address=10.5.3.2 client-id=1:d8:b3:70:cc:33:57 mac-address=\
    D8:B3:70:CC:33:57 server=dhcp5-remote
add address=10.5.3.7 client-id=1:1c:6a:1b:79:d2:e9 mac-address=\
    1C:6A:1B:79:D2:E9 server=dhcp5-remote
add address=10.5.3.9 client-id=1:1c:6a:1b:79:ce:38 comment=GMP-remot \
    mac-address=1C:6A:1B:79:CE:38 server=dhcp5-remote
add address=10.41.4.222 client-id=1:9c:3e:53:95:2:af mac-address=\
    9C:3E:53:95:02:AF server=dhcp1-LokalBTI
add address=10.41.6.63 comment=teknik mac-address=4C:49:68:1E:CE:92 server=\
    dhcp2-LokalUUD45
add address=10.45.1.5 client-id=1:94:bf:80:86:9:3a comment=NKRI mac-address=\
    94:BF:80:86:09:3A server=dhcp2045ONU
add address=10.41.4.163 client-id=1:4:7c:16:55:a4:35 comment=tara \
    mac-address=04:7C:16:55:A4:35 server=dhcp1-LokalBTI
add address=10.5.3.6 client-id=1:74:fa:29:35:31:8d mac-address=\
    74:FA:29:35:31:8D server=dhcp5-remote
add address=10.5.3.8 client-id=1:74:fa:29:35:28:e5 mac-address=\
    74:FA:29:35:28:E5 server=dhcp5-remote
add address=10.41.0.198 client-id=1:58:d6:1f:3e:99:63 comment="LPPM " \
    mac-address=58:D6:1F:3E:99:63 server=dhcp0-LokalNU
add address=10.41.0.188 client-id=\
    ff:2b:94:34:c1:0:2:0:0:ab:11:e2:20:1a:50:3b:24:37:51 mac-address=\
    00:0C:29:AD:89:8D server=dhcp0-LokalNU
/ip dhcp-server network
add address=10.4.0.0/23 dns-server=10.4.0.1,8.8.8.8 gateway=10.4.0.1
add address=10.4.2.0/23 dns-server=10.4.2.1,8.8.8.8 gateway=10.4.2.1
add address=10.4.4.0/23 dns-server=10.4.4.1,8.8.8.8 gateway=10.4.4.1
add address=10.4.6.0/23 dns-server=10.4.6.1,8.8.8.8 gateway=10.4.6.1
add address=10.4.8.0/23 dns-server=10.4.8.1,8.8.8.8 gateway=10.4.8.1
add address=10.4.9.0/26 dns-none=yes gateway=10.4.9.1
add address=10.5.3.0/24 gateway=10.5.3.1
add address=10.5.4.0/24 comment="hotspot network" gateway=10.5.4.1
add address=10.10.10.0/28 dns-server=10.10.10.1 gateway=10.10.10.1
add address=10.10.11.0/24 comment=OLT dns-server=10.10.11.1,8.8.8.8 gateway=\
    10.10.11.1
add address=10.41.0.0/24 dns-server=10.41.0.1,1.1.1.1 gateway=10.41.0.1
add address=10.41.2.128/25 dns-server=10.41.2.129,1.1.1.1 gateway=10.41.2.129
add address=10.41.4.0/23 dns-server=10.41.4.1,1.1.1.1 gateway=10.41.4.1
add address=10.41.6.0/24 dns-server=10.41.6.1,1.1.1.1 gateway=10.41.6.1
add address=10.41.8.0/23 dns-server=10.41.8.1,1.1.1.1 gateway=10.41.8.1
add address=10.41.10.0/23 dns-none=yes gateway=10.41.10.1
add address=10.45.1.0/28 dns-server=10.45.1.1 gateway=10.45.1.1
add address=10.50.1.0/24 dns-server=10.50.1.1,8.8.8.8 gateway=10.50.1.1
add address=11.4.2.0/26 dns-none=yes gateway=11.4.2.1
add address=192.168.2.0/24 dns-none=yes gateway=192.168.2.254
add address=192.168.22.0/24 dns-none=yes gateway=192.168.22.1
add address=192.168.77.0/24 gateway=192.168.77.1
/ip dns
set allow-remote-requests=yes cache-size=4096KiB max-concurrent-queries=\
    10048576 max-concurrent-tcp-sessions=10000000 servers=1.1.1.1,8.8.8.8
/ip dns static
add address=192.168.2.5 name=server.proxmox.yudharta.ac.id type=A
add address=192.168.2.5 disabled=yes name=sister.yudharta.ac.id type=A
add address=192.168.2.5 name=sim.sister.yudharta.ac.id type=A
add address=192.168.2.5 name=repository.yudharta.ac.id type=A
add address=192.168.2.5 name=e-learning.yudharta.ac.id type=A
add address=192.168.2.5 name=sim-bau.yudharta.ac.id type=A
add address=192.168.2.5 name=sert-pasopati.sytes.net type=A
add address=192.168.2.5 name=test-pmb.yudharta.ac.id type=A
add address=192.168.2.5 name=katalog-perpus.yudharta.ac.id type=A
add address=192.168.2.5 name=ebook-perpus.yudharta.ac.id type=A
/ip firewall address-list
add address=10.41.0.0/24 list=ip-lokal
add address=192.168.2.0/24 list=ip-lokal
add address=10.41.4.0/23 list=ip-lokal
add address=10.10.10.0/28 list=tyang4
add address=103.28.114.157 list=IP-PUBLIC
add address=142.44.198.191 list=Port-Scan
add address=104.248.247.237 list=Port-Scan
add address=172.65.239.124 list=Port-Scan
add address=167.94.138.197 list=Port-Scan
add address=104.152.52.18 list=Port-Scan
add address=104.152.52.225 list=Port-Scan
add address=104.152.52.78 list=Port-Scan
add address=10.4.2.0/23 list=dhcp-leased
add address=10.41.2.128/25 list=ip-lokal
add address=178.79.139.171 list=Port-Scan
add address=104.152.52.211 list=Port-Scan
add address=206.168.34.73 list=Port-Scan
add address=104.152.52.213 list=Port-Scan
add address=80.87.206.6 list=Port-Scan
add address=104.152.52.49 list=Port-Scan
add address=141.105.69.178 list=Port-Scan
add address=104.152.52.143 list=Port-Scan
add address=104.152.52.23 list=Port-Scan
add address=104.152.52.43 list=Port-Scan
add address=104.152.52.152 list=Port-Scan
add address=104.152.52.115 list=Port-Scan
add address=104.152.52.220 list=Port-Scan
add address=104.152.52.34 list=Port-Scan
add address=104.152.52.19 list=Port-Scan
add address=104.152.52.163 list=Port-Scan
add address=104.152.52.31 list=Port-Scan
add address=104.152.52.22 list=Port-Scan
add address=104.152.52.129 list=Port-Scan
add address=104.152.52.38 list=Port-Scan
add address=104.152.52.157 list=Port-Scan
add address=10.45.1.0/28 list=ip-lokal
add address=104.152.52.158 list=Port-Scan
add address=104.152.52.88 list=Port-Scan
add address=104.152.52.29 list=Port-Scan
add address=104.152.52.39 list=Port-Scan
add address=104.152.52.26 list=Port-Scan
add address=104.152.52.110 list=Port-Scan
add address=104.152.52.233 list=Port-Scan
add address=104.152.52.87 list=Port-Scan
add address=104.152.52.48 list=Port-Scan
add address=104.152.52.182 list=Port-Scan
add address=104.152.52.52 list=Port-Scan
add address=192.168.0.88 list=ip-lokal
add address=61.142.42.201 list=Port-Scan
add address=10.4.4.0/23 list=dhcp-leased
add address=10.4.6.0/23 list=dhcp-leased
add address=10.4.8.0/23 list=dhcp-leased
add address=104.152.52.102 list=Port-Scan
add address=172.232.159.13 list=Port-Scan
add address=104.152.52.237 list=Port-Scan
add address=205.185.94.42 list=Port-Scan
add address=104.152.52.74 list=Port-Scan
add address=117.2.204.198 list=Port-Scan
add address=198.244.229.224 list=Port-Scan
add address=117.2.213.124 list=Port-Scan
add address=116.103.32.235 list=Port-Scan
add address=104.152.52.54 list=Port-Scan
add address=104.152.52.236 list=Port-Scan
add address=104.152.52.33 list=Port-Scan
add address=222.254.126.148 list=Port-Scan
add address=154.240.100.123 list=Port-Scan
add address=117.2.182.47 list=Port-Scan
add address=117.2.213.189 list=Port-Scan
add address=222.254.127.103 list=Port-Scan
add address=57.155.0.49 list=Port-Scan
add address=183.80.65.107 list=Port-Scan
add address=117.2.188.132 list=Port-Scan
add address=104.152.52.36 list=Port-Scan
add address=183.80.116.143 list=Port-Scan
add address=14.167.130.117 list=Port-Scan
add address=10.41.6.0/24 list=ip-lokal
add address=14.165.124.214 list=Port-Scan
add address=14.180.171.27 list=Port-Scan
add address=14.180.233.21 list=Port-Scan
add address=10.41.8.0/24 list=ip-lokal
add address=10.4.0.0/23 list=dhcp-leased
add address=14.236.51.238 list=Port-Scan
add address=35.196.89.242 list=Port-Scan
add address=104.152.52.123 list=Port-Scan
add address=10.41.0.0/24 list=dhcp-leased
add address=10.41.2.128/25 list=dhcp-leased
add address=10.41.4.0/23 list=dhcp-leased
add address=10.41.6.0/24 list=dhcp-leased
add address=10.41.8.0/23 list=dhcp-leased
add address=10.10.10.0/24 list=ip-lokal
add address=192.168.1.0/24 list=dhcp-leased
add address=24.10.217.51 list=Port-Scan
add address=192.168.1.0/24 list=ip-lokal
add address=10.41.10.0/30 list=dhcp-leased
add address=192.168.22.0/24 list=ip-lokal
add address=103.28.114.153 list=tyang4
add address=103.28.114.152 list=tyang4
add address=103.28.114.77 list=tyang4
add address=10.50.1.254 comment=GMP list=tyang4
add address=10.50.1.249 comment=GMP list=tyang4
add address=10.50.1.84 comment=GMP list=tyang4
add address=10.50.1.86 comment=GMP list=tyang4
add address=10.41.15.0/24 list=ip-lokal
add address=192.168.77.0/24 list=ip-lokal
add address=10.5.3.0/24 list=dhcp-leased
add address=10.50.1.0/24 list=dhcp-leased
add address=114.8.227.147 list=tyang4
add address=5.231.234.183 list=Port-Scan
add address=104.131.36.66 list=Port-Scan
add address=64.227.137.139 list=Port-Scan
add address=146.190.106.138 list=Port-Scan
add address=168.144.103.222 list=Port-Scan
add address=174.138.25.184 list=Port-Scan
add address=134.122.1.127 list=Port-Scan
add address=178.128.252.116 list=Port-Scan
add address=67.205.143.169 list=Port-Scan
add address=64.201.82.251 list=Port-Scan
add address=208.71.96.65 list=Port-Scan
add address=192.168.2.0/24 comment=baruuntukrb-suyp list=dhcp-leased
add address=10.0.0.0/24 comment="IKEv2 VPN clients" list=VPN-IKE2
add address=192.168.216.0/24 list=tyang4
add address=210.90.203.35 list=Port-Scan
add address=10.41.0.25 list=Port-Scan
add address=10.41.0.23 list=Port-Scan
add address=10.41.0.226 list=Port-Scan
add address=10.41.0.228 list=Port-Scan
add address=10.41.5.254 list=Port-Scan
/ip firewall filter
add action=accept chain=input comment="Allow established/related" \
    connection-state=established,related
add action=accept chain=forward connection-state=established,related
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here"
add action=drop chain=input comment="Drop invalid" connection-state=invalid
add action=drop chain=forward connection-state=invalid
add action=accept chain=input comment="Allow LAN to Router" src-address-list=\
    tyang4
add action=accept chain=forward src-address-list=tyang4
add action=accept chain=forward comment="Allow Zoom Web Login" dst-port=\
    80,443 protocol=tcp
add action=accept chain=forward comment="Allow LAN-to-LAN" dst-address-list=\
    ip-lokal src-address-list=ip-lokal
add action=add-src-to-address-list address-list=Port-Scan \
    address-list-timeout=none-static chain=input comment=Port-Scan \
    connection-limit=2,32 log-prefix=Port-scan protocol=tcp psd=4,3s,3,1 \
    src-address-list=!ip-lokal
add action=add-src-to-address-list address-list=Port-Scan \
    address-list-timeout=none-static chain=input comment=Port-Scan \
    connection-limit=2,32 log-prefix=Port-scan protocol=tcp psd=4,3s,3,1 \
    src-address-list=!IP-PUBLIC
add action=drop chain=forward log-prefix=port-scan src-address-list=Port-Scan
add action=accept chain=input comment="Allow Winbox from RB-SUYP" dst-port=\
    1945 protocol=tcp src-address=192.168.2.1
add action=drop chain=input dst-port=1945,23 protocol=tcp src-address-list=\
    !tyang4
add action=drop chain=forward dst-address-list=!ip-lokal dst-port=80 \
    protocol=tcp src-address-list=!dhcp-leased
add action=drop chain=forward dst-address-list=!ip-lokal dst-port=80 \
    protocol=udp src-address-list=!dhcp-leased
add action=reject chain=forward dst-address-list=!ip-lokal protocol=icmp \
    reject-with=icmp-admin-prohibited src-address-list=!dhcp-leased
add action=accept chain=forward comment="Allow Zoom Meeting TCP" dst-port=\
    8801,8802 protocol=tcp
add action=accept chain=forward comment="Allow Zoom Audio Video UDP" \
    dst-port=3478,3479,8801-8810 protocol=udp
/ip firewall mangle
add action=accept chain=prerouting comment="BTH-MAIN -> LAN bypass PCC" \
    dst-address-list=ip-lokal in-interface=back-to-home-vpn
add action=mark-routing chain=prerouting comment=\
    "BTH-MAIN -> Internet via LDP" dst-address-type=!local in-interface=\
    back-to-home-vpn new-routing-mark=ke-LDP passthrough=no
add action=accept chain=prerouting comment=Skip dst-address-list=ip-lokal \
    src-address-list=ip-lokal
add action=accept chain=prerouting protocol=icmp
add action=mark-routing chain=prerouting comment=\
    "Fix Web Session: Bypass PCC for HTTPS to ISP LDP" dst-address-type=\
    !local dst-port=443 new-routing-mark=ke-LDP passthrough=no protocol=tcp
add action=mark-connection chain=prerouting comment="PCC-2 (LDP) :1 (Asti)" \
    dst-address-type=!local in-interface-list=int-lokal new-connection-mark=\
    ISP1_conn per-connection-classifier=src-address:3/0 protocol=tcp
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface-list=int-lokal new-connection-mark=ISP1_conn \
    per-connection-classifier=src-address:3/1 protocol=tcp
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface-list=int-lokal new-connection-mark=ISP2_conn \
    per-connection-classifier=src-address:3/2 protocol=tcp
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface-list=int-lokal new-connection-mark=ISP1_conn \
    per-connection-classifier=src-address:3/0 protocol=udp
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface-list=int-lokal new-connection-mark=ISP1_conn \
    per-connection-classifier=src-address:3/1 protocol=udp
add action=mark-connection chain=prerouting dst-address-type=!local \
    in-interface-list=int-lokal new-connection-mark=ISP2_conn \
    per-connection-classifier=src-address:3/2 protocol=udp
add action=mark-routing chain=prerouting connection-mark=ISP1_conn \
    in-interface-list=int-lokal new-routing-mark=ke-LDP passthrough=no
add action=mark-routing chain=prerouting connection-mark=ISP2_conn \
    in-interface-list=int-lokal new-routing-mark=ke-Astinet passthrough=no
/ip firewall nat
add action=passthrough chain=unused-hs-chain comment=\
    "place hotspot rules here" disabled=yes
add action=masquerade chain=srcnat out-interface-list=int-wan
add action=masquerade chain=srcnat disabled=yes out-interface=01-ISP-LDP
add action=dst-nat chain=dstnat disabled=yes dst-address=103.28.114.157 \
    dst-port=8443 in-interface-list=int-wan protocol=tcp to-addresses=\
    10.5.3.100 to-ports=8443
add action=dst-nat chain=dstnat disabled=yes dst-address=103.28.114.157 \
    dst-port=8843 in-interface-list=int-wan protocol=tcp to-addresses=\
    10.50.1.249 to-ports=8843
add action=dst-nat chain=dstnat disabled=yes dst-address=103.28.114.157 \
    dst-port=8880 protocol=tcp to-addresses=10.50.1.249 to-ports=8880
add action=dst-nat chain=dstnat disabled=yes dst-address=103.28.114.157 \
    dst-port=8080 protocol=tcp to-addresses=10.5.3.100 to-ports=8080
add action=dst-nat chain=dstnat comment="coba buka 443" dst-port=443 \
    in-interface-list=int-wan protocol=tcp to-addresses=192.168.2.5 to-ports=\
    443
add action=masquerade chain=srcnat comment="masquerade hotspot network" \
    src-address=10.5.4.0/24
/ip firewall raw
add action=drop chain=prerouting comment="FLOODING DNS" dst-port=53 \
    in-interface-list=int-wan protocol=tcp
add action=drop chain=prerouting dst-port=53 in-interface-list=int-wan \
    protocol=udp
/ip firewall service-port
set ftp disabled=yes
set tftp disabled=yes
set h323 disabled=yes
set sip disabled=yes
set pptp disabled=yes
set udplite disabled=yes
set dccp disabled=yes
set sctp disabled=yes
/ip hotspot
add address-pool=_pool-WiFiNU addresses-per-mac=unlimited disabled=no \
    idle-timeout=10m interface=bridge1-WiFiNU name=ser-nu profile=hsprof2-nu
add address-pool=_pool-WiFiBTI addresses-per-mac=unlimited disabled=no \
    idle-timeout=10m interface=vlan-1444-WiFiBTI name=ser-bti profile=\
    hsprof4-bti
add address-pool=_pool-WiFiNKRI addresses-per-mac=unlimited disabled=no \
    idle-timeout=10m interface=vlan-1446-WiFiNKRI name=ser-nkri profile=\
    hsprof6-nkri
add address-pool=_pool-WiFiUUD45 addresses-per-mac=unlimited disabled=no \
    idle-timeout=10m interface=vlan-1448-WiFiUUD45 name=ser-uud profile=\
    hsprof8-uud
add address-pool=hs-pool-95 addresses-per-mac=unlimited disabled=no \
    interface=vlan-951-GMP-hotspot name=ser-gmp profile=hsprof1
/ip hotspot ip-binding
add comment=ruijie-NU4 mac-address=EC:B9:70:4B:40:19 server=ser-nu type=\
    bypassed
add comment=ruijie-NU5 mac-address=EC:B9:70:4B:3F:9C server=ser-nu type=\
    bypassed
add comment="1-NKRI-AP RUCKUS L1" mac-address=54:3D:37:0E:97:B0 server=\
    ser-nkri type=bypassed
add comment="2-NKRI-AP RUCKUS L2" mac-address=84:18:3A:13:11:60 server=\
    ser-nkri type=bypassed
add comment="3-NKRI-AP RUCKUS L3" mac-address=84:18:3A:10:7E:40 server=\
    ser-nkri type=bypassed
add comment="1-M2 (BTI)" mac-address=68:72:51:7C:C2:DE server=ser-bti type=\
    bypassed
add comment="2-M2 (BTI)" mac-address=E0:63:DA:12:0B:9F server=ser-bti type=\
    bypassed
add comment="3-M2 (BTI)" mac-address=E0:63:DA:12:08:58 server=ser-bti type=\
    bypassed
add comment="4-M2 (BTI)" mac-address=E0:63:DA:12:0C:23 server=ser-bti type=\
    bypassed
add comment="Unifi-1 (UUD45)" mac-address=74:83:C2:C0:11:CB server=ser-uud \
    type=bypassed
add comment="Unifi-1 (UUD45)" mac-address=76:D2:81:C6:06:87 server=ser-uud \
    type=bypassed
add comment="Unifi-2 (GMP 3 selatan)" mac-address=1C:6A:1B:79:D2:E9 server=*7 \
    type=bypassed
add comment="Unifi-1 (GMP 3 utara)" mac-address=1C:6A:1B:79:CE:38 server=*7 \
    type=bypassed
add comment="Unifi-3 (GMP 2 Barat)" mac-address=D8:B3:70:CC:2B:56 server=*7 \
    type=bypassed
add comment="Unifi-4 (GMP 2 Timur)" mac-address=D8:B3:70:CC:33:57 server=*7 \
    type=bypassed
add comment="Unifi-2 (UUD45)" mac-address=74:83:C2:C0:22:1F server=ser-uud \
    type=bypassed
add comment="Unifi-3 (UUD45)" mac-address=E0:63:DA:A9:A4:DE server=ser-uud \
    type=bypassed
add comment=ZTE-PERPUS mac-address=E4:CA:12:85:F7:7E server=ser-uud type=\
    bypassed
add comment="ust. ja'far" mac-address=FE:2E:6C:5A:E9:46 server=ser-uud type=\
    bypassed
/ip hotspot user
add name=free profile=uprof2 server=ser-nu
add name=free profile=uprof4 server=ser-bti
add name=free profile=uprof6 server=ser-nkri
add name=free profile=uprof8 server=ser-uud
add name=pegawai server=ser-uud
add name=free profile=gmp server=ser-gmp
add name=tamu profile=uprof1 server=ser-nkri
/ip hotspot user profile
add add-mac-cookie=no address-pool=*28 idle-timeout=30m insert-queue-before=\
    first keepalive-timeout=5m !mac-cookie-timeout name=uprof10 parent-queue=\
    Hotspot-GMP queue-type=default-small rate-limit=5M/5M session-timeout=3h \
    shared-users=unlimited
/ip ipsec identity
add auth-method=digital-signature certificate=CA generate-policy=port-strict \
    match-by=certificate mode-config=khuluq peer=LDP policy-template-group=\
    vpn-server remote-certificate=khuluq remote-id=ignore
add auth-method=digital-signature certificate=CA generate-policy=port-strict \
    match-by=certificate mode-config=nufail peer=LDP policy-template-group=\
    vpn-server remote-certificate=nufail remote-id=ignore
add auth-method=digital-signature certificate=CA generate-policy=port-strict \
    match-by=certificate mode-config=huda peer=LDP policy-template-group=\
    vpn-server remote-certificate=huda remote-id=ignore
/ip ipsec policy
set 0 dst-address=10.10.10.0/24 group=vpn-server proposal=proposal1 \
    src-address=0.0.0.0/0
add group=vpn-server proposal=proposal1 template=yes
/ip kid-control
add fri=0s-1d mon=0s-1d name=system-dummy sat=0s-1d sun=0s-1d thu=0s-1d tue=\
    0s-1d tur-fri=0s-1d tur-mon=0s-1d tur-sat=0s-1d tur-sun=0s-1d tur-thu=\
    0s-1d tur-tue=0s-1d tur-wed=0s-1d wed=0s-1d
/ip proxy
set always-from-cache=yes cache-on-disk=yes max-client-connections=30000 \
    max-fresh-time=1h max-server-connections=25260 serialize-connections=yes
/ip proxy access
add action=deny dst-host=*komdigi.go.id*
/ip proxy direct
add action=deny dst-port=80,443
/ip route
add disabled=no distance=2 dst-address=0.0.0.0/0 gateway=192.168.2.1 \
    routing-table=main scope=30 target-scope=10
add comment="Ke Astinet" disabled=no distance=1 dst-address=0.0.0.0/0 \
    gateway=192.168.2.1 routing-table=ke-Astinet scope=30 target-scope=10
add comment="Backup Ketika Astinet Mati" disabled=no distance=2 dst-address=\
    0.0.0.0/0 gateway=01-ISP-LDP routing-table=ke-Astinet scope=30 \
    target-scope=10
add comment="Ke LDP" disabled=no distance=1 dst-address=0.0.0.0/0 gateway=\
    01-ISP-LDP routing-table=ke-LDP scope=30 target-scope=10
add comment="Backup ketika LDP Mati" disabled=no distance=2 dst-address=\
    0.0.0.0/0 gateway=192.168.2.1 routing-table=ke-LDP scope=30 target-scope=\
    10
add comment=Route-to-BTH dst-address=192.168.216.0/24 gateway=192.168.2.1
/ipv6 route
add disabled=no dst-address=2000::/3 gateway=2001:470:35:422::1
add disabled=no dst-address=2001:470:edda:11::/64 gateway=\
    fe80::a55:31ff:fe6b:41ec%
/ip service
set ftp disabled=yes
set ssh disabled=yes
set telnet disabled=yes
set www-ssl certificate=*3
set www disabled=yes port=874
set winbox port=1945
set api disabled=yes
set api-ssl disabled=yes
/ip socks
set connection-idle-timeout=1m
/ip traffic-flow
set enabled=yes interfaces=*B,*E,*3,*4,*6,*F00002,*F00003,<pppoe-gusrektor>
/ip traffic-flow ipfix
set nat-events=yes
/ip traffic-flow target
add dst-address=0.0.0.0 port=666 src-address=192.168.2.2 version=5
add dst-address=0.0.0.0 port=3000 src-address=192.168.2.2 version=5
/ipv6 firewall filter
add action=accept chain=input
add action=accept chain=forward
add action=accept chain=output
/ipv6 nd
set [ find default=yes ] advertise-dns=yes disabled=yes \
    managed-address-configuration=yes other-configuration=yes
# automatic dns option advertising is not started, re-apply dns config
add advertise-dns=yes interface=*4
/ppp secret
add name=aula@uyp profile=profile-200 service=pppoe
add name=gus@uyp profile=pro-20 service=pppoe
add name=gusrektor profile=pro-20
add local-address=172.18.1.1 name=ldp profile=default-encryption \
    remote-address=172.18.1.2
add name=lab-nu profile=profile-lab-nu service=pppoe
/radius
add address=127.0.0.1 service=ipsec
/routing bfd configuration
add disabled=no interfaces=all min-rx=200ms min-tx=200ms multiplier=5
/routing rule
add action=lookup disabled=yes src-address=192.168.100.2 table=*400
add action=lookup disabled=yes src-address=103.28.114.157 table=*401
add action=lookup-only-in-table disabled=yes dst-address=103.163.138.27 \
    src-address=0.0.0.0/0 table=*402
add action=lookup-only-in-table disabled=yes dst-address=103.163.138.24 \
    src-address=0.0.0.0/0 table=*402
add action=lookup-only-in-table disabled=yes dst-address=3.210.101.186 \
    src-address=0.0.0.0/0 table=*405
add action=lookup comment="akses bank" disabled=yes routing-mark=*403 \
    src-address=0.0.0.0/0 table=*403
add action=lookup disabled=yes dst-address=0.0.0.0/0 src-address=\
    10.10.12.0/24 table=*404
add action=lookup-only-in-table disabled=yes dst-address=192.168.2.25 \
    src-address=172.16.3.0/24 table=main
add action=lookup-only-in-table disabled=yes dst-address=0.0.0.0/0 \
    src-address=172.16.3.0/24 table=*405
add action=lookup-only-in-table disabled=yes dst-address=74.82.42.42 \
    src-address=103.28.114.157 table=*405
add action=lookup-only-in-table disabled=yes dst-address=74.82.42.42 \
    src-address=36.93.130.219 table=*405
add action=lookup-only-in-table disabled=yes dst-address=216.218.221.42 \
    src-address=36.93.130.219 table=*405
add action=lookup-only-in-table disabled=yes dst-address=74.82.42.42 \
    src-address=36.93.130.219 table=*405
/system clock
set time-zone-autodetect=no time-zone-name=Asia/Jakarta
/system identity
set name=MikroTik-Main
/system leds
set 0 leds="" type=interface-activity
/system logging
set 0 action=disk topics=info,debug
set 1 action=disk
set 2 action=disk
add
add action=remote topics=info
add action=remote topics=firewall
add action=remote topics=warning
add action=remote topics=critical
add action=disk disabled=yes prefix=-> topics=info,hotspot,debug
add topics=radius,debug
add topics=ipsec,debug
/system note
set show-at-login=no
/system ntp client
set mode=broadcast
/system resource irq rps
set *1 disabled=yes
set *2 disabled=yes
set *3 disabled=yes
set *4 disabled=yes
set *5 disabled=yes
set *6 disabled=yes
set *7 disabled=yes
set *8 disabled=yes
/system routerboard settings
set enter-setup-on=delete-key
/system scheduler
add comment=F4:4D:30:0F:69:F8 !days disabled=yes interval=1w name=\
    Restart-Rutin on-event="/system reboot" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2022-03-03 start-time=00:00:42
add !days interval=2h name=FlashDNS on-event="/ip dns cache flush" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add !days disabled=yes interval=2h name=clear-cache-proxy on-event=\
    "/ip proxy clear-cache" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-time=startup
add !days disabled=yes interval=1d name=RemoreHotspotActive on-event="/ip hots\
    \_cookie remove [find user=\"free\"]\r\
    \n/ip hots cookie remove [find user=\"internal\"]\r\
    \n/ip hots active remove [find]" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2022-06-25 start-time=01:00:42
add !days disabled=yes interval=30m name=removeSimpleQueueSchedule on-event=\
    removeSimpleQueue policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-07-12 start-time=15:10:00
add !days disabled=yes interval=1h name=ip_meris_botnet on-event=\
    update_ip_meris_botnet policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-07-12 start-time=15:10:00
add !days disabled=yes interval=5m name="Update DHCP Clients" on-event=":forea\
    ch lease in=[/ip dhcp-server lease find] do={:if ([/ip dhcp-server lease g\
    et \$lease address] ~ \"172.16.4.\") do={/ip firewall address-list add lis\
    t=dhcp-clients address=[/ip dhcp-server lease get \$lease address]}}" \
    policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-10-29 start-time=13:36:07
add !days disabled=yes interval=1w name=RestartMingguan on-event=\
    "/system reboot" policy=\
    ftp,reboot,read,write,policy,test,password,sniff,sensitive,romon \
    start-date=2024-12-13 start-time=06:00:00
/tool netwatch
add disabled=yes down-script=":log info message=\"down LDP\"" host=\
    103.28.114.153 http-codes="" interval=10s test-script="" type=simple \
    up-script=":log info message=\"up LDP\""
add disabled=yes down-script=":log info message=\"down ASTINET\"" host=\
    36.93.130.216 interval=10s timeout=1s type=simple up-script=\
    ":log info message=\"up ASTINET\""
/tool romon
set enabled=yes
