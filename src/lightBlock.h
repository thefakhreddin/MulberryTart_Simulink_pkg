#ifndef _DIGITALIO_ARDUINO_H_
#define _DIGITALIO_ARDUINO_H_
#include "rtwtypes.h"
#include <Arduino.h>
#include "mt_config.h"

#ifdef __cplusplus
extern "C" {
#endif
    
void lightInit(uint8_T number);
void lightDrive(int color, uint8_T number);

#ifdef __cplusplus
}
#endif

#endif //_DIGITALIO_ARDUINO_H_