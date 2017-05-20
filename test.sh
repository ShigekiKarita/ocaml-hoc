#!/bin/sh -eu

check_eq() {
    result=$(./main.native "$1")
    if [ "$result" != "$2" ]; then
        echo "<CHECK FAILED>"
        echo actual: $result
        echo expect: $2
        exit 1
    fi
    echo "OK: $1 => $result"
}

check_eq "1 + 1" 2
check_eq "2 * 3" 6


echo ALL CHECK HAS PASSED
