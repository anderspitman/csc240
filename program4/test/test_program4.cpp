#include "catch.hpp"
#include "program4.hpp"

TEST_CASE( "Dummy test", "[tags?]" ) {
    REQUIRE( dummyFunc() == true );
}
