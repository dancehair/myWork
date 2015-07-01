#!/bin/bash
#************************************************#
#                   s3cmd_sgmp.sh
#                 May 14, 2014
#               s3 log check for sgmp
#************************************************#

#SGMP Excute Shell Script Sample Code
###################Status Check Exit CODE
# UNKNOWN_CODE=3
CRITICAL_CODE=2
#WARNING_CODE=1
OK_CODE=0

status="OK"

#authbiz01=0
#authgld01=1
#proxyeuw01=2
#authbiz02=3
#authgld02=4
#proxyeuw02=5
#proxyane01=6
#proxyane02=7
#proxycnane01=8
#proxycnane02=9
#proxyusw01=10
#proxyusw02=11

log_count=( 0 0 0 0 0 0 0 0 0 0 0 0 )
array_count=0
exit_code=$OK_CODE
date=`date -d yesterday +%Y%m%d`

if [ `date "+%H"` -ne "01" ]
then
	echo "It's Not a time"
	exit $exit_code
else
	for region in euw1 ane1 cnane1 usw1
	do
		for server in 01 02
		do
			if [ "$region" = "euw1" ]
			then
				for auth in biz gld
				do
					log_count[$array_count]=`s3cmd ls s3://prd-$region-trans-log/$date/auth/$auth/$server/ | wc -l`
					if [ "${log_count[$array_count]}" -lt "24" ]
					then
						exit_code=$CRITICAL_CODE
						status="Fail"
					fi
					let array_count+=1
				done
			fi
			
			log_count[$array_count]=`s3cmd ls s3://prd-$region-trans-log/$date/proxy/acc/$server/ | wc -l`
			if [ "${log_count[$array_count]}" -eq 0 ]
			then
				exit_code=$CRITICAL_CODE
				status="Fail"
			fi
			let array_count+=1
		done
	done

	echo "biz01=${log_count[0]} biz02=${log_count[3]} gld01=${log_count[1]} gld02=${log_count[4]} eu01=${log_count[2]} eu02=${log_count[5]} an01=${log_count[6]} an02=${log_count[7]} cn01=${log_count[8]} cn02=${log_count[9]} us01=${log_count[10]} us02=${log_count[11]} -- Status=$status"

	exit $exit_code
fi