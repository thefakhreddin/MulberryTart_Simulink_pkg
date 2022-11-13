#ifndef _MOTOR_BLOCK_H_
#define _MOTOR_BLOCK_H_

#include "rtwtypes.h"
#include <Arduino.h>
#include "mt_config.h"
#include "mt_identifier.h"
#include "mt_protocol.h"

#ifdef __cplusplus
extern "C" {
#endif
    
void motorInit(uint8_T port);
void motorDrive(int speed, uint8_T port);

#ifdef __cplusplus
}
#endif

#endif