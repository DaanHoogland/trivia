
cmk list domains filter=id,name | jq ' .domain | .[] | select( .name | contains("d")) | .id' 

for domain in ` cmk list domains filter=id,name | jq ' .domain | .[] | select( .name | contains("d")) | .id' ` 
do
  cmk delete domain id=$domain cleanup=true
done

for template in ` cmk list templates filter=id,name templatefilter=all | jq ' .template | .[] | select( .name | contains("test")) | .id' `
do
  cmk delete template id=$template force=true;
done
