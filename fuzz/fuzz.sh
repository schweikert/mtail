#!/bin/sh

set -x

d=$(dirname $0)
EMTAIL=$d/../mtail
EMGEN=$d/../emgen/emgen
OUT=$d/../fuzzout

run() {
    rm -rf $OUT/*
    $EMGEN --rand_seed $1 > $OUT/fuzz$1.mtail
    $EMTAIL --compile_only --dump_bytecode --logs foo.log --progs $OUT
    echo $?
}

if [[ -n "$1" ]]; then
	run $1
else
for i in $(seq 0 99); do
	run $i
done
fi
