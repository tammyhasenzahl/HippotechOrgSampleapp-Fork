#!/bin/bash
file_count=$(find $1 -name $2 | wc -l)

if [[ $file_count -gt 0 ]]; then
    echo "Warning: $1 found $file_count times in $2!"
fi