/*
 * Copyright (c) 2015, Freescale Semiconductor, Inc.
 * Copyright 2016 NXP
 * All rights reserved.
 *
 *
 * SPDX-License-Identifier: BSD-3-Clause
 *
 */

#include "fsl_common.h"
#include "pin_mux.h"
#include "fsl_iopctl.h"

#define PIN1_IDX                         1u   /*!< Pin number for pin 1 in a port */
#define PIN2_IDX                         2u   /*!< Pin number for pin 2 in a port */
#define PIN18_IDX                        18u  /*!< Pin number for pin 18 in a port */
#define PIN19_IDX                        19u  /*!< Pin number for pin 19 in a port */
#define PIN20_IDX                        20u  /*!< Pin number for pin 20 in a port */
#define PIN21_IDX                        21u  /*!< Pin number for pin 21 in a port */
#define PIN22_IDX                        22u  /*!< Pin number for pin 22 in a port */
#define PIN23_IDX                        23u  /*!< Pin number for pin 23 in a port */
#define PIN24_IDX                        24u  /*!< Pin number for pin 24 in a port */
#define PIN25_IDX                        25u  /*!< Pin number for pin 25 in a port */
#define PIN26_IDX                        26u  /*!< Pin number for pin 26 in a port */
#define PIN27_IDX                        27u  /*!< Pin number for pin 27 in a port */
#define PIN28_IDX                        28u  /*!< Pin number for pin 28 in a port */
#define PIN29_IDX                        29u  /*!< Pin number for pin 29 in a port */
#define PORT0_IDX                        0u   /*!< Port index */
#define PORT1_IDX                        1u   /*!< Port index */


/*FUNCTION**********************************************************************
 *
 * Function Name : BOARD_InitPins
 * Description   : Configures pin routing and optionally pin electrical features.
 *
 *END**************************************************************************/
void BOARD_InitPins(void)
{
  const uint32_t port0_pin1_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_txd */
    IOPCTL_PULLUP_EN |                                    /* Enable pull-up */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT0_IDX, PIN1_IDX, port0_pin1_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port0_pin2_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_rxd */
    IOPCTL_PULLUP_EN |                                    /* Enable pull-up */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT0_IDX, PIN2_IDX, port0_pin2_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */

  const uint32_t port1_pin18_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_txd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN18_IDX, port1_pin18_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin19_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_rxd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN19_IDX, port1_pin19_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin20_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_txd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN20_IDX, port1_pin20_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin21_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_rxd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN21_IDX, port1_pin21_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin22_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_txd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN22_IDX, port1_pin22_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin23_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_rxd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN23_IDX, port1_pin23_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin24_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_txd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN24_IDX, port1_pin24_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin25_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_rxd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN25_IDX, port1_pin25_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin26_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_txd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN26_IDX, port1_pin26_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin27_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_rxd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN27_IDX, port1_pin27_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin28_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_txd */
    IOPCTL_PUPD_EN |                                      /* Enable pull-up/pull-down */
    IOPCTL_PULLDOWN_EN |                                  /* Enable pull-down */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN28_IDX, port1_pin28_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
  const uint32_t port1_pin29_config = (
    IOPCTL_FUNC1 |                                        /* Pin is configured as fc0_rxd */
    IOPCTL_FULLDRIVE_EN |                                /* Enable full-drive */
    IOPCTL_INBUF_EN                                      /* Enables input buffer */
  );
  IOPCTL_PinMuxSet(IOPCTL, PORT1_IDX, PIN29_IDX, port1_pin29_config); /* PORT0 PIN3 (coords: 32) is configured as FC0_TXD_SCL_MISO */
}
