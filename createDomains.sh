#! /bin/env bash
#
[[ -z "$someenv" ]] && someenv=someenv
domains=""
topleveldomains=""
accounts=""
for i in a b c d e f g h i j k l m n o p q r s t u v w x y z
do
 parentid=`cmk -p $someenv create domain name=$i | jq .domain.id`
 domains="$domains\t$parentid"
 topleveldomains="$topleveldomains\t$parentid"
 account=`cmk -p $someenv create account domainid=$parentid  email=jr@$i firstname=j lastname=r password=password username=jr-$i accounttype=0 | jq .account.id`
 accounts="$accounts\t$account"
 for j in  a b c d e f g h i j k l m n o p q r s t u v w x y z
 do
  subdomainid=`cmk -p $someenv create domain name=$i$j parentdomainid=$parentid | jq .domain.id`
  domains="$domains\t$subdomainid"
  account=`cmk -p $someenv create account domainid=$subdomainid  email=jr@$$j.$i firstname=j lastname=r password=password username=jr-$j-$i accounttype=0 | jq .account.id`
  accounts="$accounts\t$account"
  for k in 1st 2nd 3rd
  do
   childdomainid=`cmk -p $someenv create domain name=$k parentdomainid=$subdomainid | jq .domain.id`
   domains="$domains\t$childdomainid"
   account=`cmk -p $someenv create account domainid=$childdomainid  email=sr@$k.$j.$i firstname=s lastname=r password=password username=sr-$k-$j-$i accounttype=2 | jq .account.id`
   accounts="$accounts\t$account"
   account=`cmk -p $someenv create account domainid=$childdomainid  email=jr@$k.$j.$i firstname=j lastname=r password=password username=jr-$k-$j-$i accounttype=0 | jq .account.id`
   accounts="$accounts\t$account"
  done
 done
done

# echo "domains:\t$domains\naccounts:\t$accounts"
echo "top level domains:\t$topleveldomains"

