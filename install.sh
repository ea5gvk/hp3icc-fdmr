#!/bin/sh
if [[ $EUID -ne 0 ]]; then
	whiptail --title "FDMR+" --msgbox "Debe ejecutar este script como usuario ROOT" 0 50
	exit 0
fi
######################################################################################################################
(crontab -l; echo "* */1 * * * sync ; echo 3 > /proc/sys/vm/drop_caches >/dev/null 2>&1")|awk '!x[$0]++'|crontab -
# apt-get upgrade -y
######################################################################################################################
apps=("wget" "git" "sudo" "python3" "python3-pip" "python3-dev" "libffi-dev" "libssl-dev" "cargo" "sed" "default-libmysqlclient-dev" "build-essential")

# Función para verificar e instalar una aplicación
check_and_install() {
    app=$1
    if ! dpkg -s $app 2>/dev/null | grep -q "Status: install ok installed"; then
        echo "$app no está instalado. Instalando..."
        sudo apt-get install -y $app
        echo "$app instalado correctamente."
    else
        echo "$app ya está instalado."
    fi
}

# Verificar e instalar cada aplicación
for app in "${apps[@]}"; do
    check_and_install $app
done
#####################################################################################################################
#                                      rust
#####################################################################################################################
#!/bin/bash

if command -v rustc &>/dev/null; then
  echo "Rust está instalado. Versión:"
  rustc --version
else
  echo "Rust no está instalado. Instalando..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rustup.sh
  chmod +x rustup.sh
  ./rustup.sh -y
  source "$HOME/.cargo/env"
  rustup update
  rustup update stable
  echo "Rust ha sido instalado correctamente. Versión:"
  rustc --version
  rm rustup.sh
fi

######################################################################################################################
#                                                           Cronedit
######################################################################################################################
cat > /usr/local/bin/cronedit.sh <<- "EOF"
#!/bin/bash
cronjob_editor () {
# usage: cronjob_editor '<interval>' '<command>' <add|remove>

if [[ -z "$1" ]] ;then printf " no interval specified\n" ;fi
if [[ -z "$2" ]] ;then printf " no command specified\n" ;fi
if [[ -z "$3" ]] ;then printf " no action specified\n" ;fi

if [[ "$3" == add ]] ;then
    # add cronjob, no duplication:
    ( sudo crontab -l | grep -v -F -w "$2" ; echo "$1 $2" ) | sudo crontab -
elif [[ "$3" == remove ]] ;then
    # remove cronjob:
    ( sudo crontab -l | grep -v -F -w "$2" ) | sudo crontab -
fi
}
cronjob_editor "$1" "$2" "$3"


EOF
sudo chmod +x /usr/local/bin/cronedit.sh

if [ -f "/var/www/html/tgcount.php" ];
then
   sudo systemctl stop apache2
 #echo "found file"
else
 echo "file not found"

fi
if [ -f "/var/www/html/tgcount.php" ];
then
   sudo systemctl disable apache2
 #echo "found file"
else
 echo "file not found"

