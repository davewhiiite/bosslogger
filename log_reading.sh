#!/bin/bash

# log_reading.sh - actual API interface for bosslogger and Braiins OS+
# (C) Dave White, PE
# Released under the MIT License, see LICENSE file for more info

# reads input passed to log_reading.sh from bosslogger.sh
ip_address=$1 # ex: "192.168.1.111"
port=$2 # ex: "4028"

# date string is from the local logging machine, and included in the output log file
date_str=`date +"%Y-%m-%d %H:%M:%S"`

# read the entire output of the "summary" command from the BOS+ miner API. 
# last call removes spaces because I don't know how to use JQuery (jq) with spaces. Doesn't work for me. 
miner_info=`echo '{"command":"summary"}' | nc $ip_address $port | jq .SUMMARY | tr -d [:space:]`

# Example call to get 1-minute hashrate in MH/s:
# echo $miner_info | jq .[0].MHS1m

# Pick the various API properties from the "summary" command that you want to use, comment out the rest:
Accepted=`echo $miner_info | jq .[0].Accepted`
#BestShare=`echo $miner_info | jq .[0].BestShare`
#DeviceHardware=`echo $miner_info | jq .[0].DeviceHardware`
#DeviceRejected=`echo $miner_info | jq .[0].DeviceRejected`
DifficultyAccepted=`echo $miner_info | jq .[0].DifficultyAccepted`
#DifficultyRejected=`echo $miner_info | jq .[0].DifficultyRejected`
#DifficultyStale=`echo $miner_info | jq .[0].DifficultyStale`
#Discarded=`echo $miner_info | jq .[0].Discarded`
Elapsed=`echo $miner_info | jq .[0].Elapsed`
#FoundBlocks=`echo $miner_info | jq .[0].FoundBlocks`
#GetFailures=`echo $miner_info | jq .[0].GetFailures`
#Getworks=`echo $miner_info | jq .[0].Getworks`
#HardwareErrors=`echo $miner_info | jq .[0].HardwareErrors`
#Lastgetwork=`echo $miner_info | jq .[0].Lastgetwork`
#LocalWork=`echo $miner_info | jq .[0].LocalWork`
MHS15m=`echo $miner_info | jq .[0].MHS15m`
MHS1m=`echo $miner_info | jq .[0].MHS1m`
#MHS24h=`echo $miner_info | jq .[0].MHS24h`
MHS5m=`echo $miner_info | jq .[0].MHS5m`
#MHS5s=`echo $miner_info | jq .[0].MHS5s`
MHSav=`echo $miner_info | jq .[0].MHSav`
#NetworkBlocks=`echo $miner_info | jq .[0].NetworkBlocks`
#PoolRejected=`echo $miner_info | jq .[0].PoolRejected`
#PoolStale=`echo $miner_info | jq .[0].PoolStale`
#Rejected=`echo $miner_info | jq .[0].Rejected`
#RemoteFailures=`echo $miner_info | jq .[0].RemoteFailures`
#Stale=`echo $miner_info | jq .[0].Stale`
TotalMH=`echo $miner_info | jq .[0].TotalMH`
#Utility=`echo $miner_info | jq .[0].Utility`
#WorkUtility=`echo $miner_info | jq .[0].WorkUtility`


# convert MH/s to more legible, usable TH/s:
# scale = 1 means 1 decimal point. Add more if you want.
THS15m=`echo "scale=1; $MHS15m / 1000000.0" | bc -l`
THS1m=`echo "scale=1; $MHS1m / 1000000.0" | bc -l`
THS5m=`echo "scale=1; $MHS5m / 1000000.0" | bc -l`
THSav=`echo "scale=1; $MHSav / 1000000.0" | bc -l`
TotalTH=`echo "scale=1; $TotalMH / 1000000.0" | bc -l`

# prints the outfile data. Header shown for reference. You will need to update
# the output fields below if you choose to pick more API properties above.
# output format is dumb, comma-delimited strings.
#echo "Datetime,Accepted,DifficultyAccepted,Elapsed,THS15m,THS1m,THS5m,THSav,TotalTH"
echo "${date_str},${Accepted},${DifficultyAccepted},${Elapsed},${THS15m},${THS1m},${THS5m},${THSav},${TotalTH}"


# Appendix: representative data structure for $miner_info variable:
# $ echo '{"command":"summary"}' | nc $ip_address $port | jq .SUMMARY | tr -d [:space:]
# [
#   {
#     "Accepted": 9317,
#     "BestShare": 72712,
#     "DeviceHardware%": 0.0013343888621557241,
#     "DeviceRejected%": 0,
#     "DifficultyAccepted": 228531691,
#     "DifficultyRejected": 0,
#     "DifficultyStale": 0,
#     "Discarded": 0,
#     "Elapsed": 26232,
#     "FoundBlocks": 0,
#     "GetFailures": 0,
#     "Getworks": 1199,
#     "HardwareErrors": 98,
#     "Lastgetwork": 1601747796,
#     "LocalWork": 389590044,
#     "MHS15m": 38724260.71059759,
#     "MHS1m": 38673616.7353689,
#     "MHS24h": 11682449.53958147,
#     "MHS5m": 38644989.45066699,
#     "MHS5s": 38074915.67330639,
#     "MHSav": 38375042.039665885,
#     "NetworkBlocks": 0,
#     "PoolRejected%": 0,
#     "PoolStale%": 0,
#     "Rejected": 0,
#     "RemoteFailures": 0,
#     "Stale": 0,
#     "TotalMH": 1006684851794.8702,
#     "Utility": 21.310612991765783,
#     "WorkUtility": 537519.6880997238
#   }
# ]
