# Motion-Detection-System-Based-On-Background-Reconstruction

### Overview

This work is based on PYNQ-Z2 development board provided by organizer, and adopts the cooperation scheme of hardware and software to build a DMA based image data cache transmission system.

On this basis, Verilog HDL was used to design the axi4-stream interface based IP core for image processing, so as to build a high real-time moving target detection system.

In our design, we focus on the optimization of processing pipeline, improve the traditional frame difference method, and achieve the optimization goal of saving logical resources through the accumulation compression and reconstruction expansion of cached background frames.

**作品基于赛方提供的PYNQ-Z2开发板,采用软硬件协同方案,搭建基于DMA的图像数据缓存传输系统。**

**在此基础上,使用Verilog HDL设计基于 AXI4-stream 接口的图像处理IP核,从而构建高实时性的运动目标检测系统。**

**在我们的设计中，侧重对处理流水线优化，将传统帧差法进行改进，通过对缓存背景帧的累加压缩和重建展开达到节省逻辑资源的优化目标。**

***
### System Architecture
![图像数据流程.jpg](https://github.com/zhanghaoqing/Motion-Detection-System-Based-On-Background-Reconstruction/blob/master/Picture/system%20structure/%E5%9B%BE%E5%83%8F%E6%95%B0%E6%8D%AE%E6%B5%81%E7%A8%8B.jpg?raw=true)

![ip.jpg](https://github.com/zhanghaoqing/Motion-Detection-System-Based-On-Background-Reconstruction/blob/master/Picture/system%20structure/ip.jpg?raw=true)



![技术特点.jpg](https://github.com/zhanghaoqing/Motion-Detection-System-Based-On-Background-Reconstruction/blob/master/Picture/system%20structure/%E6%8A%80%E6%9C%AF%E7%89%B9%E7%82%B9.jpg?raw=true)



***
**PS:**

1. The Picture folder contains pictures about the project
   **Picture文件夹包含了关于项目的图片**

2. The IP folder just contains the image processing IP
   **IP文件夹只是包含了图像处理IP**