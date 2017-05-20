#!/bin/sh -eu

check_eq() {
    actual=$(echo "$1" | ./main.native)
    expect=$(echo -e "\t$2")
    if [ "$actual" != "$expect" ]; then
        echo "<CHECK FAILED>"
        echo actual: "$actual"
        echo expect: "$expect"
        exit 1
    fi
    echo "OK: $1 => $2"
}

echo "CASE: HOC1"
check_eq "4*3*2" 24
check_eq "(1+2) * (3+4)" 21
check_eq "1/2" 0.5
check_eq "2 / 3" 0.666667
check_eq "-3-4" -7
check_eq "355/113" 3.14159

echo ALL CHECK HAS PASSED
