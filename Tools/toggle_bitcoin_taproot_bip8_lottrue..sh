#!/bin/bash
if [[ "$0" = "$BASH_SOURCE" ]]; then
    echo "This script must be sourced \". toggle_bitcoin_taproot_bip8_lottrue.sh\"" 
    exit 1
fi

set -e

if [[ "$BTCPAYGEN_ADDITIONAL_FRAGMENTS" =~ "bitcoin-taproot-bip8" ]]; then
 read -p "The unofficial taproot node release is already active. Type 'official' to change back to the official release `echo $'\n> '`" yn
 if [ $yn != "official" ]; then
 	exit 0
 fi
 export BTCPAYGEN_ADDITIONAL_FRAGMENTS="${BTCPAYGEN_ADDITIONAL_FRAGMENTS//bitcoin-taproot-bip8/}"
 export BTCPAYGEN_EXCLUDE_FRAGMENTS="${BTCPAYGEN_EXCLUDE_FRAGMENTS//bitcoin/}"
  
  . btcpay-setup.sh -i
  cd Tools
  echo "Configured to use official Bitcoin release."
  exit 0  
fi



read -p "This script will swap the official Bitcoin release with an unofficial version provided from https://bitcointaproot.cc that includes taproot activation signalling via BIP8 wiht LOT=TRUE. Type 'unofficial' to switch to this UNOFFICIAL FORK OF BITCOIN CORE. `echo $'\n> '`" yn
if [ $yn != "unofficial" ]; then
	exit 0
fi
read -p "OK, Are you sure you know what you are doing? Please be aware that you running a Bitcoin node that is not from the official release group and cycle. There can be a potential chain split in special circumstances. ONLY RUN THIS IF YOU ARE KNOWLEDGEABLE. BTCPAYSERVER DOES NOT PROVIDE AN OPINION ON THIS DECISION AND THIS OPTION DOES NOT MEAN WE ARE PROMOTING THIS FORK OF BITCOIN CORE BY LUKEDASHJR.  Type 'yes' to continue! `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

export BTCPAYGEN_ADDITIONAL_FRAGMENTS="$BTCPAYGEN_ADDITIONAL_FRAGMENTS;bitcoin-taproot-bip8"
export BTCPAYGEN_EXCLUDE_FRAGMENTS="$BTCPAYGEN_EXCLUDE_FRAGMENTS;bitcoin"

. btcpay-setup.sh -i
cd Tools
echo "Configured to use the unofficial Bitcoin release with taproot activation."