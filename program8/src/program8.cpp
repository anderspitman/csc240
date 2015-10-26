// Anders Pitman - Program 8 - Sieve of Eratosthenes

#include <iostream>
#include <math.h>
#include <assert.h>
#include "program8.h"

using namespace std;


void setMultiplesNonPrime(const int startNumber, int numbers[],
                          const int length) {
    assert(length > startNumber + 1);
    int *currentNumber = numbers + startNumber + 1;
    int *stop = numbers + length;
    int index = startNumber + 1;

    while (currentNumber < stop) {
        if (index % startNumber == 0) {
            *currentNumber = TYPE_NONPRIME;
        }
        ++index;
        ++currentNumber;
    }
}

void initializeNumbers(int *numbers, const int length) {
    assert(length >= 2);
    int *currentNumber = numbers;
    int *stop = numbers + length;
    *currentNumber = TYPE_NONPRIME;
    ++currentNumber;
    *currentNumber = TYPE_NONPRIME;
    ++currentNumber;
    while (currentNumber < stop) {
        *currentNumber = TYPE_DEFAULT;
        ++currentNumber;
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

void setAllRemainingPrime(int *numbers, const int length) {
    assert(length >= 2);

    int *currentNumber = numbers;
    int *stop = currentNumber + length;
    while (currentNumber < stop) {
        if (*currentNumber == TYPE_DEFAULT) {
            *currentNumber = TYPE_PRIME;
        }
        ++currentNumber;
    }
}

void setPrimes(int *numbers, const int upperBound) {
    assert(upperBound >= 1);

    int index = 2;
    int *currentNumber = numbers + index;
    const int SIZE = upperBound + 1;

    while(index < sqrt(upperBound)) {
        *currentNumber = TYPE_PRIME;
        setMultiplesNonPrime(index, numbers, SIZE);
        ++currentNumber;
        ++index;
    }

    setAllRemainingPrime(numbers, SIZE);
}

int *findPrimes(const int upperBound) {
    int *numbers = createNumbers(upperBound);
    setPrimes(numbers, upperBound);
    return numbers;
}
