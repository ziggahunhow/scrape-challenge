#!/bin/bash
# requirements: jq

cookie="Cookie"
URL=https://f2e-test.herokuapp.com/api/auth
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )
cd "$parent_path"
csrf=$(<../csrf.txt)
curl --data "username=f2e-candidate&password=P@ssw0rd&csrf=$csrf" $URL -H 'Connection: keep-alive' -H 'Origin: https://f2e-test.herokuapp.com' -H 'Content-Type: application/x-www-form-urlencoded' -H 'Host: f2e-test.herokuapp.com' -H 'Referer: https://f2e-test.herokuapp.com/login' -i -s | sed 's/Set-//g' | grep session | tr -d '\r' > key.txt
curl -v -s -H "$(cat headers.txt)" -H "$(cat key.txt)" 'https://f2e-test.herokuapp.com/api/products?offset=0&limit=1000' -s | jq '.data' > result.json 2>&1
