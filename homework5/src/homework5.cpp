// Anders Pitman - Homework 5 - Compute Dimensions
#include <iostream>
#include <math.h>

using namespace std;

struct Dimensions {
    double width;
    double height;
};


double getNumberFromUser(string promptMessage);
Dimensions *computeDimensions(double diagonal, double aspectRatio);
Dimensions *createDimensions();
void destroyDimensions(Dimensions *dimensions);
int isYes(char choice);


int main(int argc, char **argv) {
    char option = 'N';
    do {
        double diagonal = getNumberFromUser("Enter the diagonal:");
        double aspectRatio = getNumberFromUser("Enter the aspect ratio:");

        Dimensions *dimensions = computeDimensions(diagonal, aspectRatio);
        cout << "Width: " << dimensions->width << endl;
        cout << "Height: " << dimensions->height << endl << endl;
        destroyDimensions(dimensions);

        cout << "Run again? (y/N)" << endl;
        cin >> option;
    } while (isYes(option));

    return 0;
}

double getNumberFromUser(string promptMessage) {
    cout << promptMessage << endl;
    double number = 0.0f;
    cin >> number;
    return number;
}

Dimensions *computeDimensions(double diagonal, double aspectRatio) {
    Dimensions *dimensions = createDimensions();
    double diagonalSquared = pow(diagonal, 2);
    double aspectRatioSquared = pow(aspectRatio, 2);
    double x = sqrt(diagonalSquared / (1 + aspectRatioSquared));
    dimensions->width = aspectRatio * x;
    dimensions->height = x;
    return dimensions;
}

Dimensions *createDimensions() {
    return new Dimensions();
}

void destroyDimensions(Dimensions *dimensions) {
    delete dimensions;
}

int isYes(char choice) {
    return choice == 'y' || choice == 'Y';
}
