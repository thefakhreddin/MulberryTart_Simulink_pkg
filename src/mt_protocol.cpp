#include <mt_protocol.h>

#ifdef __cplusplus
extern "C"
{
#endif

  void setPortStatus(uint8_t port)
  {
    if (port == 1)
    {
      digitalWrite(CS_Sensor1, 0);
      digitalWrite(CS_Sensor2, 1);
      digitalWrite(CS_Sensor3, 1);
      digitalWrite(CS_Sensor4, 1);
    }

    if (port == 2)
    {
      digitalWrite(CS_Sensor1, 1);
      digitalWrite(CS_Sensor2, 0);
      digitalWrite(CS_Sensor3, 1);
      digitalWrite(CS_Sensor4, 1);
    }

    if (port == 3)
    {
      digitalWrite(CS_Sensor1, 1);
      digitalWrite(CS_Sensor2, 1);
      digitalWrite(CS_Sensor3, 0);
      digitalWrite(CS_Sensor4, 1);
    }

    if (port == 4)
    {
      digitalWrite(CS_Sensor1, 1);
      digitalWrite(CS_Sensor2, 1);
      digitalWrite(CS_Sensor3, 1);
      digitalWrite(CS_Sensor4, 0);
    }
  }

  void closeLines(void)
  {
    digitalWrite(CS_Sensor1, 1);
    digitalWrite(CS_Sensor2, 1);
    digitalWrite(CS_Sensor3, 1);
    digitalWrite(CS_Sensor4, 1);
  }

  void robotConfig(void)
  {
    pinMode(BATTERY_PIN, INPUT);

    /* Motors Initialization */
    pinMode(speedControl_M1, OUTPUT);
    pinMode(speedControl_M2, OUTPUT);
    pinMode(speedControl_M3, OUTPUT);
    pinMode(speedControl_M4, OUTPUT);
    pinMode(directionControl_M1, OUTPUT);
    pinMode(directionControl_M2, OUTPUT);
    pinMode(directionControl_M3, OUTPUT);
    pinMode(directionControl_M4, OUTPUT);

    /* input pins Initialization */
    pinMode(CS_Sensor1, OUTPUT);
    pinMode(CS_Sensor2, OUTPUT);
    pinMode(CS_Sensor3, OUTPUT);
    pinMode(CS_Sensor4, OUTPUT);
  }

  bool auth(uint8_T port, uint8_T sensor)
  {
    setPortStatus(port);
    SPI_transfer(0x0a);
    delayMicroseconds(20);
    uint8_t id = SPI_transfer(0x00);
    delayMicroseconds(20);
    closeLines();

    if (id == sensor)
      return true;
    return false;
  }

#ifdef __cplusplus
}
#endif