# bosslogger
Shell scripts for logging data from bitcoin miners using Braiins OS firmware

README.md

"bosslogger" is a shell script data logger for the Braiins OS+ variety of bitcoin mining firmware 
(C) Copyright 2020 Dave White, PE 
Released under the MIT License, see LICENSE file for more info
Disclaimer: The bosslogger was developed in support of, but not affiliated with Braiins OS(+), SlushPool, or Braiins Systems in any way. Braiins OS, Braiins OS+, and SlushPool are copyrights and/or trademarks of Braiins Systems.

## DEPENDENCIES ##
-- the system is just two shell scripts. It should work with any Linux environment with bash
-- Other software required: nc, jq, bc. To install:
	# sudo apt-get install nc jq bc

## USAGE ##
1. IF the scripts are not executable, make it so:
	$ cd bosslogger/
	$ chmod u+x bosslogger.sh log_reading.sh


2. Call the main script to start logging to output:
	$ nohup ./bosslogger.sh  
	# press ctrl + Z, then type "bg" to put task in background. 

3. Keep an eye on your miner's performance:
	$ tail -f <logfile_date_str>.csv

4. Currently, this program only supports instances for a single miner. That said, it could be easily adapted
to include polling for multiple units. You'd then just want to identify them uniquely, say, by IP address
or a hardware ID. I'd recommend dumping the output into the same .csv file, then you can just upload the 
data in bulk to a SQL database, then group by IP or hardware ID, to recover the data in a cleaner form.

## CONTACT ##
If you like this script you can contribute, find or contact me here:
Github: https://github.com/davewhiiite/bosslogger
Twitter: https://twitter.com/DavesWarez
Medium: https://medium.com/bitcoin-by-command-line