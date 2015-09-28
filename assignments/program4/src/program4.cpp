#include <iostream>

using namespace std;

const int DEGREES_MIN = 0;
const int DEGREES_MAX = 180;
const int MINUTES_MIN = 0;
const int MINUTES_MAX = 60;
const int SECONDS_MIN = 0;
const int SECONDS_MAX = 60;

void handleLocationToDegrees();
int getIntegerInRangeFromUser(int lowerBound, int upperBound,
                              string promptMessage);
char getHemisphereFromUser();
double computeLocationToDegrees(int degrees, int minutes, int seconds,
                                char hemisphere);

int main(int argc, char **argv) {
    cout << "Enter an integer to choose an option:" << endl;
    cout << "(1) Convert from degrees-minutes-seconds-hemisphere to degrees" << endl;
    cout << "(2) " << endl;
    cout << "(3) " << endl;
    cout << "(4) " << endl;
    cout << "(5) " << endl;
    int option = 0;
    cin >> option;

    switch (option) {
        case 1:
            handleLocationToDegrees();
            break;
        default:
            cerr << "Invalid input: " << option << endl;
            break;
    };

    return 0;
}

void handleLocationToDegrees() {
    int degrees = getIntegerInRangeFromUser(DEGREES_MIN, DEGREES_MAX,
                                            "Enter the degrees:");
    int minutes = getIntegerInRangeFromUser(MINUTES_MIN, MINUTES_MAX,
                                            "Enter the minutes:");
    int seconds = getIntegerInRangeFromUser(SECONDS_MIN, SECONDS_MAX,
                                            "Enter the seconds:");
    char hemisphere = getHemisphereFromUser();

    double degreesTotal = computeLocationToDegrees(degrees, minutes, seconds,
                                                   hemisphere);

    cout << "Answer in degrees: " << degreesTotal << endl;
}

int getIntegerInRangeFromUser(int lowerBound, int upperBound,
                              string promptMessage) {
    cout << promptMessage << endl;
    int input = 0;
    cin >> input;

    while (input < lowerBound || input > upperBound) {
        cout << "Value must be between " << lowerBound << " and "
             << upperBound << ". Try again:" << endl;
        cin >> input;
    }
    return input;
}

char getHemisphereFromUser() {
    cout << "Enter the hemisphere:" << endl;
    cout << "(n) North" << endl
         << "(s) South" << endl
         << "(e) East" << endl
         << "(w) West" << endl;
    char hemisphere = 'n';
    cin >> hemisphere;

    while (!(hemisphere == 'n' || hemisphere == 's' || hemisphere == 'e' ||
             hemisphere == 'w')) {
        cout << "Must enter one of (n, s, e, w). Try again:" << endl;
        cin >> hemisphere;
    }
    return hemisphere;
}

double computeLocationToDegrees(int degrees, int minutes, int seconds,
                             char hemisphere) {
    double minutesInDegrees = double(minutes) / 60.0f;
    double secondsInDegrees = double(seconds) / 3600.0f;
    double degreesTotal =
        double(degrees) + minutesInDegrees + secondsInDegrees;
    if (hemisphere == 's' || hemisphere == 'w') {
        degreesTotal *= -1;
    }
    return degreesTotal;
}
