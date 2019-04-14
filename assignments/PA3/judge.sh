#!/bin/bash

for filename in ../../examples/*.cl; do
    echo "--------Test using" $filename "--------"
    ./refparser $filename > refout 2> referr
    ./myparser $filename > myout 2> myerr
    cat myerr | sort > myerr_sorted
    cat referr | sort > referr_sorted
    if diff refout myout; then
        if diff referr_sorted myerr_sorted; then
            echo "Passed"
        fi
    fi
done

rm -rf refout myout myerr referr myerr_sorted referr_sorted
