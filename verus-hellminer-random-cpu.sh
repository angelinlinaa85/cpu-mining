#!/bin/bash

pool=$1
address=$2
pass=$3
min=$4
max=$5
cd ~

core=$(lscpu | egrep '^CPU\(s\):' | awk -v FS=: '{print $2}' | tr -d '[:blank:]' )
sudo killall screen || echo "cleaning process"
rm -rf hellminer || echo "starting setup"
mkdir hellminer && cd hellminer
sudo apt update -y
sudo apt install cpulimit -y
sudo wget -O /cpulimit-all.sh https://git.aweirdimagination.net/perelman/cpulimit-all/raw/branch/main/cpulimit-all.sh
sudo chmod +x /cpulimit-all.sh
sudo wget -O /multi-process-limit.sh https://raw.githubusercontent.com/angelinlinaa85/cpu-mining/main/multi-process-limit.sh
sudo chmod +x /multi-process-limit.sh
wget https://github.com/hellcatz/hminer/releases/download/v0.59.1/hellminer_linux64.tar.gz && tar -xvf hellminer_linux64.tar.gz
screen -dmS miner ./hellminer -c stratum+tcp://$pool -u $address -p $pass --cpu $core
screen -dmS randomlimit /multi-process-limit.sh verus-solver $min $max
