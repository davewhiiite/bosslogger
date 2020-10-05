#!/bin/bash

# bosslogger.sh - a data logger for the Braiins OS+ variety of bitcoin mining firmware 
# (C) Dave White, PE 2020
# Released under the MIT License, see LICENSE file for more info

# example of how to call this script and log to output:
# $ nohup ./bosslogger.sh  
# press ctrl + Z, then type "bg" to put task in background
# to see the output of your logfile do:
#	$ tail -f <logfile_date_str>.csv


#input miner info
ip_address="192.168.1.111" # change to your miner's address!
port="4028"
sampling_interval_sec=60 #sampling time in seconds. Recommended intervals are 60s, 300s, 900s (1m, 5m, 15m)

# sets an output file. You can change the naming convention however you like.
# note that the stdout is currently redirected to this $outfile, but could be changed if you want
date_str=`date +"%Y-%m-%d_%H_%M_%S"`
outfile="outfile_${date_str}.csv"

echo "bosslogger data logging for Antminer w/ Braiins OS+ started..."
echo "logging output to file: $outfile"

# prints the header of the file to stdout
echo "Datetime,Accepted,DifficultyAccepted,Elapsed,THS15m,THS1m,THS5m,THSav,TotalTH" >> $outfile

# simple, infinite loop to log each reading to the output.
# note: log_reading.sh does the interacting with the BOS+ API
while :
do
	./log_reading.sh $ip_address $port >> $outfile
	sleep $sampling_interval_sec
done