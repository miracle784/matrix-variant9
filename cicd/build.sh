#!/bin/bash
set -e

echo "=== BUILD STAGE ==="

cd src
make clean || true
make

if [ ! -f "matrix_variant9" ]; then
    echo "Ошибка: бинарный файл matrix_variant9 не найден"
    exit 1
fi

echo "Сборка завершена успешно"
