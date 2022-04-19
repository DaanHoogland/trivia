#! /bin/bash

[ -z "$1" ] && exit
file=$1
echo running test file $file
TAG=advanced
[ -z "$2" ] || TAG=$2
echo running tests for tag $TAG

export MARVINCFG=`ls /marvin/ref-trl-*-cfg /marvin/pr[0-9]*-t[0-9]*-*-cfg`
echo using cfg $MARVINCFG \(there should be only one\)
export LOGDIR=/marvin/MarvinLogs
echo using logs in  $LOGDIR
export NOSETESTS=`type -p nosetests`
echo using nose $NOSETESTS
echo executing ${NOSETESTS} --with-xunit --xunit-file=$LOGDIR/$(basename $file).xml --with-marvin --marvin-config=$MARVINCFG --hypervisor=kvm -s -a tags=advanced $file
${NOSETESTS} --with-xunit --xunit-file=$LOGDIR/$(basename $file).xml --with-marvin --marvin-config=$MARVINCFG --hypervisor=kvm -s -a tags=$TAG $file
