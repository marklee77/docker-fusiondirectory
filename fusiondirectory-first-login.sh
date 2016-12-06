#!/bin/bash
while ! [ -f /etc/fusiondirectory/fusiondirectory.passwd ]; do sleep 1; done
fusiondirectory_admin_password=$(cat < /etc/fusiondirectory/fusiondirectory.passwd)
for X in {1..10}; do
  while ! CURLOUT=$(curl -s -X POST -F 'username=fd-admin' -F "password=$fusiondirectory_admin_password" -F 'login=Sign in' http://localhost/fusiondirectory/) || [ -n "$CURLOUT" ]; do sleep 1; done
  sleep 1
done
sv stop fusiondirectory_first_login
