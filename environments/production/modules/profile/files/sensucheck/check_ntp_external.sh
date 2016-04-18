#!/bin/bash
# gbolo
# Quick check for ntp offset of external ntp server

NTP_SERVER=$1
WARNING=0.5
CRITICAL=2.0
CMD="ntpdate -q $NTP_SERVER"
CMD_OUTPUT=$(ntpdate -q $NTP_SERVER 2>&1)

if [ $? -ne 0 ]
then
  echo "UNKNOWN: error executing $CMD"
  exit 2
fi

OFFSET=$(ntpdate -q $NTP_SERVER | tail -n1 | awk '{print $10}')
# Remove negative sign (-)
OFFSET_POSITIVE=$(echo "${OFFSET//-}")

if (( $(echo "$OFFSET_POSITIVE > $CRITICAL" | bc -l) )); 
then
  echo "CRITCAL: time offset by ${OFFSET} sec"
  exit 2
elif (( $(echo "$OFFSET_POSITIVE > $WARNING" | bc -l) ));
then
  echo "WARNING: time offset by ${OFFSET} sec"
  exit 1
else
  echo "OK: time offset by ${OFFSET} sec"
  exit 0
fi
