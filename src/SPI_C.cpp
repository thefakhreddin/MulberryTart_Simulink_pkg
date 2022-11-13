#include "SPI_C.h"

uint8_t initialized = 0;
uint8_t interruptMode = 0;
uint8_t interruptMask = 0;
uint8_t interruptSave = 0;
#ifdef SPI_TRANSACTION_MISMATCH_LED
uint8_t inTransactionFlag = 0;
#endif

#ifdef __cplusplus
extern "C"
{
#endif

  void SPI_begin()
  {
    uint8_t sreg = SREG;
    noInterrupts(); // Protect from a scheduler and prevent transactionBegin
    if (!initialized)
    {

      uint8_t port = digitalPinToPort(SS);
      uint8_t bit = digitalPinToBitMask(SS);
      volatile uint8_t *reg = portModeRegister(port);

      if (!(*reg & bit))
      {
        digitalWrite(SS, HIGH);
      }

      pinMode(SS, OUTPUT);

      SPCR |= _BV(MSTR);
      SPCR |= _BV(SPE);

      pinMode(SCK, OUTPUT);
      pinMode(MOSI, OUTPUT);
    }
    initialized++; // reference count
    SREG = sreg;
  }

  uint8_t SPI_transfer(uint8_t data)
  {
    SPDR = data;
    asm volatile("nop");
    while (!(SPSR & _BV(SPIF)))
      ; // wait
    return SPDR;
  }

#ifdef __cplusplus
}
#endif