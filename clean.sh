#!/bin/bash

declare -a dirs=(build output)

for dir in ${dirs[*]}; do
    echo "Remove directory: $dir"
    rm -rf $dir
done

exit 0
