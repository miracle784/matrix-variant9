#include <iostream>
#include <vector>
#include <limits>
#include <string>

using namespace std;

const int MIN_SIZE = 1;
const int MAX_SIZE = 10;

void clearInput() {
    cin.clear();
    cin.ignore(numeric_limits<streamsize>::max(), '\n');
}

int readInt(const string& prompt) {
    int value;

    while (true) {
        cout << prompt;
        cin >> value;

        if (cin.fail()) {
            cout << "Ошибка: нужно ввести целое число.\n";
            clearInput();
            continue;
        }

        if (cin.peek() != '\n' && cin.peek() != ' ') {
            cout << "Ошибка: введены некорректные данные.\n";
            clearInput();
            continue;
        }

        clearInput();
        return value;
    }
}

int readMatrixSize() {
    int n;

    while (true) {
        n = readInt("Введите размер квадратной матрицы N (от 1 до 10): ");

        if (n < MIN_SIZE || n > MAX_SIZE) {
            cout << "Ошибка: N должно быть в диапазоне от "
                 << MIN_SIZE << " до " << MAX_SIZE << ".\n";
            continue;
        }

        return n;
    }
}

void readMatrix(vector<vector<int>>& matrix, int n) {
    cout << "Введите элементы матрицы " << n << "x" << n << ":\n";

    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            matrix[i][j] = readInt(
                "Элемент [" + to_string(i) + "][" + to_string(j) + "]: "
            );
        }
    }
}

void printMatrix(const vector<vector<int>>& matrix, int n) {
    for (int i = 0; i < n; ++i) {
        for (int j = 0; j < n; ++j) {
            cout << matrix[i][j] << "\t";
        }
        cout << '\n';
    }
}

void processMatrix(vector<vector<int>>& matrix, int n) {
    for (int j = 0; j < n; ++j) {
        bool hasNegative = false;
        int sum = 0;

        for (int i = 0; i < n; ++i) {
            if (matrix[i][j] < 0) {
                hasNegative = true;
            }
            sum += matrix[i][j];
        }

        if (!hasNegative) {
            matrix[j][j] = sum;
        }
    }
}

int main() {
    cout << "Программа обработки квадратной матрицы.\n";
    cout << "Вариант 9: найти сумму элементов в столбцах, не содержащих\n";
    cout << "отрицательных элементов, и заменить этой суммой элемент\n";
    cout << "на главной диагонали в соответствующем столбце.\n\n";

    int n = readMatrixSize();
    vector<vector<int>> matrix(n, vector<int>(n));

    readMatrix(matrix, n);

    cout << "\nИсходная матрица:\n";
    printMatrix(matrix, n);

    processMatrix(matrix, n);

    cout << "\nРезультирующая матрица:\n";
    printMatrix(matrix, n);

    return 0;
}

