#!/bin/bash

set -e

if [[ "$BTCPAYGEN_ADDITIONAL_FRAGMENTS" =~ "bitcoin-taproot-based" ]]; then
 
 read -p "The unofficial taproot node release is already active `echo $'\n> '`" yn
 if [ $yn != "yes" ]; then
 	exit 0
 fi

fi



read -p "This script will  THIS LND WILL BE LOST! Type 'yes' to proceed only after you've transfered all your funds from this LND instance `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

read -p "Only proceed if you've removed all the funds from LND Bitcoin container! This LND instance will be completely deleted and all data from it unrecoverable. Type 'yes' to proceed only if you are 100% sure `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

read -p "OK, last chance to abort. Type 'yes' to continue! `echo $'\n> '`" yn
if [ $yn != "yes" ]; then
	exit 0
fi

../btcpay-down.sh

docker volume rm --force generated_lnd_bitcoin_datadir

# very old installations had production_lnd_bitcoin_datadir volume
# https://github.com/btcpayserver/btcpayserver-docker/issues/272
docker volume rm --force production_lnd_bitcoin_datadir

../btcpay-up.sh

echo "LND container recreated"
