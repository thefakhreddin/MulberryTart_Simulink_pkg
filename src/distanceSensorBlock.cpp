#include "distanceSensorBlock.h"
#include "mt_protocol.h"


#ifdef __cplusplus
extern "C"
{
#endif

    double distanceSensorRead(uint8_T port)
    {
        if (!auth(port, ultrasonicSensorID))
        {
            /* Wrong Sensor */
            return (double)-2;
        }

        setPortStatus(port);

        SPI_transfer(0x0b);
        delayMicroseconds(20);
        uint8_t distance = SPI_transfer(0x00);
        delayMicroseconds(20);

        closeLines();

        if (distance > 200)
        {
            return (double)-1; // Wrong Data
        }
        return (double)distance;
    }

    void distanceSensorInit(void)
    {
        robotConfig();
        SPI_begin();
    }

#ifdef __cplusplus
}
#endif