fi
if [ -f "/var/www/html/tgcount.php" ];
then
   sudo rm /var/www/html/* -r
 #echo "found file"
else
 echo "file not found"

fi
if [ -f "/opt/FreeDMR/config/FreeDMR.cfg" ];
then
   variable=$(grep "SERVER_ID:" /opt/FreeDMR/config/FreeDMR.cfg | grep -Eo '[0-9]{1,9}')
 else
  echo "id not found"

fi
if [ -z "$variable" ]
then variable=0000

fi
###################################

if [ -d "/var/log/FreeDMR" ]
then
   sudo rm -rf /var/log/FreeDMR
fi
if [ -d "/opt/FreeDMR" ]
then
   sudo rm -rf /opt/FreeDMR
fi
if [ -d "/var/www/fdmr2" ]
then
   sudo rm -rf /var/www/fdmr2
fi
if [ -d "/opt/FDMR-Monitor2" ]
then
   sudo rm -rf /opt/FDMR-Monitor2
fi
if [ -d "/var/www/fdmr" ]
then
   sudo rm -rf /var/www/fdmr
fi
if [ -d "/opt/FDMR-Monitor" ]
then
   sudo rm -rf /opt/FDMR-Monitor
fi
###############################
if [ -f "/bin/menu-fdmr" ];
then
   rm  /bin/menu-fdmr
 #echo "found file"
else
 echo "file not found"

fi
########################
if [ ! -d "/var/www" ]
then
  mkdir -p /var/www
fi
if [ ! -d "/var/www/fdmr" ]
then
  mkdir -p /var/www/fdmr
fi
if [ ! -d "/var/www/fdmr2" ]
then
  mkdir -p /var/www/fdmr2
fi
if [ ! -d "/var/log/FreeDMR" ]
then
  mkdir -p /var/log/FreeDMR
fi
########################
if [ -f "/opt/obp.txt" ]
then
   echo "found file"
else
  sudo cat > /opt/obp.txt <<- "EOF"
 
#Coloque abajo su lista de obp y peer
EOF
fi
######################
if [ -f "/opt/rules.txt" ]
then
   echo "rules found"
else
 sudo cat > /opt/rules.txt <<- "EOF"
BRIDGES = {
 
 '9990': [ 
        {'SYSTEM': 'EchoTest',              'TS': 2, 'TGID': 9990, 'ACTIVE':True, 'TIMEOUT': 0, 'TO_TYPE': 'NONE', 'ON': [9990], 'OFF': [], 'RESET': []}, 
        ],
  
  
  
}
if __name__ == '__main__':
    from pprint import pprint
    pprint(BRIDGES)
  
 
EOF
fi
############
if [ -f "/opt/extra-1.sh" ]
then
  echo "found file"
else
  sudo cat > /opt/extra-1.sh <<- "EOF"
#!/bin/bash
######################################################################
# Coloque en este archivo, cualquier instruccion shell adicional que # 
# quierre se realice al finalizar la actualizacion.                  #
######################################################################
 
  
EOF
# 
fi
if [ -f "/opt/extra-2.sh" ]
then
  echo "found file"
else
  sudo cat > /opt/extra-2.sh <<- "EOF"
#!/bin/bash
######################################################################
# Coloque en este archivo, cualquier instruccion shell adicional que # 
# quierre se realice al finalizar la actualizacion.                  #
######################################################################
 
  
EOF
# 
fi
if [ -f "/opt/extra-3.sh" ]
then
  echo "found file"
else
  sudo cat > /opt/extra-3.sh <<- "EOF"
#!/bin/bash
######################################################################
# Coloque en este archivo, cualquier instruccion shell adicional que # 
# quierre se realice al finalizar la actualizacion.                  #
######################################################################
 
  
EOF
# 
fi
sudo chmod +x /opt/extra-*

#########################
#lamp

apps=("mariadb-server" "php" "libapache2-mod-php" "php-zip" "php-mbstring" "php-cli" "php-common" "php-curl" "php-xml" "php-mysql")

# Función para verificar e instalar una aplicación
check_and_install() {
    app=$1
    if ! dpkg -s $app 2>/dev/null | grep -q "Status: install ok installed"; then
        echo "$app no está instalado. Instalando..."
        sudo apt-get install -y $app
        echo "$app instalado correctamente."
    else
        echo "$app ya está instalado."
    fi
}

# Verificar e instalar cada aplicación
for app in "${apps[@]}"; do
    check_and_install $app
done

systemctl restart mariadb
systemctl enable mariadb
#sudo mysql_secure_installation  --host=localhost --port=3306
echo "DROP USER emqte1@localhost" | /usr/bin/mysql -u root
echo "DROP DATABASE selfcare" | /usr/bin/mysql -u root

newUser='emqte1'
newDbPassword=''
newDb='selfcare'
host=localhost
#host='%'

# MySQL 5.7 and earlier versions
#commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT ALL privileges ON \`${newDb}\`.* TO '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';FLUSH PRIVILEGES;"

# MySQL 8 and higher versions
commands="CREATE DATABASE \`${newDb}\`;CREATE USER '${newUser}'@'${host}' IDENTIFIED BY '${newDbPassword}';GRANT USAGE ON *.* TO '${newUser}'@'${host}';GRANT ALL ON \`${newDb}\`.* TO '${newUser}'@'${host}';FLUSH PRIVILEGES;"

#cho "${commands}" | /usr/bin/mysql -u root -p
echo "${commands}" | /usr/bin/mysql -u root
#################
#FDMR Server
cd /opt
git clone https://gitlab.hacknix.net/hacknix/FreeDMR.git
sudo rm /opt/FreeDMR/hotspot_proxy_v2.py
cd FreeDMR
mkdir config
mkdir /var/log/FreeDMR
sudo chmod +x /opt/FreeDMR/*
./install.sh
sudo cat > /opt/conf.txt <<- "EOF"
  
[D-APRS]
MODE: MASTER
ENABLED: True
REPEAT: False
MAX_PEERS: 1
EXPORT_AMBE: False
IP:
PORT: 52555
PASSPHRASE:
GROUP_HANGTIME: 0
USE_ACL: True
REG_ACL: DENY:1
SUB_ACL: DENY:1
TGID_TS1_ACL: PERMIT:ALL
TGID_TS2_ACL: PERMIT:ALL
DEFAULT_UA_TIMER: 10
SINGLE_MODE: False
VOICE_IDENT: False
TS1_STATIC:
TS2_STATIC:
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: es_ES
GENERATOR: 2
ALLOW_UNREG_ID: True
PROXY_CONTROL: False
OVERRIDE_IDENT_TG:

[EchoTest]
MODE: PEER
ENABLED: True
LOOSE: True
EXPORT_AMBE: False
IP: 
#127.0.0.1
PORT: 49060
MASTER_IP: 127.0.0.1
MASTER_PORT: 49061
PASSPHRASE: passw0rd
CALLSIGN: ECHOTEST
RADIO_ID: 9990
RX_FREQ: 449000000
TX_FREQ: 444000000
TX_POWER: 25
COLORCODE: 1
SLOTS: 3
LATITUDE: 38.0000
LONGITUDE: -095.0000
HEIGHT: 75
LOCATION: Local Parrot
DESCRIPTION: This is a cool repeater
URL: www.w1abc.org
SOFTWARE_ID: 20170620
PACKAGE_ID: MMDVM_HBlink
GROUP_HANGTIME: 3
OPTIONS:
#TS2=9990;DIAL=0;VOICE=0;TIMER=0
USE_ACL: True
SUB_ACL: DENY:1
TGID_TS1_ACL: DENY:ALL
TGID_TS2_ACL: PERMIT:9990
TS1_STATIC:
TS2_STATIC:9990
DEFAULT_REFLECTOR: 0
ANNOUNCEMENT_LANGUAGE: en_GB
GENERATOR: 0
DEFAULT_UA_TIMER: 999
SINGLE_MODE: True
VOICE_IDENT: False

EOF
##
if [ "$(cat /opt/FreeDMR/FreeDMR-SAMPLE.cfg | grep 'TOPO_FILE')" != "" ]; then
sed -i 's/TOPO_FILE:.*/TOPO_FILE: topography.json/' /opt/FreeDMR/FreeDMR-SAMPLE.cfg
else
sed '45 a TOPO_FILE: topography.json' -i /opt/FreeDMR/FreeDMR-SAMPLE.cfg 
fi
sed -i "s/ANNOUNCEMENT_LANGUAGE:.*/ANNOUNCEMENT_LANGUAGE: es_ES/g" /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sed -i "s/SINGLE_MODE:.*/SINGLE_MODE: False/g" /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sed -i "s/VOICE_IDENT:.*/VOICE_IDENT: False/g"  /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sed -i "s/VALIDATE_SERVER_IDS:.*/VALIDATE_SERVER_IDS: False/g" /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sed -i "s/ALLOW_UNREG_ID:.*/ALLOW_UNREG_ID: True/g" /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sed -i "s/PROXY_CONTROL:.*/PROXY_CONTROL: False/g" /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sed -i "s/54000/56000/g" /opt/FreeDMR/FreeDMR-SAMPLE.cfg
sed -i "s/TRY_DOWNLOAD:.*/TRY_DOWNLOAD: False/g" /opt/FreeDMR/FreeDMR-SAMPLE.cfg

