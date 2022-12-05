#!/usr/bin/env bash

filename=$CLINIC_SLUG.$(date +%Y%m%d-%H%M%S)
fullFilename="hdc-${filename}.sql"
folder=$(date +%Y%m)

kubectl exec -n $CLINIC_SLUG db-0 -c mariadb -- bash -c "mysqldump -uroot -p${MYSQL_ROOT_PASSWORD} oscar \
    allergies \
    appointment \
    appointmentType \
    billing \
    billing_history \
    billingmaster \
    billingservice \
    billingstatus_types \
    casemgmt_note \
    clinic \
    demographic \
    demographicArchive \
    demographicExt \
    demographicExtArchive \
    diagnosticcode \
    drugReason \
    drugs \
    dxresearch \
    LookupListItem \
    measurements \
    measurementsExt \
    measurementType \
    prescription \
    preventions \
    preventionsExt \
    provider > ${fullFilename}"

kubectl cp -n $CLINIC_SLUG db-0:/code/$fullFilename /home/hdc/$fullFilename

echo "Importing gpg key"
gpg --import hdcprod.pgp

# encrypt
# always trust the key, it's verified manually.
gpg --output $fullFilename.gpg --encrypt --trust-model always --recipient pki-prod@hdcbc.ca $fullFilename

aws s3 cp $fullFilename.gpg s3://openosp-hdc-transit/openosp-$CLINIC_SLUG/$folder/$fullFilename.gpg
