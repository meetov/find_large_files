#!/bin/sh
## Usage: find_large_files START_DIR

SCRIPT_NAME=$(basename $0)
START_DIR=$1
DEFAULT_DISPLAY_LIMIT=100

if [ ! ${START_DIR} ]; then
	echo "Usage: ${SCRIPT_NAME} START_DIR [LIMIT]"
	exit 1
fi

RESULTS=$(find ${START_DIR} -type f -printf "%s;%p\n"  2>/dev/null | sort -n | tail -n $DEFAULT_DISPLAY_LIMIT)

for RESULT in ${RESULTS}
do
	FILE_SIZE_B=$(echo "${RESULT}" | cut -d ';' -f 1) 
	# for some reason the %s sometimes returns a filename instead of size as integer
	if ! [[ ${FILE_SIZE_B} =~ ^[0-9]+$ ]]; then  
		continue 
	else
		FILE_NAME=$(echo "${RESULT}" | cut -d ';' -f 2)
		FILE_SIZE_MB=$(( ${FILE_SIZE_B} / 1024 / 1024 ))
		echo -e "${FILE_SIZE_MB}M\t${FILE_NAME}"
	fi
done
