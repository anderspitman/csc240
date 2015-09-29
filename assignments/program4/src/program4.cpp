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
const char HEMI_INIT = 'n';

enum MainOption {
    OPTION_BASIC_CALCULATIONS = 1,
    OPTION_DISTANCE_BETWEEN_POINTS = 2,
    OPTION_TRIP_DISTANCE = 3,
    OPTION_STOP = 4,
};

enum BasicCalcOption {
    OPTION_LOCATION_TO_DEGRESS = 1,
    OPTION_LAT_LON_TO_DIMENSIONAL = 2,
    OPTION_DOT_PRODUCT = 3,
    OPTION_NORM = 4,
    OPTION_MAIN_MENU = 5,
};


void phase1();
void handleLocationToDegrees();
void getPositionFromUser(double &degrees, double &minutes, double &seconds,
                         char &hemisphere, string whatFor);
int getIntegerInRangeFromUser(int lowerBound, int upperBound,
                              string promptMessage);
char getHemisphereFromUser(string prompt);
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
double computeNorm(double x, double y, double z);

void handleDistanceBetweenTwoPoints();
double distanceBetweenTwoPointsLatLon(double pointALat, double pointALon,
                                      double pointBLat, double pointBLon);

double distanceBetweenTwoPoints(
    int degreesALat, int minutesALat, int secondsALat, char hemisphereALat,
    int degreesALon, int minutesALon, int secondsALon, char hemisphereALon,
    int degreesBLat, int minutesBLat, int secondsBLat, char hemisphereBLat,
    int degreesBLon, int minutesBLon, int secondsBLon, char hemisphereBLon);

