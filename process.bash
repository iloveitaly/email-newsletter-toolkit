#!/usr/bin/env bash

cd `dirname $0`

if [[ ! -e $PWD/processed ]]; then
	mkdir $PWD/processed
fi

# vars to place in folder/config.bash
BASE_URL="http://default-domain.com/email-assets/"

find $PWD -and -not -path "*.git" -and -name "*html" -and -not -path "*processed*" -mtime -5m | while read emailFile; do
	emailFolder=`dirname $emailFile`
	processedFolder=`dirname $emailFolder`/processed/`basename $emailFolder`
	processedFileName=$processedFolder/`basename $emailFile`
	
	if [[ ! -e $processedFolder ]]; then
		mkdir $processedFolder
	fi
	
	# pull in a config file for BASE_URL and others in the future
	if [[ -e $emailFolder/config.bash ]]; then
		. $emailFolder/config.bash
	fi
	
	echo $emailFile
	premailer \
	--remove-classes \
	--base-url "$BASE_URL" \
	$emailFile > $processedFileName

	premailer \
	--mode txt \
	--remove-classes \
	--base-url "$BASE_URL" \
	$processedFileName > ${processedFileName%%".html"}.txt
done

exit 0
