#!/bin/bash
set -e

echo "=== TEST STAGE ==="

BIN="./src/matrix_variant9"

if [ ! -x "$BIN" ]; then
echo "Ошибка: $BIN не найден"
exit 1
fi

normalize_output() {
tr '\t\r\n' ' ' | tr -s ' '
}

run_test() {
local name="$1"
local input="$2"
local expected="$3"

local output
output=$(printf "%b" "$input" | "$BIN" 2>&1 | normalize_output)

echo "Тест: $name"

if echo "$output" | grep -F -- "$expected" > /dev/null; then
echo "OK"
else
echo "FAILED: $name"
echo "Ожидалось найти: $expected"
echo "Фактический вывод: $output"
exit 1
fi
}

run_error_test() {
local name="$1"
local input="$2"

local output
output=$(printf "%b" "$input" | "$BIN" 2>&1 | normalize_output)

echo "Тест: $name"

if echo "$output" | grep -F "Ошибка" > /dev/null; then
echo "OK"
else
echo "FAILED: $name"
echo "Ожидалось сообщение об ошибке"
echo "Фактический вывод: $output"
exit 1
fi
}

run_test \
"3x3 без отрицательных элементов" \
"3\n1\n2\n3\n4\n5\n6\n7\n8\n9\n" \
"12 2 3 4 15 6 7 8 18"

run_test \
"Один столбец с отрицательным элементом" \
"3\n1\n-2\n3\n4\n5\n6\n7\n8\n9\n" \
"12 -2 3 4 5 6 7 8 18"

run_test \
"2x2 все столбцы с отрицательными" \
"2\n-1\n2\n3\n-4\n" \
"-1 2 3 -4"

echo "Все тесты успешно пройдены"