int main(int argc, char **argv) {
    int option = OPTION_STOP;
    do {
        cout << "Enter an integer to choose an option:" << endl;
        cout << "(" << OPTION_BASIC_CALCULATIONS << ")"
             << " Basic Calculations"
             << endl;
        cout << "(" << OPTION_DISTANCE_BETWEEN_POINTS << ")"
             << " Compute the distance between two points"
             << endl;
        cout << "(" << OPTION_TRIP_DISTANCE << ")"
             << " Compute distances over an extended trip of one or more"
             << " stops"
             << endl;
        cout << "(" << OPTION_STOP << ")"
             << " Stop the program" << endl;
        cin >> option;
        cout << endl;

        switch (option) {
            case OPTION_BASIC_CALCULATIONS:
                phase1();
                break;
            case OPTION_DISTANCE_BETWEEN_POINTS:
                handleDistanceBetweenTwoPoints();
                break;
            case OPTION_TRIP_DISTANCE:
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

void phase1() {
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
        cout << "(" << OPTION_MAIN_MENU << ")"
             << " Return to the main menu" << endl;
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
            case OPTION_MAIN_MENU:
                cout << "Returning to main menu" << endl << endl;
                break;
            default:
                cerr << "Invalid input: " << option << endl << endl;
                break;
        };
    } while (option != OPTION_MAIN_MENU);
}

void handleLocationToDegrees() {
    double degrees = 0.0f;
    double minutes = 0.0f;
    double seconds = 0.0f;
    char hemisphere = 'n';
    getPositionFromUser(degrees, minutes, seconds, hemisphere, "position");

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

char getHemisphereFromUser(string prompt) {
    cout << prompt << endl;
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
    double norm = computeNorm(x, y, z);
    cout << "Norm: " << norm << endl << endl;
}

double computeNorm(double x, double y, double z) {
    return sqrt(pow(x, 2) + pow(y, 2) + pow(z, 2));
}

void getPositionFromUser(double &degrees, double &minutes, double &seconds,
                         char &hemisphere, string whatFor) {
    string whatForInsert = "";
    if (!whatFor.empty()) {
    whatForInsert += (" for " + whatFor);
    }

    string prompt = "";

    prompt = "Enter degrees" + whatForInsert + ":";
    degrees = getIntegerInRangeFromUser(DEGREES_MIN, DEGREES_MAX, prompt);
    prompt = "Enter minutes" + whatForInsert + ":";
    minutes = getIntegerInRangeFromUser(DEGREES_MIN, DEGREES_MAX, prompt);
    prompt = "Enter seconds" + whatForInsert + ":";
    seconds = getIntegerInRangeFromUser(DEGREES_MIN, DEGREES_MAX, prompt);
    prompt = "Enter hemisphere" + whatForInsert + ":";
    hemisphere = getHemisphereFromUser(prompt);
}

void handleDistanceBetweenTwoPoints() {
    cout << "You will enter latitude and longitude 2 points (A and B):"
         << endl;

    string prompt = "";

    double degreesALat = 0.0;
    double minutesALat = 0.0;
    double secondsALat = 0.0;
    char hemisphereALat = HEMI_INIT;
    getPositionFromUser(degreesALat, minutesALat, secondsALat,
                        hemisphereALat, "point A latitude");

    double degreesALon = 0.0;
    double minutesALon = 0.0;
    double secondsALon = 0.0;
    char hemisphereALon = HEMI_INIT;
    getPositionFromUser(degreesALon, minutesALon, secondsALon,
                        hemisphereALon, "point A longitude");

    double degreesBLat = 0.0;
    double minutesBLat = 0.0;
    double secondsBLat = 0.0;
    char hemisphereBLat = HEMI_INIT;
    getPositionFromUser(degreesBLat, minutesBLat, secondsBLat,
                        hemisphereBLat, "point B latitude");

    double degreesBLon = 0.0;
    double minutesBLon = 0.0;
    double secondsBLon = 0.0;
    char hemisphereBLon = HEMI_INIT;
    getPositionFromUser(degreesBLon, minutesBLon, secondsBLon,
                        hemisphereBLon, "point B longitude");


    double distanceBetween = distanceBetweenTwoPoints(
        degreesALat, minutesALat, secondsALat, hemisphereALat,
        degreesALon, minutesALon, secondsALon, hemisphereALon,
        degreesBLat, minutesBLat, secondsBLat, hemisphereBLat,
        degreesBLon, minutesBLon, secondsBLon, hemisphereBLon);

    cout << "Distance: " << distanceBetween << " miles" << endl << endl;
}

double distanceBetweenTwoPointsLatLon(double pointALat, double pointALon,
                                      double pointBLat, double pointBLon) {
    double aX = 0.0;
    double aY = 0.0;
    double aZ = 0.0;
    computeLatLonToDimensional(pointALat, pointALon, aX, aY, aZ);
    double normA = computeNorm(aX, aY, aZ);

    double bX = 0.0;
    double bY = 0.0;
    double bZ = 0.0;
    computeLatLonToDimensional(pointBLat, pointBLon, bX, bY, bZ);
    double normB = computeNorm(bX, bY, bZ);

    double dotProduct = computeDotProduct(aX, aY, aZ, bX, bY, bZ);

    double greatCircleAngleRadians = acos(dotProduct / (normA * normB));

    double distanceMiles = EARTH_RADIUS_MILES * greatCircleAngleRadians;
    return distanceMiles;
}

double distanceBetweenTwoPoints(
    int degreesALat, int minutesALat, int secondsALat, char hemisphereALat,
    int degreesALon, int minutesALon, int secondsALon, char hemisphereALon,
    int degreesBLat, int minutesBLat, int secondsBLat, char hemisphereBLat,
    int degreesBLon, int minutesBLon, int secondsBLon, char hemisphereBLon) {

    double aLat = computeLocationToDegrees(degreesALat, minutesALat,
                                           secondsALat, hemisphereALat);
    double aLon = computeLocationToDegrees(degreesALon, minutesALon,
                                           secondsALon, hemisphereALon);
    double bLat = computeLocationToDegrees(degreesBLat, minutesBLat,
                                           secondsBLat, hemisphereBLat);
    double bLon = computeLocationToDegrees(degreesBLon, minutesBLon,
                                           secondsBLon, hemisphereBLon);
    double distanceBetween = distanceBetweenTwoPointsLatLon(aLat, aLon, bLat,
                                                            bLon);
    return distanceBetween;
}
