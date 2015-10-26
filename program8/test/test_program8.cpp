#include "catch.hpp"

#include "program8.h"


TEST_CASE( "Set nonprime numbers", "[set nonprime]" ) {
    const int SIZE = 8;
    int numbers[SIZE] = {TYPE_NONPRIME, TYPE_NONPRIME, TYPE_DEFAULT, TYPE_DEFAULT,
                     TYPE_DEFAULT, TYPE_DEFAULT, TYPE_DEFAULT, TYPE_DEFAULT};
    setMultiplesNonPrime(2, numbers, SIZE);
    REQUIRE( numbers[0] == TYPE_NONPRIME );
    REQUIRE( numbers[1] == TYPE_NONPRIME );
    REQUIRE( numbers[2] == TYPE_DEFAULT );
    REQUIRE( numbers[3] == TYPE_DEFAULT );
    REQUIRE( numbers[4] == TYPE_NONPRIME );
    REQUIRE( numbers[5] == TYPE_DEFAULT );
    REQUIRE( numbers[6] == TYPE_NONPRIME );
    REQUIRE( numbers[7] == TYPE_DEFAULT );
}

TEST_CASE( "Initialize numbers" ) {
    const int SIZE = 5;
    int numbers[SIZE] = {-1, -1, -1, -1, -1};
    initializeNumbers(numbers, SIZE);
    REQUIRE( numbers[0] == TYPE_NONPRIME );
    REQUIRE( numbers[1] == TYPE_NONPRIME );
    REQUIRE( numbers[2] == TYPE_DEFAULT );
    REQUIRE( numbers[3] == TYPE_DEFAULT );
    REQUIRE( numbers[4] == TYPE_DEFAULT );
}

TEST_CASE( "Create numbers" ) {
    const int UPPER_BOUND = 5;
    int *numbers = createNumbers(UPPER_BOUND);
    REQUIRE( numbers[0] == TYPE_NONPRIME );
    REQUIRE( numbers[1] == TYPE_NONPRIME );
    REQUIRE( numbers[2] == TYPE_DEFAULT );
    REQUIRE( numbers[3] == TYPE_DEFAULT );
    REQUIRE( numbers[4] == TYPE_DEFAULT );
    REQUIRE( numbers[5] == TYPE_DEFAULT );
}

TEST_CASE( "Destroy numbers" ) {
    // point at arbitrary memory
    int *numbers = (int *) 5;

    numbers = createNumbers(10);
    destroyNumbers(&numbers);
    REQUIRE( numbers == 0 );
}

TEST_CASE( "Set all remaining prime" ) {
    const int UPPER_BOUND = 7;
    const int SIZE = UPPER_BOUND + 1;
    int numbers[SIZE] = {TYPE_NONPRIME, TYPE_NONPRIME, TYPE_PRIME,
                         TYPE_PRIME, TYPE_NONPRIME, TYPE_DEFAULT,
                         TYPE_NONPRIME, TYPE_DEFAULT};
    setAllRemainingPrime(numbers, SIZE);
    REQUIRE( numbers[0] == TYPE_NONPRIME );
    REQUIRE( numbers[1] == TYPE_NONPRIME );
    REQUIRE( numbers[2] == TYPE_PRIME );
    REQUIRE( numbers[3] == TYPE_PRIME );
    REQUIRE( numbers[4] == TYPE_NONPRIME );
    REQUIRE( numbers[5] == TYPE_PRIME );
    REQUIRE( numbers[6] == TYPE_NONPRIME );
    REQUIRE( numbers[7] == TYPE_PRIME );
}

TEST_CASE( "Set primes" ) {
    const int UPPER_BOUND = 14;
    int *numbers = createNumbers(UPPER_BOUND);
    setPrimes(numbers, UPPER_BOUND);
    REQUIRE( numbers[0] == TYPE_NONPRIME );
    REQUIRE( numbers[1] == TYPE_NONPRIME );
    REQUIRE( numbers[2] == TYPE_PRIME);
    REQUIRE( numbers[3] == TYPE_PRIME );
    REQUIRE( numbers[4] == TYPE_NONPRIME );
    REQUIRE( numbers[5] == TYPE_PRIME );
    REQUIRE( numbers[6] == TYPE_NONPRIME );
    REQUIRE( numbers[7] == TYPE_PRIME );
    REQUIRE( numbers[8] == TYPE_NONPRIME );
    REQUIRE( numbers[9] == TYPE_NONPRIME );
    REQUIRE( numbers[10] == TYPE_NONPRIME );
    REQUIRE( numbers[11] == TYPE_PRIME );
    REQUIRE( numbers[12] == TYPE_NONPRIME );
    REQUIRE( numbers[13] == TYPE_PRIME );
    REQUIRE( numbers[14] == TYPE_NONPRIME );
}

TEST_CASE( "Compute primes" ) {
    const int UPPER_BOUND = 7;
    int *numbers = findPrimes(UPPER_BOUND);
    REQUIRE( numbers[0] == TYPE_NONPRIME );
    REQUIRE( numbers[1] == TYPE_NONPRIME );
    REQUIRE( numbers[2] == TYPE_PRIME);
    REQUIRE( numbers[3] == TYPE_PRIME );
    REQUIRE( numbers[4] == TYPE_NONPRIME );
    REQUIRE( numbers[5] == TYPE_PRIME );
    REQUIRE( numbers[6] == TYPE_NONPRIME );
    REQUIRE( numbers[7] == TYPE_PRIME );
}
