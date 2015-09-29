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
    OPTION_DOT_PRODUCT = 3,
    OPTION_NORM = 4,
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
void handleDotProduct();
double getNumberFromUser(string promptMessage);
double computeDotProduct(double x1, double y1, double z1, double x2,
                         double y2, double z2);
void handleNorm();


int main(int argc, char **argv) {
    int option = OPTION_STOP;
    do {
        cout << "Enter an integer to choose an option:" << endl;
        cout << "(" << OPTION_LOCATION_TO_DEGRESS << ")"
             << " Convert from degrees-minutes-seconds-hemisphere to degrees"
             << endl;
        cout << "(" << OPTION_LAT_LON_TO_DIMENSIONAL << ")"
             << " Convert latitude-longitude to three dimensional coordinates"
             << "(x-y-z)" << endl;
        cout << "(" << OPTION_DOT_PRODUCT << ")"
             << " Compute the dot-product of two three-dimensional points"
             << endl;
        cout << "(" << OPTION_NORM << ")"
             << " Compute the norm of a three-dimensional point"
             << endl;
        cout << "(" << OPTION_STOP << ")"
             << " Stop the program" << endl;
        cin >> option;
        cout << endl;

        switch (option) {
            case OPTION_LOCATION_TO_DEGRESS:
                handleLocationToDegrees();
                break;
            case OPTION_LAT_LON_TO_DIMENSIONAL:
                handleLatLonToDimensional();
                break;
            case OPTION_DOT_PRODUCT:
                handleDotProduct();
                break;
            case OPTION_NORM:
                handleNorm();
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

    cout << "Answer in degrees: " << degreesTotal << endl << endl;
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
                                               "Enter the latitude:");
    double longitude = getNumberInRangeFromUser(LAT_LON_MIN, LAT_LON_MAX,
                                                "Enter the longitude:");
    double x = 0.0f;
    double y = 0.0f;
    double z = 0.0f;
    computeLatLonToDimensional(latitude, longitude, x, y, z);
    cout << endl;
    cout << "3-dimensional coordinates:" << endl;
    cout << "x: " << x << endl;
    cout << "y: " << y << endl;
    cout << "z: " << z << endl << endl;
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
    double latAngle = (90.0f - latitude) * PI / 180.0f;
    double lonAngle = longitude * PI / 180.0f;
    x = EARTH_RADIUS_MILES * sin(latAngle) * cos(lonAngle);
    y = EARTH_RADIUS_MILES * sin(latAngle) * sin(lonAngle);
    z = EARTH_RADIUS_MILES * cos(latAngle);
}

void handleDotProduct() {
    cout << "You will enter two points: (x1, y1, z1) and (x2, y2, z2)"
         << endl;
    double x1 = getNumberFromUser("Enter x1:");
    double y1 = getNumberFromUser("Enter y1:");
    double z1 = getNumberFromUser("Enter z1:");

    double x2 = getNumberFromUser("Enter x2:");
    double y2 = getNumberFromUser("Enter y2:");
    double z2 = getNumberFromUser("Enter z2:");

    double dotProduct = computeDotProduct(x1, y1, z1, x2, y2, z2);
    cout << "Dot product:" << dotProduct << endl << endl;
}

double getNumberFromUser(string promptMessage) {
    cout << promptMessage << endl;
    double number = 0.0f;
    cin >> number;
    return number;
}

double computeDotProduct(double x1, double y1, double z1, double x2,
                         double y2, double z2) {
    return x1*x2 + y1*y2 + z1*z2;
}

void handleNorm() {
    cout << "You will endter a single point (x, y, z)" << endl;
    double x = getNumberFromUser("Enter x:");
    double y = getNumberFromUser("Enter y:");
    double z = getNumberFromUser("Enter z:");
    double norm = sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
    cout << "Norm: " << norm << endl << endl;
}
