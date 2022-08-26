#!/bin/sh
# ------------------------------------------------------------------------------
# Filter Yaml using YQ
#
# viyancs
#
# Check version of API yaml Kubernetes system
# ------------------------------------------------------------------------------
version='1.0.0'

usage() {
  cat <<EOF
  usage: yq eval '{key}' [options]

  -h           optional  Print this help message
  -f FILE      required  singgle target file
EOF
}

getapi() {
    dir=$PWD
    if [ ! -f "$dir/yq" ]; then
        curl -LO https://github.com/mikefarah/yq/releases/download/v4.27.2/yq_linux_amd64 -O yq
        ls -lah
        mv yq_linux_amd64 yq
        chmod +x yq
    fi

    ./yq -o=json eval '.apiVersion' $1

    ./yq -o=json eval '.kind' $1
    
}

# Get the flags
# If you add an option here, please
# remember to update usage() above.
while getopts :h:f: args
do
  case $args in
  h) usage; exit 0 ;;
  f) getapi "$OPTARG" ;;
  *) usage; exit 1 ;;
  esac
done

if [ -z "$1" ] 
then
    usage; exit 1;
fi


