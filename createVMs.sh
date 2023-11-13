#! /bin/env bash
#
[[ -z "$startNum" ]] && startNum=100
[[ -z "$endNum" ]] && endNum=200
[[ -z "$someenv" ]] && someenv=someenv
[[ -z "$startvm" ]] && startvm=false
[[ -z "$serviceoffering" ]] && serviceoffering="Small Instance"
templateid=`cmk -p $someenv list templates templatefilter=all name=mini | jq '.template[] | .id'`
serviceofferingid=`cmk -p $someenv list serviceofferings name="$serviceoffering" | jq '.serviceoffering[0].id'`
zoneid=`cmk -p $someenv list zones | jq '.zone[0].id'`
for (( i=$startNum; i<=$endNum; i++ ))
do
 echo "$i cmk -p $someenv deploy virtualmachine zoneid=$zoneid templateid=$templateid serviceofferingid=$serviceofferingid name=VM-$i startvm=$startvm & "
 cmk -p $someenv deploy virtualmachine zoneid=$zoneid templateid=$templateid serviceofferingid=$serviceofferingid name=VM-$i startvm=$startvm &
done

