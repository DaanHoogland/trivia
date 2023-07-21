#! /bin/env bash
#

someenv=local
if [ -z "$topleveldomains" ]
then
  topleveldomains=`cmk -p $someenv list domains | jq '.domain[] | select(.name=="ROOT" | not) | .id'`
fi

for domain in $topleveldomains ; do cmk -p someenv delete domain id=$domain; done
