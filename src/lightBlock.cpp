#include "motorBlock.h"

extern "C" void motorInit(uint8_T port)
{
    switch (port)
    {
    case 1:
        pinMode(speedControl_M1, OUTPUT);
        pinMode(directionControl_M1, OUTPUT);
        break;
    case 2:
        pinMode(speedControl_M2, OUTPUT);
        pinMode(directionControl_M2, OUTPUT);
        break;
    case 3:
        pinMode(speedControl_M3, OUTPUT);
        pinMode(directionControl_M3, OUTPUT);
        break;
    case 4:
        pinMode(speedControl_M4, OUTPUT);
        pinMode(directionControl_M4, OUTPUT);
        break;
    }
}

extern "C" void motorDrive(int speed, uint8_T port)
{
    switch (port)
    {
    case 1:
        analogWrite(speedControl_M1, abs(speed));
        digitalWrite(directionControl_M1, speed>0 ? HIGH : LOW);
        break;
    case 2:
        analogWrite(speedControl_M2, abs(speed));
        digitalWrite(directionControl_M2, speed>0 ? HIGH : LOW);
        break;
    case 3:
        analogWrite(speedControl_M3, abs(speed));
        digitalWrite(directionControl_M3, speed>0 ? HIGH : LOW);
        break;
    case 4:
        analogWrite(speedControl_M4, abs(speed));
        digitalWrite(directionControl_M4, speed>0 ? HIGH : LOW);
        break;
    }
}
