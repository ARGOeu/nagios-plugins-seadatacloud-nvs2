#!/bin/bash

#The command ./nerc_xml_check.sh -u http://vocab.nerc.ac.uk/collection/ -d "Oregon State Coastal Management Program"
#URI="http://vocab.nerc.ac.uk/collection/"
#DUMMY_STRING="Oregon State Coastal Management Program"

# function for help message
usage () {
cat <<EOF
Usage: $me [options]
Script to check the xml validity of NERC Vocab Collection URL
and the existence of a predefined Dummy String.

Options:
  -u, --url <URL>                       URL of Welcome Login Page
  -d, --dummy <STRING>                  Define string to search for.
  -t, --connect-timeout <seconds>       Maximum time allowed for connection (default: 10s)
  -h, --help                            Print this help text.
EOF
}

# function for parsing arguments
POSITIONAL=()
while [[ $# -gt 0 ]]
do
key="$1"

case $key in
    -u|--url)
    URL="$2"
    shift # past argument
    shift # past value
    ;;
    -d|--dummy)
    DUMMY="$2"
    shift # past argument
    shift # past value
    ;;
    -t|--connect-timeout)
    TIMEOUT="$2"
    if [ -z "$TIMEOUT" ] || [[ "$TIMEOUT" =~ ^-.* ]]
    then
        TIMEOUT=10      # if TIMEOUT is not set, but '-t' option is used, fall to default 10 seconds
        shift
    else
    shift # past argument
    shift # past value
    fi
    ;;
     -h|--help)
     usage; exit 3 ;;
    *)    # unknown option
    POSITIONAL+=("$1") # save it in an array for later
    shift # past argument
    ;;
esac
done
set -- "${POSITIONAL[@]}" # restore positional parameters


# Check if required options are passed(empty or dash(-))
if [ -z "$URL" ] || [[ "$URL" =~ ^-.* ]]
  then
        echo "UNKNOWN - No URL is defined | UNKNOWN - No URL is defined"
        exit 3
fi
if [ -z "$DUMMY" ] || [[ "$DUMMY" =~ ^-.* ]]
 then
        echo "UNKNOWN - No DUMMY STRING is defined | UNKNOWN - No DUMMY STRING is defined"
        exit 3
fi
if [ -z "$TIMEOUT" ] || [[ "$TIMEOUT" =~ ^-.* ]]
 then
	TIMEOUT=10
fi


################################################################
# Capture HTTP STATUS CODE in variable
STATUS=$(curl -iL  -w '%{http_code}\n' -s -o /dev/null ${URL})

#CHECK if HTTP STATUS CODE is 200
if [ ${STATUS} -eq 200 ];then
#        echo "[+] HTTP STATUS CODE is ${STATUS}"
	# GET xml with Accept Header
	curl -s -o vocab.nerc.ac.uk.xml ${URL} -H "Accept: application/rdf+xml" --connect-timeout ${TIMEOUT}

	# Check if the XML CODE is valid and capture it in a variable
	VALID="$(xmlstarlet val -w vocab.nerc.ac.uk.xml | grep -w valid)"
	# Capture the RETURN CODE of the above command in a variable
	VALID_GREPED=$(echo $?)
	# Check if the RETURN CODE is '0'
	if [ ${VALID_GREPED} -eq 0 ];then
#	       echo "[+] The XML code is VALID"
        
		# Check if the DUMMY_STRING exists in the returned XML CODE
        	curl -L ${URL} -s | fgrep "$DUMMY" > /dev/null
        	if [ $? -eq 0 ];then
			echo "OK - HTTP STATUS CODE is ${STATUS} - The XML code is VALID - The DUMMY string EXISTS| http_status_code=${STATUS}, xml_valid=0, dummy_str_exists=0"
                	exit 0
        	else
                	echo "CRITICAL - The DUMMY string does NOT EXIST | http_status_code=${STATUS}, xml_valid=0, dummy_str_exists=1"
                	exit 2
        	fi

	else
        	echo "CRITICAL - The XML code is NOT valid| http_status_code=${STATUS}, xml_valid=1,  dummy_str_exists=3"    
        	exit 2
	fi
else
        echo "CRITICAL - HTTPS STATUS CODE is ${STATUS} | http_status_code=${STATUS}, xml_valid=3, dummy_str_exists=3"
        exit 2
fi
