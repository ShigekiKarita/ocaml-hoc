#!/bin/bash -eu

check_eq() {
    actual=$(echo -e "$1" | ./main.native)
    expect=$(echo -e "\t$2")
    if [ "$actual" != "$expect" ]; then
        echo "NG: <CHECK FAILED>"
        echo actual: "$actual"
        echo expect: "$expect"
        exit 1
    fi
    echo -e "OK: $1 => $2"
}

echo "==== CASE: HOC1 ===="
./main.native < /dev/null || exit 1;

check_eq "4*3*2" 24
check_eq "(1+2) * (3+4)" 21
check_eq "1/2" 0.5
check_eq "2 / 3" 0.66666667
check_eq "-3-4" -7
check_eq "355/113" 3.1415929

echo "==== CASE HOC2 ===="
check_eq "a" 0
check_eq "a=3" 3
check_eq "a=3\n b=2\n a*b" "3\n\t2\n\t6"
check_eq "a=b=1\na+b" "1\n\t2"

echo "==== CASE HOC2 with semicolon extension ===="
check_eq "a=b=1;a+b" "2"
check_eq "a=3;b=a+2;a*b" "15"
check_eq "a=3 ; b = -a; -a-b" "0"

echo "==== CASE option -c extention ===="
check_eq "1 + 2" $(./main.native -c "1 + 2")
check_eq "a = 1; a * 2" $(./main.native -c "a = 1; a * 2")

echo ALL CHECK HAS PASSED
