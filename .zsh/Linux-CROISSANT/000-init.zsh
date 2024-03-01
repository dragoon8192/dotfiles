#minttyのカラー設定
source ~/etc/mintty-colors-solarized/sol.light
#X11
#export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0.0
#export LIBGL_ALWAYS_INDIRECT=yes
#xauth
#xauth generate $DISPLAY
#homebrew
export HOMEBREW_PREFIX=$(brew --prefix)
export HOMEBREW_CELLAR=$(brew --prefix)"/Cellar";
export HOMEBREW_REPOSITORY=$(brew --prefix)"/Homebrew";

#ssh接続用のポートフォワーディング
IP=$(ip addr show eth0 | grep 'inet ' | grep -E '[0-9]{,3}\.[0-9]{,3}\.[0-9]{,3}\.[0-9]{,3}' -o | sed -n '1p')
netsh.exe interface portproxy delete v4tov4 listenport=31522
netsh.exe interface portproxy add    v4tov4 listenport=31522 connectaddress=$IP connectport=22
# sc.exe config iphlpsvc start=auto
# sc.exe start  iphlpsvc
# sudo service ssh start
