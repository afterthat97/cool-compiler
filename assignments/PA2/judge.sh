#!/bin/bash

for filename in ../../examples/*.cl; do
    echo "--------Test using" $filename "--------"
    ../../bin/.i686/lexer $filename > refout
    ./lexer $filename > myout
    if diff refout myout; then
        echo "Passed"
    fi
done

rm -rf refout myout
