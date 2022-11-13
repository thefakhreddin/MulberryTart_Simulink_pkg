#ifndef mt_protocol_h
#define mt_protocol_h

#include "Arduino.h"
#include "SPI_C.h"
#include "mt_config.h"
#include "rtwtypes.h"
#include "mt_identifier.h"

#ifdef __cplusplus
extern "C"
{
#endif

    void setPortStatus(uint8_t port);
    void closeLines(void);
    void robotConfig(void);
    bool auth(uint8_T port, uint8_T sensor);

#ifdef __cplusplus
}
#endif

#endif
