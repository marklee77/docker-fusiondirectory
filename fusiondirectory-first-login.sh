#!/bin/bash
for X in {1..30}; do
  while ! CURLOUT=$(curl -s -X POST -F 'username=fd-admin' -F 'password=fusion' -F 'login=Sign in' http://localhost/fusiondirectory/) || [ -n "$CURLOUT" ]; do sleep 1; done
  sleep 1
done
sv stop fusiondirectory_first_login
