#!/bin/bash

type -p "pigz" && GZIP=pigz || GZIP=gzip
TMPDIR=/tmp/hf-prof
SLEEP_TIME=135

set -x
rm -rf $TMPDIR
mkdir $TMPDIR

CHROME_PID=$(pgrep -n 'chrome')

if [[ -z $CHROME_PID ]] ; then
    echo "Error getting chrome PID"
    exit 1
fi

perf record -ag -e instructions -t $CHROME_PID -o /tmp/perf.data -- sleep ${SLEEP_TIME:-200}


nm -S ${HHVM_BIN_PATH:-/proc/$CHROME_PID/exe} > $TMPDIR/chrome.nm

pushd $TMPDIR/..

TARFILE=${TMPDIR}.tgz

tar cvzf $TARFILE `basename $TMPDIR`

popd

echo "Generated file $TARFILE"
