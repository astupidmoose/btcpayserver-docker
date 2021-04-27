#!/bin/bash
source ~/.bashrc
set -e

if [[ "$BTCPAYGEN_ADDITIONAL_FRAGMENTS" =~ "bitcoin-taproot-based" ]]; then
 read -p "The unofficial taproot node release is already active. Type 'official' to change back to the official release `echo $'\n> '`" yn
 if [ $yn != "official" ]; then
 	exit 0
 fi
 export BTCPAYGEN_ADDITIONAL_FRAGMENTS="${BTCPAYGEN_ADDITIONAL_FRAGMENTS//bitcoin-taproot-based/}"
 export BTCPAYGEN_EXCLUDE_FRAGMENTS="${BTCPAYGEN_EXCLUDE_FRAGMENTS//bitcoin/}"
  
 . btcpay-setup.sh -i
 
 echo "Configured to use official Bitcoin release."
 exit 0
fi



read -p "This script will swap the official Bitcoin release with an unofficial version provided from https://bitcointaproot.cc that includes taproot activation signalling. Type 'unofficial' to switch to this UNOFFICIAL FORK OF BITCOIN CORE. `echo $'\n> '`" yn
if [ $yn != "unofficial" ]; then
	exit 0
fi

read -p "OK, last chance to abort. Type 'yes' to continue! `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

export BTCPAYGEN_ADDITIONAL_FRAGMENTS="$BTCPAYGEN_ADDITIONAL_FRAGMENTS;bitcoin-taproot-based"
export BTCPAYGEN_EXCLUDE_FRAGMENTS="$BTCPAYGEN_EXCLUDE_FRAGMENTS;bitcoin"

. btcpay-setup.sh -i

echo "Configured to use the unofficial Bitcoin release with taproot activation."
exit 0