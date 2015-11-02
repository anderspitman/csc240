
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