cp /opt/FreeDMR/FreeDMR-SAMPLE.cfg /opt/FreeDMR-SAMPLE.cfg
cd /opt/
cat FreeDMR-SAMPLE.cfg conf.txt obp.txt >> /opt/FreeDMR/config/FreeDMR.cfg
sed -i 's/file-timed/console-timed/' /opt/FreeDMR/config/FreeDMR.cfg
sed -i 's/INFO/DEBUG/' /opt/FreeDMR/config/FreeDMR.cfg
sed -i 's/freedmr.log/\/var\/log\/FreeDMR\/FreeDMR.log/' /opt/FreeDMR/config/FreeDMR.cfg
sed -i "s/SERVER_ID:.*/SERVER_ID: $variable/g"  /opt/FreeDMR/config/FreeDMR.cfg

rm /opt/conf.txt
rm /opt/FreeDMR-SAMPLE.cfg

cd /opt/FreeDMR/
mv loro.cfg /opt/FreeDMR/playback.cfg
sed -i 's/54915/49061/' /opt/FreeDMR/playback.cfg
sudo cat /opt/rules.txt >> /opt/FreeDMR/config/rules.py
sudo chmod +x  /opt/FreeDMR/config/*
#######################
#FDMR-Monitor
cd /opt
sudo git clone https://github.com/yuvelq/FDMR-Monitor.git
cd FDMR-Monitor
sudo git checkout Self_Service
sudo chmod +x install.sh

sed -i 's/RELOAD_TIME = 15/RELOAD_TIME = 1/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed -i 's/FREQUENCY = 10/FREQUENCY = 120/' /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sudo chmod 644 /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed '33 a <!--' -i /opt/FDMR-Monitor/html/sysinfo.php
sed '35 a -->' -i /opt/FDMR-Monitor/html/sysinfo.php
####
sed -i "s/www\/html/www\/fdmr/g" /opt/FDMR-Monitor/html/*.*
sed -i "s/www\/html/www\/fdmr/g" /opt/FDMR-Monitor/sysinfo/*.*
sed -i "s/1100/1200/g" /opt/FDMR-Monitor/html/*.*
sed -i "s/1100/1200/g" /opt/FDMR-Monitor/html/css/*.*
sed -i "s/1100/1200/g" /opt/FDMR-Monitor/templates/*.*
sed -i 's/b1eee9/3bb43d/' /opt/FDMR-Monitor/html/css/*.*
####
sed -i 's/localhost_2-day.png/localhost_1-day.png/' /opt/FDMR-Monitor/html/sysinfo.php
sed -i "s/HBMonv2/FDMR-Monitor/g"  /opt/FDMR-Monitor/sysinfo/*.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/cpu.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/graph.sh
sudo chmod +x /opt/FDMR-Monitor/sysinfo/rrd-db.sh

sed -i "s/root/emqte1/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed -i "s/test/selfcare/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg
sed -i "s/PRIVATE_NETWORK = True/PRIVATE_NETWORK = False/g"  /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg

cd /opt/FDMR-Monitor/
#sudo rm /opt/FDMR-Monitor/install.sh
################
apps=("rrdtool")

for app in "${apps[@]}"
do
    # Verificar apps
    if ! dpkg -s "$app" >/dev/null 2>&1; then
        # app no instalada
        sudo apt-get install -y "$app"
    else
        # app ya instalada
        echo "$app ya instalada"
    fi
done
sed -i "s/www\/html/www\/fdmr/g" /opt/FDMR-Monitor/html/*.*
sed -i "s/www\/html/www\/fdmr/g" /opt/FDMR-Monitor/sysinfo/*.*
# Install the required support programs
pip3 install -r requirements.txt
pip install pyopenssl --upgrade
cd /opt/FDMR-Monitor/
cp /opt/FDMR-Monitor/fdmr-mon_SAMPLE.cfg /opt/FDMR-Monitor/fdmr-mon.cfg
###############################
sed -i "s/PEER_URL =.*/PEER_URL = https:\/\/freedmr-lh.gb7fr.org.uk\/json\/peer_ids.json/g" /opt/FDMR-Monitor/fdmr-mon.cfg
sed -i "s/SUBSCRIBER_URL =.*/SUBSCRIBER_URL = http:\/\/datafiles.ddns.net:8888\/user.csv/g" /opt/FDMR-Monitor/fdmr-mon.cfg
sed -i "s/SUBSCRIBER_FILE =.*/SUBSCRIBER_FILE = user.csv/g" /opt/FDMR-Monitor/fdmr-mon.cfg
sed -i "s/TGID_URL =.*/TGID_URL = https:\/\/freedmr-lh.gb7fr.org.uk\/json\/talkgroup_ids.json/g" /opt/FDMR-Monitor/fdmr-mon.cfg
sed -i "s/root/emqte1/g"  /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py
sed -i "s/test/selfcare/g"  /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py
sed -i "s/\/freedmr.cfg/\/config\/FreeDMR.cfg/g" /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py
sed -i "s/test/selfcare/g" /opt/FDMR-Monitor/proxy/proxy_db.py
sed -i "s/root/emqte1/g"  /opt/FDMR-Monitor/proxy/proxy_db.py
sed -i "s/root/emqte1/g" /opt/FDMR-Monitor/proxy/proxy.cfg
sed -i "s/test/selfcare/g" /opt/FDMR-Monitor/proxy/proxy.cfg
sed -i "s/54000/56000/g"  /opt/FDMR-Monitor/proxy/proxy_db.py
sed -i "s/54000/56000/g" /opt/FDMR-Monitor/proxy/proxy.cfg
sed -i "s/54100/56100/g"  /opt/FDMR-Monitor/proxy/proxy_db.py
sed -i "s/54100/56100/g" /opt/FDMR-Monitor/proxy/proxy.cfg
sed -i "s/54000/56000/g" /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py
sed -i "s/54100/56100/g"  /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py
sed -i "s/1234567/1234567,1231237,123123701/g" /opt/FDMR-Monitor/proxy/proxy.cfg
#################
cp /opt/FDMR-Monitor/proxy/hotspot_proxy_v2.py /opt/FreeDMR/hotspot_proxy_v2.py
cp /opt/FDMR-Monitor/proxy/proxy.cfg /opt/FreeDMR/proxy.cfg
cp /opt/FDMR-Monitor/proxy/proxy_db.py /opt/FreeDMR/proxy_db.py

wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1B-M7QNdf1gLVzbTn-Fi5GVPy6GTXcxJ-' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1B-M7QNdf1gLVzbTn-Fi5GVPy6GTXcxJ-" -O /opt/FDMR-Monitor/html/favicon.ico && rm -rf /tmp/cookies.txt &&

sed '6 a <link rel="shortcut icon" href="/favicon.ico" />' -i /opt/FDMR-Monitor/html/index.php
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=1evvxLOh8uxKYYLoV0aORjDhFeLF42_S_' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=1evvxLOh8uxKYYLoV0aORjDhFeLF42_S_" -O /opt/FDMR-Monitor/html/img/logo.png && rm -rf /tmp/cookies.txt &&


#
sudo cat > /opt/FDMR-Monitor/html/buttons.php <<- "EOF"
<!-- HBMonitor buttons HTML code -->
<a class="button" href="index.php">Home</a>
&nbsp;
<div class="dropdown">
  <button class="dropbtn">Links</button>
  <div class="dropdown-content">
&nbsp;
<a class="button" href="linkedsys.php">Linked Systems</a>

<a class="button" href="statictg.php">Static TG</a>

<a class="button" href="opb.php">OpenBridge</a>
&nbsp;
</div>
</div>
<div class="dropdown">
  <button class="dropbtn">Self Service</button>
  <div class="dropdown-content">
    <?php if(!PRIVATE_NETWORK){echo '<a class="button" href="selfservice.php">SelfService</a>';}?>
    <a class="button" href="login.php">Login</a>
    <?php 
    if(isset($_SESSION["auth"], $_SESSION["callsign"], $_SESSION["h_psswd"]) and $_SESSION["auth"]){
      echo '<a class="button" href="devices.php">Devices</a>';
    }
    ?>
  </div>
</div>
<div class="dropdown">
  <button class="dropbtn">Local Server</button>
  <div class="dropdown-content">

<a class="button" href="moni.php">&nbsp;Monitor&nbsp;</a>

<a class="button" href="sysinfo.php">&nbsp;System Info&nbsp;</a>

<a class="button" href="log.php">&nbsp;Lastheard&nbsp;</a>

<a class="button" href="tgcount.php">&nbsp;TG Count&nbsp;</a>
&nbsp;
</div>
</div>
<div class="dropdown">
  <button class="dropbtn">FreeDMR</button>
  <div class="dropdown-content">
&nbsp;
<a class="button" href="https://freedmr-lh.gb7fr.org.uk/?limit=100&recent=1"target="_blank">&nbsp;Global Info FreeDMR&nbsp;</a>
<a class="button" href="http://www.freedmr.uk/index.php/freedmr-servers/"target="_blank">&nbsp;Info Server&nbsp;</a>
<a class="button" href="http://www.freedmr.uk/index.php/world-wide-talk-groups/"target="_blank">&nbsp;World Wide Talk Groups&nbsp;</a>
<a class="button" href="http://www.freedmr.uk/freedmr/option-calculator-b.php"target="_blank">&nbsp;Static TG Calculator&nbsp;</a>
&nbsp;
</div>
</div>

<!--
<a class="button" href="bridges.php">Bridges</a>
-->
<!-- Example of buttons dropdown HTML code -->
<!--
<div class="dropdown">
  <button class="dropbtn">Admin Area</button>
  <div class="dropdown-content">
    <a href="masters.php">Master&Peer</a>
    <a href="opb.php">OpenBridge</a>
    <a href="moni.php">Monitor</a>
  </div>
</div>
<div class="dropdown">
  <button class="dropbtn">Reflectors</button>
  <div class="dropdown-content">
    <a target='_blank' href="#">YSF Reflector</a>
    <a target='_blank' href="#">XLX950</a>
  </div>
</div>
-->
EOF

