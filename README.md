# Underwater Acoustic Communication using BFSK

## Overview

This project presents the design and simulation of an **Underwater Acoustic Digital Communication System** using **Binary Frequency Shift Keying (BFSK)**. The system is implemented in **MATLAB and Simulink**, incorporating realistic underwater channel effects and performance evaluation using Bit Error Rate (BER) analysis.

The receiver employs a **Goertzel-based frequency detector** for reliable demodulation of BFSK signals in noisy and fading underwater environments.

---

## System Architecture

The complete communication system consists of the following blocks:

* **BFSK Transmitter**

  * Binary data generation
  * Frequency mapping for BFSK modulation
* **Underwater Acoustic Channel**

  * Rician fading (multipath effects)
  * Additive White Gaussian Noise (AWGN)
* **BFSK Receiver**

  * Bandpass filtering
  * Automatic Gain Control (AGC)
  * Frequency detection using Goertzel algorithm
* **Performance Evaluation**

  * Bit Error Rate (BER) computation
  * Delay-based synchronization analysis

---

## Key Features

* Binary Frequency Shift Keying (BFSK) modulation
* Realistic underwater acoustic channel modeling
* Rician multipath fading simulation
* AWGN noise analysis
* Bandpass filtering and AGC at the receiver
* **Goertzel-based frequency detection**
* BER analysis under different delays and SNR conditions
* Sample-by-sample real-time bit detection

---

## Goertzel-Based FSK Detector

The BFSK receiver uses a **custom MATLAB implementation of the Goertzel algorithm** for frequency detection.

**Detected Frequencies:**

* `600 Hz` → Bit `0`
* `1100 Hz` → Bit `1`

**Key Parameters:**

* Sampling frequency: `100 kHz`
* Bit duration: `4 ms`
* Samples per bit: `400`

**Detector Outputs:**

* Detected bit (`0` or `1`)
* Energy at both BFSK frequencies
* Decision validity flag for synchronization

The detector operates in a **sample-by-sample manner**, making it suitable for real-time underwater communication systems.

---

## Simulation Tools

* **MATLAB**
* **Simulink**

---

## Results

Simulation results demonstrate reliable data transmission under underwater channel conditions:

* Transmitted and received bitstreams closely match under optimal synchronization
* Minimum BER of approximately **3.5%** achieved at zero delay
* BER increases with delay and noise, as expected
* Waveform and frequency-domain analysis validate correct BFSK demodulation

These results confirm the robustness of BFSK modulation combined with Goertzel-based detection for underwater acoustic communication.

---

## Applications

* Underwater sensor networks
* Oceanographic data transmission
* Marine monitoring systems
* Defense and submarine communications
* Low-data-rate underwater telemetry

