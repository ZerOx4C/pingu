#!/bin/bash

set -u

function date2() {
	RET=`date -Iseconds`
	RET=${RET%+*}
	RET=${RET//T/ }
	RET=${RET//-//}
	echo ${RET}
}

LOGNAME=`date2`00.log
LOGNAME=${LOGNAME////}
LOGNAME=${LOGNAME//:/}
LOGNAME=${LOGNAME// /_}

IPADDR=$1

echo ${IPADDR} > ${LOGNAME}

while :; do
	DATETIME=`date2`
	ping ${IPADDR} -c 1 > /dev/null
	if [[ $? -ne 0 ]]; then
		STAT=NG!
	else
		STAT=OK
	fi

	if [[ ${STAT} = OK ]]; then
		echo -e "\033[92m${DATETIME} ${STAT}\033[0m"
	else
		echo -e "\033[91m${DATETIME} ${STAT}\033[0m"
	fi

	echo ${DATETIME} ${STAT} >> ${LOGNAME}
	sleep 60
done
