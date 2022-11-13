#ifndef mt_confing_h
#define mt_confing_h

#if ARDUINO >= 100
#include "Arduino.h"
#else
#include "WProgram.h"
#endif

//Define Peripheral Pins
//-----------------------------------------------------------------------*/
// Driver Motor 1 - Channel 1 - M1
#define speedControl_M1 6
#define directionControl_M1 12

// Driver Motor 1 - Channel 2 - M2
#define speedControl_M2 9
#define directionControl_M2 8

// Driver Motor 2 - Channel 1 - M3
#define speedControl_M3 5
#define directionControl_M3 A0

// Driver Motor 2 - Channel 2 - M4
#define speedControl_M4 13
#define directionControl_M4 A1

//SPI protocol _ Chip Select (CS)
#define CS_Sensor1 A3
#define CS_Sensor2 A4
#define CS_Sensor3 7 // for older board 11 , new 7
#define CS_Sensor4 A2 // for older board 2 , new A2

// Buzzer
#define BUZZER_PIN 10

// RGB LED WS2812 Line Control
#define lightPin 11 //for older board 3 , new 11
#define num_rgb 4

// Battery Cheak
#define BATTERY_PIN A5

#endif
