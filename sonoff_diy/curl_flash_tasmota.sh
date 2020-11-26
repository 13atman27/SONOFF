echo " --------------------------------- "
echo " SONOFF DIY - FLASH a new firmware "
echo "                 done by 13atman27 "
echo " --------------------------------- "
echo " "
echo " The WIFI network as to be configure like that:"
echo "        SSID : sonoffDiy"
echo "        PWD  : 20170618sn"
echo ""
echo " Warning : "
echo "      #1 - the SSID is case sensitive. "
echo "      #2 - security WPA/WPA2 - personnel"


if [ $# -eq 0 ] ; then
    echo "The first parameters must be the IP address of the SONOFF device"
    exit -1
fi

echo "#1 Test the network configuration : ping -c1 google.com"
while ! ping -c1 google.com &>/dev/null
        do echo "Your network is not connected to internet, it must be!"
        exit -2

done
echo "    --> #1 network configuration  : OK"

echo "#2 Test the IP of the SONOFF device: ping -c1 $1"
while ! ping -c1 "$1" &>/dev/null
        do echo "The IP of the SONOFF device cannot be reach."
done
echo "    --> #2 reach the SONOFF device : OK"
curl http://$1:8081/zeroconf/info -XPOST --data '{"deviceid":"","data":{} }'
echo " Unlock the OTA to allow update firmware"
curl http://$1:8081/zeroconf/ota_unlock -XPOST --data '{"deviceid":"","data":{} }'
echo " Check otqUnlock is true"
curl http://$1:8081/zeroconf/info -XPOST --data '{"deviceid":"","data":{} }'
echo " Download firmware"
curl http://$1:8081/zeroconf/ota_flash -XPOST --data '{"deviceid":"","data":{"downloadUrl":"http://192.168.2.103/tasmota-lite.bin","sha256sum":"98ecfd69041ed46679a1b5bd892dd9cc0f4592db4d73373424377a871081e79a"}}'


echo $response