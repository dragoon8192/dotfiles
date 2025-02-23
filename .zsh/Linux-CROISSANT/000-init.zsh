# #minttyのカラー設定
source ~/etc/mintty-colors-solarized/sol.light

# #ポートフォワーディング
WSL2_IPV4=$(ip route | grep -Po '(?<=eth0 proto kernel scope link src )(\d{1,3}\.){3}\d{1,3}')
HOST_IPV4=0.0.0.0
LISTEN_PORTS=(22 1334 7860 8000)
PORT_SHIFT=50000
for port in $LISTEN_PORTS ; do
    netsh.exe interface portproxy delete v4tov4 listenport=$(($port + $PORT_SHIFT)) 1> /dev/null
    netsh.exe interface portproxy add    v4tov4 listenaddress=$HOST_IPV4 listenport=$(($port + $PORT_SHIFT)) connectaddress=$WSL2_IPV4 connectport=$port 1> /dev/null
done
netsh.exe interface portproxy show all
