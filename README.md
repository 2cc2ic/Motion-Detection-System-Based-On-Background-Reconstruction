# Motion-Detection-System-Based-On-Background-Reconstruction
The work is based on the PYNQ-Z2 development board provided by tournament organizer, and uses the hardware and software co-scheme to build the image data cache transmission system based on DMA. On this basis, the image processing IP core based on AXI4-stream interface is designed by using Verilog HDL, and a high real-time moving target detection system is constructed. In our design, we focus on the optimization of processing pipeline, improve the traditional frame difference method, and achieve the optimization goal of saving logical resources through the cumulative compression and reconstruction of the buffer background frame.
