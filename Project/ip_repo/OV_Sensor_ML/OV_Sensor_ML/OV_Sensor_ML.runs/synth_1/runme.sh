#!/bin/sh

# 
# Vivado(TM)
# runme.sh: a Vivado-generated Runs Script for UNIX
# Copyright 1986-2015 Xilinx, Inc. All Rights Reserved.
# 

echo "This script was generated under a different operating system."
echo "Please update the PATH and LD_LIBRARY_PATH variables below, before executing this script"
exit

if [ -z "$PATH" ]; then
  PATH=D:/Xilinx/SDK/2015.4/bin;D:/Xilinx/Vivado/2015.4/ids_lite/ISE/bin/nt64;D:/Xilinx/Vivado/2015.4/ids_lite/ISE/lib/nt64:D:/Xilinx/Vivado/2015.4/bin
else
  PATH=D:/Xilinx/SDK/2015.4/bin;D:/Xilinx/Vivado/2015.4/ids_lite/ISE/bin/nt64;D:/Xilinx/Vivado/2015.4/ids_lite/ISE/lib/nt64:D:/Xilinx/Vivado/2015.4/bin:$PATH
fi
export PATH

if [ -z "$LD_LIBRARY_PATH" ]; then
  LD_LIBRARY_PATH=
else
  LD_LIBRARY_PATH=:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH

HD_PWD='D:/MIZ_SOC/SEASON_03/CH05_AXI_DMA_OV7725_HDMI_702/Miz_ip_lib/OV_Sensor_ML/OV_Sensor_ML/OV_Sensor_ML.runs/synth_1'
cd "$HD_PWD"

HD_LOG=runme.log
/bin/touch $HD_LOG

ISEStep="./ISEWrap.sh"
EAStep()
{
     $ISEStep $HD_LOG "$@" >> $HD_LOG 2>&1
     if [ $? -ne 0 ]
     then
         exit
     fi
}

EAStep vivado -log OV_Sensor_ML.vds -m64 -mode batch -messageDb vivado.pb -notrace -source OV_Sensor_ML.tcl
