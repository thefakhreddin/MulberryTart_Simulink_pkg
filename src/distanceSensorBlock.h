#ifndef _DISTANCE_SENSOR_BLOCK_H_
#define _DISTANCE_SENSOR_BLOCK_H_

#include <Arduino.h>
#include "rtwtypes.h"
#include "mt_config.h"
#include "mt_identifier.h"
#include "SPI_C.h"

#ifdef __cplusplus
extern "C"
{
#endif

    void distanceSensorInit(void);
    double distanceSensorRead(uint8_T port);

#ifdef __cplusplus
}
#endif

#endif