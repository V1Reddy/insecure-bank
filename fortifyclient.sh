#!/bin/bash

downloadFPR=''
uploadFPR=''

while getopts yzu:t:d:f:a:v: opt
do
    case "${opt}" in
        u) url=${OPTARG};;
        t) authtoken=${OPTARG};;
        d) downloadFPR=${OPTARG};;
        f) file=${OPTARG};;
        a) application=${OPTARG};;
        v) applicationVersion=${OPTARG};;
        y) downloadFPR='true'
            echo "downloadFPR" ;;
        z) uploadFPR='true'
            echo "uploadFPR" ;;
        ?) echo "script usage: $(basename \$0) [-y] [-z] [-a somevalue]" >&2
            exit 1 ;;
    esac
done

echo "url: $url";
echo "authtoken: $authtoken";
echo "Download FPR: $downloadFPR";
echo "file: $file";

if [ "$downloadFPR" = "true" ]; then
    echo "The command is for downloadFPR..."
elif [ "$uploadFPR" = "true" ]; then
    echo "The command is for uploadFPR..."
else
    echo "None."
fi
