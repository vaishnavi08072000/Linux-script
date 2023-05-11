#!/bin/bash

date=$(date "+%m %d %Y" )
who=$(whoami)
time=$(date  "+%H:%M PM")
IP=$(ifconfig | tr -s " " | head -2 | tail -1 | cut -d " " -f3)
Hostname=$(hostname -d)
os=$(uname)
Kernal=$(uname -r)
ar=$(uname -i)


uptime=$(uptime -p)
cuser=$( who | wc -l)
cprocess=$(ps aux | wc -l)
cpu=$( cat /proc/loadavg | awk '{print $3}')
umem=$( free -b | head -2 | tail -1 | tr -s " " | cut -d " " -f3)
tmem=$( free -b | head -2 | tail -1 | tr -s " " | cut -d " " -f2)
l1=$( uptime | awk '{print $9}')
l2=$( uptime | awk '{print $9}')
l3=$( uptime | awk '{print $9}')

process1=$( ps -eo user,pid,cmd,%cpu,%mem --sort=%mem | head )

c_userlogin=$(w)


name=$( df -H | tail -2 | head -1 | awk '{print $1}')
size=$( df -H | tail -2 | head -1 | awk '{print $2}')
fsize=$( df -H | tail -2 | head -1 | awk '{print $4}')

Name=$( df -H | tail -3 | head -1 | awk '{print $1}')
Size=$( df -H | tail -3 | head -1 | awk '{print $2}')
Fsize=$( df -H | tail -3 | head -1 | awk '{print $4}')

partition=$( df -h)

cpu_avg=$(iostat | awk '{print $5}' | tail -6 | head -1)
device=$( iostat |tail -4 )


ethO=$( ifconfig | tr -s " " | head -2 | tail -1 | cut -d " " -f3)
lol=$(ifconfig | tr -s " " | tail -8 | head -1 | cut -d " " -f3)
hostname=$(hostname -s)
domainname=$(hostname -d)
gateway=$( ifconfig | tr -s " " | head -2 | tail -1 | cut -d " " -f7)
DNS=$( ifconfig | tr -s " " | head -2 | tail -1 | cut -d " " -f7)
MAC=$(ifconfig | head -4 | tail -1 | tr -s " " | cut -d " " -f3)
DHCP=$()
dhcp=$( if [ $DHCP  ]; then
echo "Yes"
else
echo "NO"
fi )

IPf=$(cat /proc/sys/net/ipv4/ip_forward)
IP1=$( if [ $IPf == 0 ]; then
echo "NO"
else
echo "Yes"
fi )

STATUS="$(systemctl is-active firewalld.service)"
STATUS1=$(if [ "${STATUS}" = "active" ]; then
    echo "Yes"
else
    echo " No"
    exit 1  
fi
 )


ports=$(firewall-cmd --list-ports)

runlevel=$(systemctl list-units --type=service --state=running | sort)


cc=$( netstat -at | wc -l)
IPs=$( netstat -at | awk '{print NR $4}' | grep ip | head -4 | cut -d "." -f1)


nuser=$(cat /etc/passwd -n | wc -l)
user=$(uptime | tr -s " " | cut -d " " -f5)
sudouser=$(uptime | tr -s " " | cut -d " " -f5)
sudogroup=$(cat /etc/group | head -1 | wc -l | cut -d ":" -f1 )
perm=$( find /etc/passwd -perm 777 | wc -l)
suidbit=$(find /etc/passwd -perm 4000 | wc -l)
perm_etc=$(find /etc/passwd -perm 744 | wc -l)
perm_shadow=$(find /etc/passwd -perm 000 | wc -l )


                         echo "Server Report"

 echo "---------------------------------------------------------------------------------------------------------------"
   echo "Date=$date" echo "$time" echo "                                " echo "By : $who"
  echo "
"
echo "Basic Server Information"
echo "----------------------------------------------------------------------------------------------------------------"

echo "IP              : $IP"
echo "Hostname        : $Hostname"
echo "OS              : $os"
echo "Kernal          : $Kernal"
echo "Architecture    : $ar"
echo "

"
echo "Up time         : $uptime"
echo "Current User    : $cuser"
echo "Current Process : $cprocess"
echo "Cpu usage       : $cpu %"
echo "Memory Usage    : $umem MB out of $tmem MB"
echo "System load     : $l1  $l2 $l3"
echo "

"

   echo "Process Load (processes taking higher resources) "
echo "------------------------------------------------------------------------------------------------------------------"
echo " $process1 "
echo "

"

 echo " List of Users Currently Logged in(sorted by number of sessions)"
echo "------------------------------------------------------------------------------------------------------------------"
echo "$c_userlogin"
echo "

"
 echo "Storage Information"
echo "------------------------------------------------------------------------------------------------------------------"

echo "Disk No 1 :"

echo " Name       : $name"
echo " Size       : $size G"
echo " Free Space : $fsize G"


echo "Disk No 2 :"

echo " Name       : $Name"
echo " Size       : $Size G"
echo " Free Space : $Fsize G"
echo "

"
echo "Partition/File System Information"
echo "-----------------------------------------------------------------------------------------------------------------"
echo "$partition"
echo "

"
  echo "LVM Information"
echo "-----------------------------------------------------------------------------------------------------------------"
echo "

"
  echo "I/O statistics"
echo "-----------------------------------------------------------------------------------------------------------------"

echo "Cpu Average I/O Wait : $cpu_avg %"

echo "$device"
echo "

"
  echo "Network Information"
echo "----------------------------------------------------------------------------------------------------------------"

echo "ethO                  : $ethO"
echo "lol                   : $lol"
echo "Hostname              : $hostname"
echo "Domain name           : $domainname"
echo "Gateway               : $gateway"
echo "DNS                   : $DNS"
echo "MAC                   : $MAC"
echo "DHCP enabled          : $dhcp"
echo "IP Forwarding enabled : $IP1"
echo "Firewall 0n           : $STATUS1"
echo "List of open ports    : $ports1"
echo "

"
  echo "Network Connections"
echo "----------------------------------------------------------------------------------------------------------------"

echo "Current Connections (TCP) : $cc "
echo "Connections from the following IPs :     "
echo "$IPs"
echo "

"
   echo "Alphabetical List of services turned on at run level 3"
echo "---------------------------------------------------------------------------------------------------------------"
echo "$runlevel"
echo "

"
  echo "User Information"
echo "--------------------------------------------------------------------------------------------------------------"
echo "Total Number of Users                : $nuser "
echo "Total Number of super users          : $user"
echo "List of sudo users                   : $sudouser "
echo "List of sudo groups                  : $sudogroup"
echo "Number of files with 777 permissions : $perm "
echo "Number of files with suid bit        : $suidbit "
echo "Permission of /etc/passwd file       : $perm_etc "
echo "Permission of /etc/shadow file       : $perm_shadow "
echo "Users without password expiry        :  "
echo "

"
