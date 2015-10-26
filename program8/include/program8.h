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
