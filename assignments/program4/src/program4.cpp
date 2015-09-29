// Anders Pitman - Program 4
#include <iostream>
#include <math.h>

using namespace std;

const int DEGREES_MIN = 0;
const int DEGREES_MAX = 180;
const int MINUTES_MIN = 0;
const int MINUTES_MAX = 60;
const int SECONDS_MIN = 0;
const int SECONDS_MAX = 60;
const double LAT_LON_MIN = -180.0f;
const double LAT_LON_MAX = 180.0f;
const double PI = 3.14159f;
const double EARTH_RADIUS_MILES = 3960.0f;

enum Option {
    OPTION_LOCATION_TO_DEGRESS = 1,
    OPTION_LAT_LON_TO_DIMENSIONAL = 2,
    OPTION_STOP = 5
};


void handleLocationToDegrees();
int getIntegerInRangeFromUser(int lowerBound, int upperBound,
                              string promptMessage);
char getHemisphereFromUser();
double computeLocationToDegrees(int degrees, int minutes, int seconds,
                                char hemisphere);
void handleLatLonToDimensional();
double getNumberInRangeFromUser(double lowerBound, double upperBound,
                                string promptMessage);
void computeLatLonToDimensional(double latitude, double longitude,
                                double &x, double &y, double &z);


int main(int argc, char **argv) {
    int option = OPTION_STOP;
    do {
        cout << "Enter an integer to choose an option:" << endl;
        cout << "(" << OPTION_LOCATION_TO_DEGRESS << ") "
             << "Convert from degrees-minutes-seconds-hemisphere to degrees"
             << endl;
        cout << "(" << OPTION_LAT_LON_TO_DIMENSIONAL << ") "
             << "Convert latitude-longitude to three dimensional coordinates"
             << "(x-y-z)" << endl;
        cout << "(3) " << endl
             << "(4) " << endl
             << "(" << OPTION_STOP << ") "
             << "Stop program" << endl;
        cin >> option;

        switch (option) {
            case OPTION_LOCATION_TO_DEGRESS:
                handleLocationToDegrees();
                break;
            case OPTION_LAT_LON_TO_DIMENSIONAL:
                handleLatLonToDimensional();
                break;
            case OPTION_STOP:
                cout << "Stopping program" << endl;
                break;
            default:
                cerr << "Invalid input: " << option << endl << endl;
                break;
        };
    } while (option != OPTION_STOP);

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

void handleLatLonToDimensional() {
    double latitude = getNumberInRangeFromUser(LAT_LON_MIN, LAT_LON_MAX,
                                               "Enter the latitude");
    double longitude = getNumberInRangeFromUser(LAT_LON_MIN, LAT_LON_MAX,
                                                "Enter the longitude");
    double x = 0.0f;
    double y = 0.0f;
    double z = 0.0f;
    computeLatLonToDimensional(latitude, longitude, x, y, z);
    cout << x << endl;
    cout << y << endl;
    cout << z << endl;
}

double getNumberInRangeFromUser(double lowerBound, double upperBound,
                                string promptMessage) {
    cout << promptMessage << endl;
    double input = 0.0f;
    cin >> input;

    while (input < lowerBound || input > upperBound) {
        cout << "Value must be between " << lowerBound << " and "
             << upperBound << ". Try again:" << endl;
        cin >> input;
    }
    return input;
}

void computeLatLonToDimensional(double latitude, double longitude,
                                double &x, double &y, double &z) {
    double latAngle = (90.0f - latitude) * PI/180.0f;
    double lonAngle = longitude * PI / 180.0f;
    x = EARTH_RADIUS_MILES * sin(latAngle) * cos(lonAngle);
    y = EARTH_RADIUS_MILES * sin(latAngle) * sin(lonAngle);
    z = EARTH_RADIUS_MILES * cos(latAngle);
}
