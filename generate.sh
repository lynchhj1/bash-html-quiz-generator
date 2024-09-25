#!/bin/bash

usage() { echo "Usage: $0 [-i <InputFilename>] [-o <OutputFilename>]" 1>&2; exit 1; }

OPTSTRING=":i:o:"

while getopts ${OPTSTRING} opt; do
  case ${opt} in
    i)
      #echo "Option -i was triggered, Argument: ${OPTARG}"
      inputFile=${OPTARG};
      ;;
    o)
      #echo "Option -o was triggered, Argument: ${OPTARG}"
      outputFile=${OPTARG};
      ;;
    *)
      usage
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

if [ -z "${inputFile}" ] || [ -z "${outputFile}" ]; then
    usage
fi

IFS=:
tempFile=".tempFile"
templateFile="template.html"
newTitle=`echo ${outputFile%.*}`
i=0
q=0
touch $tempFile
rm $tempFile

while read key pair
	do
	##echo "$key $pair"
	i=$((i+1))
	case $key in
		'q')
			q=$((q+1))
			if [[ "$q" -ne 1 ]]; then echo "        </fieldset>" >> $tempFile; fi
			echo "        <fieldset id=\"q"$q"\">" >> $tempFile
			echo "          <legend>Question $q</legend>" >> $tempFile
                        echo "          <label>$pair</label><br>" >> $tempFile
    			;;
		'x')
                        echo "          <label><input type=\"radio\" name=\"q"$q"\" value=\"x\">$pair</label><br>" >> $tempFile
    			;;
		'w')
                        echo "          <label><input type=\"radio\" name=\"q"$q"\" value=\"w\">$pair</label><br>" >> $tempFile
    			;;
		'l')
                        echo "          <label>$pair</label><br>" >> $tempFile
    			;;
		'i')
                        echo "          <img src=\"$pair\" alt=\"$pair\" class="responsive"><br>" >> $tempFile
    			;;
	esac
done < $inputFile
echo "        </fieldset>" >> $tempFile

sed -e '/ReplaceMe/{r .tempFile' -e 'd}' $templateFile > $outputFile
sed -i "s/DumbTitle/$newTitle/g" $outputFile
exit 0

