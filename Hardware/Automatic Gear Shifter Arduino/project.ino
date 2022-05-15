/*
 * Prerequisites: 
 * Components - 
 *    Servo Motor
 *    DC Motor
 *    Infrared Sensor and Receiver
 *    Arduino Uno
 *    3-axis accelerometer (MPU6050)
 * Libraries - 
 *    Wire.h (for I2C)
 *    MPU6050.h (for MPU6050)
 *    Servo.h (for Servo Motor)
 *    
 * 1. Obtain accelerometer reading - done
 * 2. Pass it through MA filter
 * 3. Calculate value of slope 
 * 4. 
 * 
 * Authors:
 *    Aravind Bharathi
 *    Shyam Iyer
 */

// Include libraries
#include <Wire.h>
#include <MPU6050.h>
#include <Servo.h>

// Initialise object instances
MPU6050 mpu;
Servo myservo;

// Pin to drive Servo Motor
unsigned short int servoPin = 9;
// Pin to drive DC Motor
unsigned short int motorPin = 10;

// Set speed of wheel
unsigned short int Speed = 0;

// Variables to calculate speed of bicycle
volatile byte REV; // count of revolutions
unsigned long int tmpRPM,RPM; // RPM value
unsigned long int st=0; //
unsigned long int time_t; // 
unsigned long int time_since_change = 0;

int RPMlen, prevRPM;
float radius = 0.04; // Radius of wheel in metres

// Initialise variables for the core algorithm to manipulate the gear
float weight;
unsigned short int gear = 1;
float Threshold = 1;
float Buffer = 3;

//Vector rawAccel;
Vector normAccel;

// Declare flag variable
unsigned short int flag = 0;
unsigned short int flag1 = 1;

// Variables to process sensor readout
const unsigned short int n = 10;    // Number of readings to average over
float acc[n][3]={{0}};              // Accelerometer sensor input (initialised with zeroes)
float accAvg[3];                   // Moving average filter output
float spdAvg;
float rho;                          // For find_orientation
float slope;                        // Slope output

// Iterator variable declarations
unsigned short int i_movAvg, j_movAvg;
unsigned short int i_shiftAcc, j_shiftAcc;

//----------------------------------------------------------------------------------------

void setup() {

  // To display output in serial monitor
  Serial.begin(115200);

  mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G);

  // Following code has been reproduced from an open-source library MPU6050.h
  // <
  pinMode(2, INPUT_PULLUP);
  attachInterrupt(digitalPinToInterrupt(2), RPMCount, FALLING);

  Serial.println("Initialize MPU6050");
  /*
  while(!mpu.begin(MPU6050_SCALE_2000DPS, MPU6050_RANGE_2G))
  {
    Serial.println("Could not find a valid MPU6050 sensor, check wiring!");
    delay(500);
  }
  */
  // >

  // Set up servo pin
  myservo.attach(servoPin);

  // Set up motor pin
  pinMode(motorPin, OUTPUT);
  // Check if serial is active
  //while (!Serial);
    //Serial.println("Enter speed between 0 and 255");
}

void loop() {
  
   // Serial input to set speed
   //if (Serial.available()) {
//     Speed = 240;//Serial.parseInt();
//     if (Speed >= 0 && Speed <= 255) {
//         analogWrite(motorPin, Speed);
//     }
   //}

//  delay(1000);
  
  readRPM();
  spdAvg = ((float)RPM / 60.0 * (2.0 * 3.14 * radius));
//  if(flag1)
//  {
//    Serial.println(RPM);
//    flag1 = 0;
//  }

//  Serial.println("Before reading");
//  rawAccel = mpu.readRawAccel();
//  Serial.println("After reading 1");
  normAccel = mpu.readNormalizeAccel();
//  Serial.println("After reading 2");
  acc[n-1][0] = normAccel.XAxis;
  acc[n-1][1] = normAccel.YAxis;
  acc[n-1][2] = normAccel.ZAxis;

  MovingAverageFilter(acc);

  // Printing out the MA-ed values
//  Serial.print(" Xnorm = ");
//  Serial.print(normAccel.XAxis);
//  Serial.print(" Ynorm = ");
//  Serial.print(normAccel.YAxis);
//  Serial.print(" Znorm = ");
//  Serial.println(normAccel.ZAxis);

  accAvg[0] = normAccel.XAxis;
  accAvg[1] = normAccel.YAxis;
  accAvg[2] = normAccel.ZAxis;
  findSlope();
//  Serial.println(slope);
  if(millis() - time_since_change > 3000){
    CheckToShift();
    Serial.println("Gear :");
    Serial.println(gear);
    Serial.println("Speed :");
    Serial.println(spdAvg);
    Serial.print("Z norm Accel :");
    Serial.println(normAccel.ZAxis);
    //Writing to servo
    myservo.write(180-gear*(150/6));
    time_since_change = millis();
  }
  // delay(1000);

//  for (i_shiftAcc = 1; i_shiftAcc < n; i_shiftAcc++)
//    for (j_shiftAcc = 0; j_shiftAcc < 3; j_shiftAcc++)
//      acc[i_shiftAcc - 1][j_shiftAcc] = acc[i_shiftAcc][j_shiftAcc];
//  
}

// ----------------------------------------------------------------------------------------

void MovingAverageFilter(float arr[][3])
{
  accAvg[0] = accAvg[1] = accAvg[2] = 0;
  for (i_movAvg = 0; i_movAvg < n; i_movAvg++)
    for (j_movAvg = 0; j_movAvg < 3; j_movAvg++)
      // Alternatively, can save all averaged values over a longer period of time
      accAvg[j_movAvg] += arr[i_movAvg][j_movAvg];

  accAvg[0] /= n;
  accAvg[1] /= n;
  accAvg[2] /= n;
}

void findSlope()
{
  rho = fabs(sqrt(pow(accAvg[0],2) + pow(accAvg[1],2)));
  slope = atan(rho / fabs(accAvg[2])) * 180/3.14;
  
  if (accAvg[1] < 0)
    slope *= -1;
}

void ShiftUp()
{
  // Need to add servo motor specifics
  if (gear < 6)
    gear += 1;
}

void ShiftDown()
{
  // Need to add servo motor specifics
  if (gear > 1)
    gear -= 1;
}

void CheckToShift()
{
  // Need to calibrate sensor and change the divide-by accordingly
  weight = spdAvg/0.08 - slope/10;
  if (weight > gear * Threshold)
    ShiftUp();
  else if (weight <= ((gear - 1) * Threshold - Buffer))
    ShiftDown();
}

int readRPM()
{
  // RPM will be updated after every tenth reading or one second of being idle
  //if((REV >= 2) or (millis() >= st + 1000))
  {          
    if(flag == 0)                
      flag = 1;                     
    tmpRPM = (60/2) * (1000/(millis() - time_t)) * REV; 
    time_t = millis();                           
    REV = 0;
    int x= tmpRPM;                
    while(x!=0)
    {
      x = x/10;
      RPMlen++;
    }      
    //Serial.println(tmpRPM,DEC);
    RPM = tmpRPM;
    delay(500);
    st = millis();
    flag1 = 1;
  }
}

void RPMCount()                       
{
  REV++;
}