#
cp -r /opt/FDMR-Monitor/html/* /var/www/fdmr/ 
sudo chown www-data:www-data /var/www/fdmr/ -R    
cp /opt/FDMR-Monitor/utils/logrotate/fdmr_mon /etc/logrotate.d/

cat > /opt/FDMR-Monitor/templates/main_table.html  <<- "EOF"

<fieldset class="big">
<legend><b><font color="#000">&nbsp;.: Server Activity :.&nbsp;</font></b></legend>
{% if _table['MASTERS']|length >0 %}
 <table style="table-layout:fixed;width:1100px; font: 10pt arial, sans-serif;margin-top:5px;margin-bottom:5px;" width=1100px>
    <tr style="background-color:#265b8a;" "height:30px;font: 10pt arial, sans-serif;{{ themec }}">
        <th>Systems M&P</th>
        <th>Source</th>
        <th>Destination</th>        
    </tr>
    {% for _master in _table['MASTERS'] %}    
    {% for _client, _cdata in _table['MASTERS'][_master]['PEERS'].items() %}
    {% if _cdata[1]['TS'] == True or _cdata[2]['TS'] == True %}
    <tr style="background-color:#a1dcb5;">
        {% if _cdata[1]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#464646;">M: {{_master}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#0d1a81;">{{ _cdata[1]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:brown;">TS {{ 1 if _cdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#b5651d;">{{ _cdata[1]['DEST']|safe }}</td>
        {% endif %}
        {% if _cdata[2]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#464646"><b>M: {{_master}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#0d1a81;">{{ _cdata[2]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:brown;">TS {{ 1 if _cdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#b5651d;">{{ _cdata[2]['DEST']|safe }}</td>
        {% endif %}
    </tr>
    {% endif %}
    {% endfor %}
    {% endfor %}

{% else %}
         <table style='width:1100px; font: 13pt arial, sans-serif; margin-top:8px;'>
             <tr style='border:none; background-color:#f1f1f1;'>
             <td style='border:none;height:60px;'><font color=brown><b><center>Waiting for Data from FreeDMR Server ...</center></b></td>
             </tr>
            </table>
 {% endif %}
    {% for _peer, _pdata  in _table['PEERS'].items() %}
    {% if _pdata[1]['TS'] == True or _pdata[2]['TS'] == True %}
    <tr style="background-color:#f9f9f9f9;">
        {% if _pdata[1]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#464646;">P: {{_peer}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#0d1a81;">{{ _pdata[1]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:brown;">TS {{ 1 if _pdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#b5651d;">{{ _cdata[1]['DEST']|safe }}</td>
        {% endif %}
        {% if _pdata[2]['TRX'] == "RX" %}
        <td style="font-weight:bold; padding-left: 20px; text-align:center;color:#464646;">P: {{_peer}} </td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#0d1a81;">{{ _pdata[2]['SUB']|safe }} [<span style="align-items: center;justify-content:center;font-size: 8pt;font-weight:600;color:brown;">TS {{ 1 if _pdata[1]['TS'] == True else 2 }}</span>]</td>
        <td style="font: 9.5pt arial, sans-serif;font-weight: 600;color:#b5651d;">{{ _pdata[2]['DEST']|safe }}</td>
        {% endif %}
    </tr>
    {% endif %}
    {% endfor %}
    <tr style="background-color:#f0f0f0;"><td colspan=3 height=5pt><hr style="height:1px;border:none;color:#f0f0f0;background-color:#f0f0f0;"></hr></td></tr>

{% if _table['OPENBRIDGES']|length >0 %}
    <tr style="background-color:#265b8a;" "height:30px;width:1100px; font: 10pt arial, sans-serif;{{ themec }}">
        <th>Systems OpenBridge</th>
        <th colspan=2 '>Active Incoming Calls</th>
    </tr>
    {% for _openbridge in _table['OPENBRIDGES'] %}
    {% set rx = namespace(value=0) %}
    {% if _table['OPENBRIDGES'][_openbridge]['STREAMS']|length >0 %}
       {% for entry in _table['OPENBRIDGES'][_openbridge]['STREAMS'] if _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][0]=='RX' %}
         {% set rx.value=1 %}
       {% endfor %}
       {% if rx.value == 1 %}    
       <tr style="background-color:#de8184;">
         <td style="font-weight:bold; padding-left: 20px; text-align:center;"> {{ _openbridge}} </td>
         <td colspan=2 style="background-color:#a1dcb5; font: 9pt arial, sans-serif; font-weight: 600; color:#464646;">
         {% for entry in _table['OPENBRIDGES'][_openbridge]['STREAMS']  if _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][0] == 'RX' %}[<span style="color:#008000;">{{ _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][0] }}</span>: <font color=#0065ff> {{ _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][1] }}</font> >> <font color=#b5651d> {{ _table['OPENBRIDGES'][_openbridge]['STREAMS'][entry][2] }}</font>]&nbsp; {% endfor %}
        </td>
      </tr>
      {% endif %}
   {% endif %}
   {% endfor %}
{% endif %}
</table>
</fieldset>






{% if _table['SETUP']['LASTHEARD'] == True %}
<fieldset class="big">
  <legend><b>.: Lastheard :.</b></legend>
  <table class="log">
    <tr>
      <th>Date</th>
      <th>Time</th>
      <th>Callsign (DMR-Id)</th>
      <th>Name</th>
      <th>TG#</th>
      <th>TG Name</th>
      <th>TX (s)</th>
      <th>System</th>
    </tr>
  {% for itm in lastheard %}
    <tr>
      <td>{{ itm[0][:10] }}</td>
      <td>{{ itm[0][11:] }}</td>
    {% if not itm[7] %}
      <td class="txt-464646"><b>{{ itm[6] }}</b></td>
      <td></td>
    {% else %}
      <td><a target="_blank" href=https://qrz.com/db/{{itm[7][0]}}>{{ itm[7][0] }}</a></b><span class="fnt-7pt">&nbsp;({{ itm[6] }})</span></td>
      <td <span style="color: #000000;"><b>{{ itm[7][1] }}</b></td>
    {% endif %}
      <td class="txt-b5651d"><b>{{ itm[4] }}</b></td>
      <td <span style="color: #454545;"><b>{{ '' if not itm[5] else itm[5]|safe }}</b></td>
      <td {{ 'class="bkgnd-1d1"'|safe if not itm[1] else '' }}>{{ 'DATA' if not itm[1] else itm[1]|int }}</td>
      <td>{{ itm[3] }}</td>
    </tr>
  {% endfor %}
  </table>
</fieldset>
{% endif %}

<fieldset class="big">
  <legend><b>.: Connected to Server :.</b></legend>
  <div class="conn2srv">
{% if _table['MASTERS']|length >0 %}
<tr style="background-color:#A7A2A2;"><td>
<br>
<div style="text-align:left;"><span style="color:#464646;font-weight:600;line-height:1.4;">&nbsp;&nbsp;LINKS:</span></div>
<div style="text-align:left;font:9.5pt arial, sans-serif;font-weight:bold;margin-left:25px; margin-right:25px;line-height:1.4;white-space:normal;">
    {% for _master in _table['MASTERS'] %}    
    {% if _table['MASTERS'][_master]['PEERS']|length >0 %}
    {% for _client, _cdata in _table['MASTERS'][_master]['PEERS'].items() %}
    <span class="tooltip" style="border-bottom: 0px dotted white;">
    <a style="border-bottom: 0px dotted white;font: 9.5pt arial,sans-serif;font-weight:bold;color:#0066ff;" target="_blank" href="http://www.qrz.com/db/{{_cdata['CALLSIGN']}}"><b>{{_cdata['CALLSIGN']}}</b></a>
    <span class="tooltiptext" style="left:115%;top:-10px;">
        <span style="font: 9pt arial,sans-serif;color:#3df8f8">
        &nbsp;&nbsp;&nbsp;<b>DMR ID</b>: <b><font color=yellow>{{ _client }}</b></font><br>
        {% if _cdata['RX_FREQ'] == 'N/A' and _cdata['TX_FREQ'] == 'N/A' %}
             &nbsp;&nbsp;&nbsp;<b>Type: <font color=yellow>IP Network</font></b><br>
        {% else %} 
            &nbsp;&nbsp;&nbsp;<b>Type: <font color=yellow>Radio</font></b> ({{ _cdata['SLOTS'] }})<br>
        {% endif %}
        &nbsp;&nbsp;&nbsp;<b>Hardware</b>: {{_cdata['PACKAGE_ID'] }}
        <br>&nbsp;&nbsp;&nbsp;<b>Soft_Ver</b>: {{_cdata['SOFTWARE_ID'] }}
        <br>&nbsp;&nbsp;&nbsp;<b>Info</b>: {{_cdata['LOCATION']}}
         <br>&nbsp;&nbsp;&nbsp;<b>Master</b>: <font color=yellow>{{_master}}</font>
        </span></span></span>&nbsp;
    {% endfor %}
    {% endif %}
    {% endfor %}
</div>
{% endif %}

        {% if _table['PEERS']|length >0 %}
        <h4 class="tittle">PEERS:</h4>
        <div class="hs-peers">
          {% for _peer, _pdata  in _table['PEERS'].items() %}
          <div class="tooltip" style="border-bottom: 1px dotted white;{{'background-color:#98FB98; color:#464646;' if _table['PEERS'][_peer]['STATS']['CONNECTION'] == 'YES' else 'background-color:#ff0000; color:white;'}}"><b>&nbsp;&nbsp;{{_peer}}&nbsp;&nbsp;</b>
            {% if _table['PEERS'][_peer]['STATS']['CONNECTION'] == 'YES' %}
            <span class="tooltiptext c2s-pos2">Connected</span>
            {% else %}
            <span class="tooltiptext c2s-pos2"><b>Disconnected</b></span>
            {% endif %}
          </div>
          {% endfor %}
        </div>
        {% endif %}
  </div>
</fieldset>


EOF
#
sed -i "s/1100/1200/g" /opt/FDMR-Monitor/templates/*.*
sed -i "s/Copyright (c) 2016-.*/Copyright (c) <?php \$cdate=date(\"Y\"); if (\$cdate > \"2016\") {\$cdate=\"2016-\".date(\"Y\");} echo \$cdate; ?><br>/g" /var/www/fdmr/*.php
sed -i "s/meta name=\"description.*/meta name=\"description\" content=\"Copyright (c) 2016-22.The Regents of the K0USY Group. All rights reserved. Version OA4DOA 2022 (v270422)\">/g" /var/www/fdmr/*.php
sed -i '166 s/hotpink/#ad02fd/g'   /var/www/fdmr/css/styles.php
sed -i '217 s/color:white/color:black/'  /var/www/fdmr/css/styles.php
sed -i "251d" /var/www/fdmr/css/styles.php
sed '250 a    <?php echo THEME_COLOR."\\n";?>' -i /var/www/fdmr/css/styles.php

sed '21 a # For custom color, select: pro' -i /opt/FDMR-Monitor/fdmr-mon.cfg

sed '24 a COLOR_TEXT = #fff519' -i /opt/FDMR-Monitor/fdmr-mon.cfg 
sed '25 a COLOR_1 = #000080' -i /opt/FDMR-Monitor/fdmr-mon.cfg  
sed '26 a COLOR_2 = #193dff' -i /opt/FDMR-Monitor/fdmr-mon.cfg
#sed '27 a COLOR_BACKGROUND = 5a5958' -i /opt/FDMR-Monitor/fdmr-mon.cfg

sed '45 a   $cd1 = strtolower($config["GLOBAL"]["COLOR_1"]);' -i /var/www/fdmr/include/config.php  
sed '46 a   $cd2 = strtolower($config["GLOBAL"]["COLOR_2"]);' -i /var/www/fdmr/include/config.php  
sed '47 a   $cd3 = strtolower($config["GLOBAL"]["COLOR_TEXT"]);' -i /var/www/fdmr/include/config.php 
sed '48 a   $cd3 = strtolower($config["GLOBAL"]["COLOR_TEXT"]);' -i /var/www/fdmr/include/config.php
sed '49 a   $cd4 = strtolower($config["GLOBAL"]["COLOR_BACKGROUND"]);' -i /var/www/fdmr/include/config.php 

sed '66 a   } elseif ($theme == "pro") {' -i /var/www/fdmr/include/config.php  
sed '67 a     $tc = "background-image: linear-gradient(to bottom, $cd1 0%, $cd2 100%);color:$cd3;";' -i /var/www/fdmr/include/config.php  

sed -i "s/THEME_COLOR = .*/THEME_COLOR = pro/g" /opt/FDMR-Monitor/fdmr-mon.cfg
#sed -i "s/PEER_URL = .*/PEER_URL = https:\/\/freedmr-lh.gb7fr.org.uk\/json\/peer_ids.json/g" /opt/FDMR-Monitor/fdmr-mon.cfg
#sed -i "s/SUBSCRIBER_URL = .*/SUBSCRIBER_URL = https:\/\/freedmr-lh.gb7fr.org.uk\/json\/subscriber_ids.json/g" /opt/FDMR-Monitor/fdmr-mon.cfg
#sed -i "s/TGID_URL = .*/TGID_URL = https:\/\/freedmr.cymru\/talkgroups\/talkgroup_ids_json.php/g" /opt/FDMR-Monitor/fdmr-mon.cfg

python3 mon_db.py --create
python3 mon_db.py --update

systemctl stop apache2
systemctl disable apache2
#####################
sed -i 's/b1eee9/3bb43d/' /var/www/fdmr/css/*.*
sed -i "s/All rights reserved.<br>.*/All rights reserved.<br><a title=\"Raspbian Proyect by HP3ICC © <?php \$cdate=date(\"Y\"); if (\$cdate > \"2018\") {\$cdate=\"2018-\".date(\"Y\");} echo \$cdate; ?>\" target=\"_blank\" href=https:\/\/gitlab.com\/hp3icc\/fdmr\/>Proyect: FDMR+<\/a><br>/g" /var/www/fdmr/*.php

chmod +x /opt/FDMR-Monitor/sysinfo/*
sh /opt/FDMR-Monitor/sysinfo/rrd-db.sh
(crontab -l; echo "*/5 * * * * sh /opt/FDMR-Monitor/sysinfo/graph.sh")|awk '!x[$0]++'|crontab -
(crontab -l; echo "*/2 * * * * sh /opt/FDMR-Monitor/sysinfo/cpu.sh")|awk '!x[$0]++'|crontab -
##################
#Service
sudo cat > /lib/systemd/system/proxy.service <<- "EOF"
[Unit]
Description= Proxy Service 
After=multi-user.target

[Service]
#User=root
#Type=simple
#Restart=always
#RestartSec=3
#StandardOutput=null
ExecStart=/usr/bin/python3 /opt/FreeDMR/hotspot_proxy_v2.py -c /opt/FreeDMR/proxy.cfg
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
#########
bash -c "$(curl -fsSL https://raw.githubusercontent.com/hp3icc/D-APRS/main/emq-daprs.sh)"
#########
sudo cat > /lib/systemd/system/freedmr.service <<- "EOF"
[Unit]
Description=FreeDmr
After=multi-user.target

[Service]
#User=root
#Type=simple
#Restart=always
#RestartSec=3
#StandardOutput=null
ExecStart=/usr/bin/python3 /opt/FreeDMR/bridge_master.py -c /opt/FreeDMR/config/FreeDMR.cfg -r /opt/FreeDMR/config/rules.py
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
###
sudo cat > /lib/systemd/system/fdmrparrot.service <<- "EOF"
[Unit]
Description=Freedmr Parrot
After=network-online.target syslog.target
Wants=network-online.target

[Service]
#StandardOutput=null
WorkingDirectory=/opt/FreeDMR
#RestartSec=3
ExecStart=/usr/bin/python3 /opt/FreeDMR/playback.py -c /opt/FreeDMR/playback.cfg
#Restart=on-abort
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
#
cat > /lib/systemd/system/http.server-fdmr.service <<- "EOF"
[Unit]
Description=PHP http.server.fdmr
After=network.target

[Service]
#User=root
#ExecStartPre=/bin/sleep 30
# Modify for different other port
ExecStart=php -S 0.0.0.0:80 -t /var/www/fdmr/
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
#
cat > /lib/systemd/system/fdmr_mon.service  <<- "EOF"
[Unit]
Description=FDMR Monitor
# To make the network-online.target available
# systemctl enable systemd-networkd-wait-online.service
#After=network-online.target syslog.target
#Wants=network-online.target

[Service]
#User=root
#Type=simple
#Restart=always
#RestartSec=3
#StandardOutput=null
WorkingDirectory=/opt/FDMR-Monitor
ExecStart=python3 /opt/FDMR-Monitor/monitor.py
#Restart=on-abort
Restart=on-failure


[Install]
WantedBy=multi-user.target

EOF
#
bash -c "$(curl -fsSL https://gitlab.com/hp3icc/emq-TE1/-/raw/main/menu/menu-fdmr)"
###
chmod +x /bin/menu-fdmr
ln -sf /bin/menu-fdmr /bin/MENU-FDMR
sh /opt/extra-1.sh
sh /opt/extra-2.sh
####################################################################
#monitor2
if [ -f "/opt/wdp2" ]
then
   echo "found file"
else
cat > /opt/wdp <<- "EOFX"
#########################################
# Select number port, FreeDMR Dashboard #
#########################################

Web-Dashboar-Port:  80
EOFX
fi

cd /opt
sudo git clone https://github.com/CS8ABG/FDMR-Monitor.git /opt/FDMR-Monitor2
cd /opt/FDMR-Monitor2
sudo git checkout Self_Service
pip3 install -r requirements.txt

sed -i '72d' /opt/FDMR-Monitor2/html/include/navbar.php
sed '69 a \                <option value="es">ES</option>' -i /opt/FDMR-Monitor2/html/include/navbar.php
sed -i "s/root/emqte1/g"  /opt/FDMR-Monitor2/fdmr-mon_SAMPLE.cfg
sed -i "s/test/selfcare/g"  /opt/FDMR-Monitor2/fdmr-mon_SAMPLE.cfg
sed -i "s/PRIVATE_NETWORK = True/PRIVATE_NETWORK = False/g"  /opt/FDMR-Monitor2/fdmr-mon_SAMPLE.cfg
sed -i "s/with.*/with <a href=\"https:\/\/github.com\/CS8ABG\/FDMR-Monitor\" target=\"_blank\">FDMR-Monitor2<\/a> by <a title=\"CS8ABG Dash v23.07ss\" href=\"http:\/\/www.qrz.com\/db\/CS8ABG\"target=\"_blank\">CS8ABG<\/a> , Proyect: <a href=\"https:\/\/gitlab.com\/hp3icc\/fdmr\/\"target=\"_blank\">FDMR+<\/a><\/div>/g" /opt/FDMR-Monitor2/html/include/footer.php

sed -i "s/#fff/#d1d1d1/g"  /opt/FDMR-Monitor2/html/plugins/adminlte/css/adminlte.min.css
sed -i "s/f8f9fa/d0d0d0/g"  /opt/FDMR-Monitor2/html/plugins/adminlte/css/adminlte.min.css
sed -i "s/configFile =.*/configFile = '\/opt\/FDMR-Monitor2\/fdmr-mon.cfg';/g" /opt/FDMR-Monitor2/html/ssconfunc.php
#sed -i "s/configFile =.*/configFile = '\/opt\/FDMR-Monitor2\/fdmr-mon.cfg';/g" /var/www/fdmr2/ssconfunc.php

if [ ! -f "/opt/FDMR-Monitor2/html/flags/314.png" ]
then
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/314.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/315.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/318.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/319.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/320.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/321.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/322.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/323.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/324.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/325.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/326.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/327.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/328.png
   cp /opt/FDMR-Monitor2/html/flags/310.png /opt/FDMR-Monitor2/html/flags/329.png
fi

sudo cp fdmr-mon_SAMPLE.cfg fdmr-mon.cfg
sudo chmod 644 fdmr-mon.cfg
sudo cp /opt/FDMR-Monitor2/html/* /var/www/fdmr2/ -r

#*****
mv /opt/FDMR-Monitor2/utils/logrotate/fdmr_mon /opt/FDMR-Monitor2/utils/logrotate/fdmr_mon2
mv /opt/FDMR-Monitor2/utils/systemd/fdmr_mon.service /opt/FDMR-Monitor2/utils/systemd/fdmr_mon2.service
# \
sed -i "s/\/.*/\/opt\/FDMR-Monitor2\/log\/fdmr-mon.log {/g" /opt/FDMR-Monitor2/utils/logrotate/fdmr_mon2
sed -i "s/Description=.*/Description=FDMR Monitor2/g" /opt/FDMR-Monitor2/utils/systemd/fdmr_mon2.service
sed -i "s/WorkingDirectory=.*/WorkingDirectory=\/opt\/FDMR-Monitor2/g" /opt/FDMR-Monitor2/utils/systemd/fdmr_mon2.service
sed -i "s/ExecStart=.*/ExecStart=python3 \/opt\/FDMR-Monitor2\/monitor.py/g" /opt/FDMR-Monitor2/utils/systemd/fdmr_mon2.service

sudo cp /opt/FDMR-Monitor2/utils/logrotate/fdmr_mon2 /etc/logrotate.d/fdmr_mon2

sudo cp /opt/FDMR-Monitor2/utils/systemd/fdmr_mon2.service /lib/systemd/system/fdmr_mon2.service
sudo rm mon.db
sudo python3 mon_db.py

cat > /lib/systemd/system/http.server-fdmr2.service <<- "EOF"
[Unit]
Description=PHP http.server.fdmr2
After=network.target

[Service]
#User=root
#ExecStartPre=/bin/sleep 30
# Modify for different other port
ExecStart=php -S 0.0.0.0:80 -t /var/www/fdmr2/
Restart=on-failure

[Install]
WantedBy=multi-user.target

EOF
#############################
sudo systemctl daemon-reload
sudo systemctl start freedmr.service
sudo systemctl enable freedmr.service
sudo systemctl start proxy.service
sudo systemctl enable proxy.service
sudo systemctl start fdmr_mon.service
sudo systemctl enable fdmr_mon.service
sudo systemctl start fdmrparrot.service
sudo systemctl enable fdmrparrot.service
sudo systemctl start http.server-fdmr.service
sudo systemctl enable http.server-fdmr.service
menu-fdmr	
