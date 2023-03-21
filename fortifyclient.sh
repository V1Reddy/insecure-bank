#!/bin/bash

downloadFPR=''
uploadFPR=''

while getopts yzu:t:d:f:a:v: opt
do
    case "${opt}" in
        u) url=${OPTARG};;
        t) authtoken=${OPTARG};;
        f) file=${OPTARG};;
        a) application=${OPTARG};;
        v) applicationVersion=${OPTARG};;
        d) downloadFPR='true'
            echo "downloadFPR" ;;
        z) uploadFPR='true'
            echo "uploadFPR" ;;
        ?) echo "script usage: $(basename \$0) [-d] [-z] [-a somevalue]" >&2
            exit 1 ;;
    esac
done

echo "url: $url";
echo "application: $application";
echo "application version: $applicationVersion";
echo "Download FPR: $downloadFPR";
echo "Upload FPR: $uploadFPR";
echo "file: $file";

if [ "$downloadFPR" = "true" ]; then
    echo "The command is for downloadFPR..."
elif [ "$uploadFPR" = "true" ]; then
    echo "The command is for uploadFPR..."
else
    echo "None."
fi
