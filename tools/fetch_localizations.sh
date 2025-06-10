#!/bin/bash

POEDITOR_API_TOKEN="fcde9cb814366c1872727e6eae669d46"
POEDITOR_PROJECT_ID="569721"

LANGUAGES=("en" "nl")
ROOT_LOCALIZATION_FOLDER="./lib/l10n/"

#extractUrlFromPOEditorJson function which extracts the url from $json global variable
function extractUrlFromPOEditorJson {
    temp=`echo $json | sed 's/\\\\\//\//g' | sed 's/[{}]//g' | awk -v k="text" '{n=split($0,a,","); for (i=1; i<=n; i++) print a[i]}' | sed 's/\"\:\"/\|/g' | sed 's/[\,]/ /g' | sed 's/\"//g' | grep -w item`
    echo ${temp##*|}
}

function downloadOneLanguage {
    outputfile=$ROOT_LOCALIZATION_FOLDER"intl_"$1".arb"
    #first fetech the download url from po editor
    echo "*************** $1 ->  $outputfile ***************"
    echo Fetching POEditor URL...
    json=`curl -s -# -X POST https://poeditor.com/api/ \
    -d api_token="$POEDITOR_API_TOKEN" \
    -d action="export" \
    -d id="$POEDITOR_PROJECT_ID" \
    -d language="$1" \
    -d type="arb"`
    #fetch the actual strings file
    url=`extractUrlFromPOEditorJson`
    echo Downloading translation file...
    curl -# -s -X GET $url -o $outputfile
    echo Replacing special characters...
    #replace \\t
    sed -i '' -e 's/\\\\t/\\\t/g' $outputfile
    #replace \\n
    sed -i '' -e 's/\\\\n/\\\n/g' $outputfile
}

# Download each language
for i in "${LANGUAGES[@]}"
do
    downloadOneLanguage $i
done

# Generate locales
flutter pub global run intl_utils:generate