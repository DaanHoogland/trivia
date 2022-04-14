
cmk list domains filter=id,name | jq ' .domain | .[] | select( .name | contains("d")) | .id' 

for domain in ` cmk list domains filter=id,name | jq ' .domain | .[] | select( .name | contains("d")) | .id' ` 
do
  cmk delete domain id=$domain cleanup=true
done

for template in ` cmk list templates filter=id,name templatefilter=all | jq ' .template | .[] | select( .name | contains("test")) | .id' `
do
  cmk delete template id=$template force=true;
done

ZONEID=`cmk list zones filter=name,id | jq ' .zone | .[0].id '`
TEMPLATEID=`cmk list templates templatefilter=all filter=name,id  | jq ' .template | .[] | select( .name | contains("mini"))| .id '`
SERVICEOFFERINGID=`cmk list serviceofferings filter=name,id  | jq ' .serviceoffering | .[] | select( .name | contains("Small"))| .id '`
VIRTUALMACHINEID=`cmk deployvirtualmachine startvm=false zoneid=$ZONEID templateid=$TEMPLATEID serviceofferingid=$SERVICEOFFERINGID | jq ' .virtualmachine.id'`

# alternatively after creation:

VIRTUALMACHINEID=`cmk list virtualmachines filter=name,id | jq ' .virtualmachine | .[] | select( .name | contains("bla")) | .id'`

for volumeid in `cmk list volumes filter=name,id | jq ' .volume | .[] | select( .name | contains("d")) | .id'`
 do
  cmk attach volume id=$volumeid virtualmachineid=$VIRTUALMACHINEID
 done
