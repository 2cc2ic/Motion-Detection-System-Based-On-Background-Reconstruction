# Motion-Detection-System-Based-On-Background-Reconstruction
This work is based on PYNQ-Z2 development board provided by organizer, and adopts the cooperation scheme of hardware and software to build a DMA based image data cache transmission system.

On this basis, Verilog HDL was used to design the axi4-stream interface based IP core for image processing, so as to build a high real-time moving target detection system.

In our design, we focus on the optimization of processing pipeline, improve the traditional frame difference method, and achieve the optimization goal of saving logical resources through the accumulation compression and reconstruction expansion of cached background frames.

作品基于赛方提供的PYNQ-Z2开发板,采用软硬件协同方案,搭建基于DMA的图像数据缓存传输系统。

在此基础上,使用Verilog HDL设计基于 AXI4-stream 接口的图像处理IP核,从而构建高实时性的运动目标检测系统。

在我们的设计中，侧重对处理流水线优化，将传统帧差法进行改进，通过对缓存背景帧的累加压缩和重建展开达到节省逻辑资源的优化目标。