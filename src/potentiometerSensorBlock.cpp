#include "distanceSensorBlock.h"
#include "mt_protocol.h"

#ifdef __cplusplus
extern "C"
{
#endif

    double potentiometerSensorRead(uint8_T port)
    {
        if (!auth(port, potentiometerID))
        {
            /* Wrong Sensor */
            return (double)-2;
        }

        setPortStatus(port);

        SPI_transfer(0x0b);
        delayMicroseconds(20);
        uint8_t MSB = SPI_transfer(0x00);
        delayMicroseconds(20);

        SPI_transfer(0x0c);
        delayMicroseconds(20);
        uint8_t LSB = SPI_transfer(0x00);
        delayMicroseconds(20);

        closeLines();

        return (double)((MSB << 8) | LSB);
    }

    void potentiometerSensorInit(void)
    {
        robotConfig();
        SPI_begin();
    }

#ifdef __cplusplus
}
#endif