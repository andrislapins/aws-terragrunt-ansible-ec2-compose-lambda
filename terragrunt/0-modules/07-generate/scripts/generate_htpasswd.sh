#!/bin/bash

set -ex

USERNAME=$1
PASSWORD=$2

if [[ -z "$USERNAME" || -z "$PASSWORD" ]]; then
  exit 1
fi

OUTPUT=$(echo -n "$PASSWORD" | htpasswd -ni "$USERNAME")
echo "{\"output\": \"$OUTPUT\"}"