// C code to compile and test functions on gcc
#include <iostream>
using namespace std;

float slope;
float spd_avg;
float weight;
unsigned short int gear = 1;
float threshold = 10;
float buffer = 3;

void shift_up()
{
    // Need to add servo motor specifics
    if (gear < 6)
    {
        gear += 1;
    }
}

void shift_down()
{
    // Need to add servo motor specifics
    if (gear > 1)
    {
        gear -= 1;
    }
}

void check_to_shift()
{
    // Need to calibrate sensor and change the divide-by accordingly
    weight = spd_avg/1 - slope/2;
    if (weight > gear * threshold)
        shift_up();
    else if (weight <= ((gear - 1) * threshold - buffer))
        shift_down();
}

// Ignore this function. The brute force version of the simpler function above
void check_to_shift_brute()
{
    weight = spd_avg/1 - slope/2;
    switch(gear)
    {
        // Overlapping intervals
        // Gear 1 == 0 - 10
        case 1:
            if (weight > gear*threshold)
                shift_up();
            break;

        // Gear 2 == 8 - 20
        case 2:
            if (weight > gear*threshold)
                shift_up();
            else if (weight <= (gear - 1)*threshold - buffer)
                shift_down();
            break;

        // Gear 3 == 18 - 30
        case 3:
            if (weight > gear*threshold)
                shift_up();
            else if (weight <= (gear - 1)*threshold - buffer)
                shift_down();
            break;
                
        // Gear 4 == 28 - 40
        case 4:
            if (weight > gear*threshold)
                shift_up();
            else if (weight <= (gear - 1)*threshold - buffer)
                shift_down();
            break;

        // Gear 5 == 38 - 50
        case 5:
            if (weight > gear*threshold)
                shift_up();
            else if (weight <= (gear - 1)*threshold - buffer)
                shift_down();
            break;

        // Gear 6 == 48 - infinite
        case 6:
            if (weight <= (gear - 1)*threshold - buffer)
                shift_down();            
            break;
    }
}

int main()
{
    // Anything inside main is just for software testing. 
    // Will modify hardware implementation and include the 
    // sensor readout and loop()
    int i = 0;
    for (i = 0; i < 10; i++)
    {
        cout << "\nEnter average speed and slope\n";
        cin >> spd_avg >> slope;
        check_to_shift();
        cout << gear << endl;
    }

    return 1;
}
