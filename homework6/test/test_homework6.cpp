#include "catch.hpp"

#include "homework6.h"


TEST_CASE( "Class exists" ) {
    const char *name = (char *)"Anders Pitman";
    const char *team = (char *)"Phoenix Suns";
    NBAPlayer player(name, team);
    REQUIRE( player.getName() != name);
    REQUIRE( player.getTeam() != team);
}
