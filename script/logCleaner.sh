#!/bin/bash

#************************************************#
#                   log_cleaner.sh
#              written by kh902.kim
#                 Jan 13, 2015
#************************************************#

targetDate=`date '+%Y%m%d' -d '1 month ago'`
defaultDir="/mnt/logs/"

auth ()
{
	dirRm $defaultDir"tauth/"
}

proxy ()
{
	dirRm $defaultDir"nginx/"
	logRm $defaultDir"nginx/"
}

ts ()
{
	dirRm $defaultDir"tapi/"
	dirRm $defaultDir"tapi/translation/"
	logRm $defaultDir"ts_log/"
}

dirRm ()
{
	echo ""
	echo "$1 dir clean start."
	
	for date in `ls $1 | grep ^20`
	do
		if [ "$date" -lt "$targetDate" ]
		then
			echo $1$date"/"
			rm -rf $1$date

		elif [ "$date" -eq "$targetDate" ]
		then
			break
		fi
	done
}

logRm ()
{
	echo ""
	if [ "$1" = $defaultDir"nginx/" ]
	then
		echo "$1access.log clean start."
		
		accessLogTargetDate=`date '+%Y%m%d00' -d '1 month ago'`
		
		for date in `ls $1 | grep access.log.20 | sed 's/access.log.//g'`
		do
			if [ "$date" -lt "$accessLogTargetDate" ]
			then
				echo "access.log.$date"
				rm $1"access.log.$date"
			
			elif [ "$date" -gt "$accessLogTargetDate" ]
			then
				break
			fi
		done
	
	elif [ "$1" = $defaultDir"ts_log/" ]
	then
		echo "ts log clean start"
		
		for engine in `ls $1`
		do
			echo $1$engine"/"
			
			for date in `ls $1$engine | sed -e 's/MT_//g' -e 's/.log//g'`
			do
				if [ "$date" -lt "$targetDate" ]
				then
					echo "MT_$date.log"
					rm $1$engine"/MT_"$date".log"
				
				elif [ "$date" -eq "$targetDate" ]
				then
					break
				fi
			done
		done
		
	fi
}



hostname=`hostname`

biz=`grep $hostname /home/stpusr/log_cleaner.sh | awk '{print $2}'`

[ -z "$biz" ] && { echo "Check hostname. log_cleaner is not started.";exit 0; }

echo "$biz server log clean"

case $biz in
	"AUTH") auth;;
	"PROXY") proxy;;
	"TS") ts;;
	*) echo "not AUTH, PROXY, TS.";;
esac

echo ""
echo "nagios log clean start."
sudo find /home/nagios/jnrpeagent/log/biz -name Biz.Oss_JNRPE.log.* -mtime +30 -exec rm {} \;
echo "nagios log clean end."



echo ""
echo "log_cleaner complete."


# PRD
# AUTH auth 01 ip-100-20-4-22
# AUTH auth 02 ip-100-20-5-22
# REPO chefrepo ip-100-20-1-11
# MONITOR monitor 01 ip-100-20-1-12
# PROXY proxy 01 ip-100-20-4-21
# PROXY proxy 02 ip-100-20-5-21
# PROXY cn-proxy 01 ip-100-20-4-24
# PROXY cn-proxy 02 ip-100-20-5-24
# RMC rmc 01 ip-100-20-1-13
# MEMCACHE memcached 01 ip-100-20-4-50
# MEMCACHE memcached 02 ip-100-20-5-50
# MEMCACHE cn-memcached 01 ip-100-20-4-51
# MEMCACHE cn-memcached 02 ip-100-20-5-51
# TS DE 01 ip-100-20-4-33
# TS DE 02 ip-100-20-5-33
# TS ES 01 ip-100-20-4-34
# TS ES 02 ip-100-20-5-34
# TS FR 01 ip-100-20-4-43
# TS FR 02 ip-100-20-5-43
# TS IT 01 ip-100-20-4-44
# TS IT 02 ip-100-20-5-44
# TS JPCN 01 ip-100-20-4-37
# TS JPCN 02 ip-100-20-5-37
# TS JPUS_CNUS 01 ip-100-20-4-38
# TS JPUS_CNUS 02 ip-100-20-5-38
# TS KR 01 ip-100-20-4-30
# TS KR 02 ip-100-20-5-30
# TS PT 01 ip-100-20-4-45
# TS PT 02 ip-100-20-5-45
# TS RU 01 ip-100-20-4-46
# TS RU 02 ip-100-20-5-46
# TS TRFA 01 ip-100-20-4-42
# TS TRFA 02 ip-100-20-5-42
# TS ARHI 01 ip-100-20-4-40
# TS ARHI 02 ip-100-20-5-40