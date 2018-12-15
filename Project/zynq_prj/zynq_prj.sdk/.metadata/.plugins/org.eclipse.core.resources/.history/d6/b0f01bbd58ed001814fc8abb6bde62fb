/*
 * I2C_8bit.h
 *
 *  Created on: 2017Äê8ÔÂ23ÈÕ
 *      Author: Administrator
 */

#ifndef SRC_I2C_8BIT_H_
#define SRC_I2C_8BIT_H_

#include "xiicps.h"
#include "xil_types.h"


#define OV_CAM 0x21

struct	config_table{
	u8	addr;
	u8	data;
};

int I2C_config_init();
int I2C_read(XIicPs *InstancePtr,u8 addr,u8 *read_buf);
int I2C_write(XIicPs *InstancePtr,u8 addr,u8 data);


#endif /* SRC_I2C_8BIT_H_ */
