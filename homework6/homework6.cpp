#include <iostream>
#include <string.h>

using namespace std;


class NBAPlayer {
    public:
        NBAPlayer(const char *name, const char *team);
        ~NBAPlayer();
        char *getName();
        char *getTeam();
        int getGamesPlayedTotal();
        int getAssistsTotal();
        double computeAverageAssistsPerGame();
        void addAssistsForGame(int assists);
        void setTeam(const char *newTeam);
        void displaySummary();

    private:
        char *_name;
        char *_team;
        int _gamesPlayedTotal;
        int _assistsTotal;
};


class NBAPlayerTester {
    public:
        void test() {
            NBAPlayer player1("Goran Dragic", "Phoenix Suns");
            player1.displaySummary();
            player1.addAssistsForGame(12);
            player1.addAssistsForGame(11);
            cout << "Average Assists for "
                 << player1.getName() << ": "
                 << player1.computeAverageAssistsPerGame() << endl;
            cout << "Team for "
                 << player1.getName() << ": "
                 << player1.getTeam() << endl;
            player1.setTeam("LA Lakers");

            NBAPlayer *player2 = new NBAPlayer("Eric Bledsoe",
                                               "Phoenix Suns");
            player2->addAssistsForGame(8);
            player2->addAssistsForGame(5);
            cout << "Average Assists for "
                 << player2->getName() << ": "
                 << player2->computeAverageAssistsPerGame() << endl;
            player2->displaySummary();
            delete player2;
        }
};


int main(int argc, char **argv) {
    NBAPlayerTester tester;
    tester.test();
}


NBAPlayer::NBAPlayer(const char *name, const char *team) {
    const int nameLength = strlen(name);
    _name = new char[nameLength];
    strcpy(_name, name);

    const int teamLength = strlen(team);
    _team = new char[teamLength];
    strcpy(_team, team);

    _gamesPlayedTotal = 0;
    _assistsTotal = 0;
}

NBAPlayer::~NBAPlayer() {
    delete[] _name;
    delete[] _team;
}

char *NBAPlayer::getName() {
    const int nameLength = strlen(_name);
    char *name = new char[nameLength];
    strcpy(name, _name);
    return name;
}

char *NBAPlayer::getTeam() {
    const int teamLength = strlen(_team);
    char *team = new char[teamLength];
    strcpy(team, _team);
    return team;
}

int NBAPlayer::getGamesPlayedTotal() {
    return _gamesPlayedTotal;
}

int NBAPlayer:: getAssistsTotal() {
    return _assistsTotal;
}

double NBAPlayer::computeAverageAssistsPerGame() {
    if (getGamesPlayedTotal() > 0) {
        return (double)getAssistsTotal() / (double)getGamesPlayedTotal();
    }
    else {
        return 0;
    }
}

void NBAPlayer::addAssistsForGame(int assists) {
    _assistsTotal += assists;
    ++_gamesPlayedTotal;
}

void NBAPlayer::setTeam(const char *newTeam) {
    const int teamLength = strlen(newTeam);
    delete[] _team;
    _team = new char[teamLength];
    strcpy(_team, newTeam);
}

void NBAPlayer::displaySummary() {
    cout << "Name: " << getName() << endl;
    cout << "Team: " << getTeam() << endl;
    cout << "Number of Games Played: " << getGamesPlayedTotal() << endl;
    cout << "Number of Assists: " << getAssistsTotal() << endl;
}
