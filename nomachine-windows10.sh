wget -O ng.sh https://raw.githubusercontent.com/mercymercypeace/Pc/main/ngrok.sh > /dev/null 2>&1
chmod +x ng.sh
./ng.sh


function goto
{
    label=$1
    SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
    cd "$SCRIPT_DIR"
    cmd=$(sed -n "/^:[[:blank:]][[:blank:]]*${label}/{:a;n;p;ba};" $0 | 
          grep -v ':$')
    eval "$cmd"
    exit
}

: ngrok
clear
if [ ! -f ./ngrok ]; then
    echo "Ngrok binary not found! Downloading..."
    wget -O ng.sh https://raw.githubusercontent.com/mercymercypeace/Pc/main/ngrok.sh > /dev/null 2>&1
    chmod +x ng.sh
    ./ng.sh
fi
if [ ! -f ./ngrok ]; then
    echo "Failed to download ngrok! Please check your connection."
    exit 1
fi
chmod +x ./ngrok
clear
echo "Go to: https://dashboard.ngrok.com/get-started/your-authtoken"
read -p "Paste Ngrok Authtoken: " CRP
./ngrok config add-authtoken $CRP 
clear
echo "Repo: https://github.com/kmille36/Docker-Ubuntu-Desktop-NoMachine"
echo "======================="
echo "choose ngrok region (for better connection)."
echo "======================="
echo "us - United States (Ohio)"
echo "eu - Europe (Frankfurt)"
echo "ap - Asia/Pacific (Singapore)"
echo "au - Australia (Sydney)"
echo "sa - South America (Sao Paulo)"
echo "jp - Japan (Tokyo)"
echo "in - India (Mumbai)"
read -p "choose ngrok region: " REGION
pkill ngrok > /dev/null 2>&1
sleep 1
./ngrok tcp --region $REGION 4000 &>/dev/null &
sleep 3
for i in {1..10}; do
    if curl --silent --show-error http://127.0.0.1:4040/api/tunnels > /dev/null 2>&1; then 
        echo OK
        break
    fi
    if [ $i -eq 10 ]; then
        echo "Ngrok Error! Please try again!"
        pkill ngrok > /dev/null 2>&1
        sleep 1
        goto ngrok
    fi
    sleep 1
done
docker run --rm -d --network host --privileged --name nomachine-xfce4 -e PASSWORD=123456 -e USER=user --cap-add=SYS_PTRACE --shm-size=1g thuonghai2711/nomachine-ubuntu-desktop:windows10
sleep 2
clear
echo "NoMachine: https://www.nomachine.com/download"
echo Done! NoMachine Information:
echo "======================="
NGROK_IP=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -oP 'public_url":"tcp://\K[^"]*' | head -1)
if [ -z "$NGROK_IP" ]; then
    NGROK_IP=$(curl -s http://127.0.0.1:4040/api/tunnels | sed -nE 's/.*"public_url":"tcp:\/\/([^:"]+):([^"]+)".*/\1:\2/p' | head -1)
fi
if [ -n "$NGROK_IP" ]; then
    echo "IP Address: $NGROK_IP"
else
    echo "IP Address: (Getting IP address...)"
    sleep 3
    NGROK_IP=$(curl -s http://127.0.0.1:4040/api/tunnels | grep -oP 'public_url":"tcp://\K[^"]*' | head -1)
    if [ -n "$NGROK_IP" ]; then
        echo "IP Address: $NGROK_IP"
    else
        echo "IP Address: Unable to get IP. Check ngrok status."
    fi
fi
echo "User: user"
echo "Passwd: 123456"
echo "VM can't connect? Restart Cloud Shell then Re-run script."
seq 1 43200 | while read i; do echo -en "\r Running .     $i s /43200 s";sleep 0.1;echo -en "\r Running ..    $i s /43200 s";sleep 0.1;echo -en "\r Running ...   $i s /43200 s";sleep 0.1;echo -en "\r Running ....  $i s /43200 s";sleep 0.1;echo -en "\r Running ..... $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1;echo -en "\r Running  .... $i s /43200 s";sleep 0.1;echo -en "\r Running   ... $i s /43200 s";sleep 0.1;echo -en "\r Running    .. $i s /43200 s";sleep 0.1;echo -en "\r Running     . $i s /43200 s";sleep 0.1; done
