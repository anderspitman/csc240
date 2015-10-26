#include "program8.h"
#include <iostream>

using namespace std;


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
