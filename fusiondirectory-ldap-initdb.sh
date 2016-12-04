#!/bin/bash
/usr/sbin/fusiondirectory-insert-schema -e /etc/ldap/schema/nis.schema -y
SCHEMAS_TO_LOAD=$(ls /etc/ldap/schema/fusiondirectory/*.schema)
while [ -n "$SCHEMAS_TO_LOAD" ]; do
    SCHEMAS_TO_TRY=$SCHEMAS_TO_LOAD
    SCHEMAS_TO_LOAD=""
    for SCHEMA in $SCHEMAS_TO_TRY; do
        /usr/sbin/fusiondirectory-insert-schema -i $SCHEMA || SCHEMAS_TO_LOAD="$SCHEMAS_TO_LOAD $SCHEMA"
    done
done
