#!/bin/bash

if [ -d build ]; then
    rm -rf build
fi
mkdir build

cd build
cmake ..
make -j4

exit 0
