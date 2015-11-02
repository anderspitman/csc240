// Anders Pitman - Homework 6 - Bball class

#include <iostream>
#include <math.h>
#include <assert.h>
#include <string.h>
#include "homework6.h"

using namespace std;

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
