// Anders Pitman - Program 8 - Sieve of Eratosthenes

#include <iostream>
#include <math.h>
#include <assert.h>
#include "program8.h"

using namespace std;


void setMultiplesNonPrime(const int startNumber, int numbers[],
                          const int length) {
    assert(length > startNumber + 1);
    for (int i=startNumber + 1; i<length; ++i) {
        if (i % startNumber == 0) {
            numbers[i] = TYPE_NONPRIME;
        }
    }
}

void initializeNumbers(int numbers[], const int length) {
    assert(length >= 2);
    numbers[0] = TYPE_NONPRIME;
    numbers[1] = TYPE_NONPRIME;
    for (int i=2; i<length; ++i) {
        numbers[i] = TYPE_DEFAULT;
    }
}

int *createNumbers(const int upperBound) {
    const int SIZE_INCLUDING_ZERO = upperBound + 1;
    int *numbers = new int[SIZE_INCLUDING_ZERO];
    initializeNumbers(numbers, SIZE_INCLUDING_ZERO);
    return numbers;
}

void destroyNumbers(int **numbers) {
    delete[] *numbers;
    *numbers = 0;
}

void setAllRemainingPrime(int numbers[], const int length) {
    assert(length >= 2);

    for (int i=2; i<length; ++i) {
        if (numbers[i] == TYPE_DEFAULT) {
            numbers[i] = TYPE_PRIME;
        }
    }
}

void setPrimes(int numbers[], const int upperBound) {
    assert(upperBound >= 1);

    int currentNumber = 2;
    const int SIZE = upperBound + 1;

    while(currentNumber < sqrt(upperBound)) {
        numbers[currentNumber] = TYPE_PRIME;
        setMultiplesNonPrime(currentNumber, numbers, SIZE);
        ++currentNumber;
    }

    setAllRemainingPrime(numbers, SIZE);
}

int *findPrimes(const int upperBound) {
    int *numbers = createNumbers(upperBound);
    setPrimes(numbers, upperBound);
    return numbers;
}
