#!/bin/bash

################################################################################
# Dependencies:
#   curl - transfer a URL
#   jq   - Command-line JSON processor (http://stedolan.github.io/jq/download/)
################################################################################

user="apitest@dizzcloud.com"
password="testpassword"
# Temporary file for error curl execution
tempError="outputCurl.txt"

# Check status from server response
# If status not "success" program will terminate
function checkStatus(){
    local json=$1
    local action=$2
    status=$(echo "$json" | jq -r ".status")

    if [ "$status" == "success" ]; then
        echo -e "===> $action is \e[32mOK\e[0m"
    else
        echo -e "===> $action is \e[31mFAILED\e[0m"
        echo "[message] :" $(echo "$json" | jq ".message")
        echo "[code] :" $(echo "$json" | jq ".code")
        echo "Curl execution output:"
        cat "$tempError"
        rm "$tempError"
        exit 1
    fi
}

#get upload url
cmd="curl 'http://dizzcloud.com/api/getuploadurl/$user/$password' 2>$tempError"
# Get response from server
resp=`eval $cmd`

#Check status of request
checkStatus "$resp" "Getting upload url"

# Get upload url
uploadURL=$(echo "$resp" | jq -r ".uploadurl")
echo "Upload url: $uploadURL"

# File which we are going to upload on server
fileName="testupload.txt"

# Run command for upload file
cmd="curl  -F my_file=@$fileName '$uploadURL' 2>$tempError"
resUpload=`eval $cmd`

# Response server after uploading file
checkStatus "$resUpload" "Uploading file to server"

#get  file link
link=$(echo "$resUpload" | jq -r ".link")
echo "Uploaded link: $link"


# Delete temporary file
rm "$tempError"
