// Anders Pitman - Program 8 - Sieve of Eratosthenes
#include <iostream>
#include <math.h>
// Asserts to prevent bugs while testing. NDEBUG disables them for production.
#include <assert.h>
#define NDEBUG

using namespace std;


const int TYPE_DEFAULT = 0;
const int TYPE_PRIME = 1;
const int TYPE_NONPRIME = 2;


void setMultiplesNonPrime(const int startNumber, int numbers[],
                          const int length);
void initializeNumbers(int numbers[], const int length);
int *createNumbers(const int upperBound);
void destroyNumbers(int **numbers);
void setAllRemainingPrime(int numbers[], const int upperBound);
void setPrimes(int numbers[], const int length);
int *findPrimes(const int upperBound);

// UI stuff
void printPrimesInRange(const int lowerBound, const int upperBound);
int getPositiveIntegerFromUser(string promptMessage);
int getLowerBoundFromUser(int upperBound, string promptMessage);
int isYes(char choice);


int main(int argc, char **argv) {
    cout << endl << "The Sieve of Eratosthenes" << endl << endl;

    int upperBound = -1;
    int lowerBound = -1;
    char again = 'N';

    do {
        do {
            upperBound = getPositiveIntegerFromUser("Enter the upper bound");
            lowerBound = getPositiveIntegerFromUser("Enter the lower bound");
        } while (lowerBound > upperBound);

        printPrimesInRange(lowerBound, upperBound);

        cout << "Run again? (y/N)" << endl;
        cin >> again;
        cout << endl;

    } while (isYes(again));

    return 0;
}

void printPrimesInRange(const int lowerBound, const int upperBound) {
    cout << "Primes in range:" << endl;
    int *numbers = findPrimes(upperBound);
    for (int i=lowerBound; i<=upperBound; ++i) {
        if (numbers[i] == TYPE_PRIME) {
            cout << i << endl;
        }
    }
    cout << endl;
}

int getPositiveIntegerFromUser(string promptMessage) {
    cout << promptMessage << endl;
    int input = -1;
    cin >> input;

    while (input < 0) {
        cout << "Value must be positive" << endl;
        cin >> input;
    }
    cout << endl;
    return input;
}

int getLowerBoundFromUser(int upperBound, string promptMessage) {
    int input = getPositiveIntegerFromUser(promptMessage);

    while (input > upperBound) {
        cout << "Lower bound must be less than or equal to upper bound"
             << endl << endl;;
    }

    return input;
}

int isYes(char choice) {
    return choice == 'y' || choice == 'Y';
}

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
