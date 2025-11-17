# 🛰️ Azure Geospatial Workshop

Welcome! This repository contains all the materials, notebooks, and instructions for the hands-on Azure Geospatial Analysis workshop.

## Workshop Structure

### [Lab 1: Vegetation Analysis](./lab1)
* **Topic:** Calculating NDVI using Sentinel-2 imagery.
* **Tools:** Azure ML, GeoPandas, Planetary Computer.
* **Status:** ✅ Ready

### [Lab 2: Geospatial AI for Flood Mapping](./lab2)
* **Description:** Learn to use a quantized geospatial foundation model (Prithvi-EO-1.0) to perform flood segmentation. This lab runs entirely on a CPU using AI inference.
* **Tools:** Azure ML, PyTorch, TerraTorch, Hugging Face, Planetary Computer.
* **Status:** ✅ **Ready**

---

## 🚀 Getting Started: Workshop Setup

Follow these instructions to set up your environment in Azure Machine Learning.

### Prerequisites

Before you begin, please ensure you have the following:

1.  An active **Azure Subscription**. (A free trial account will work).
2.  An **Azure Machine Learning Workspace** created in your subscription.
3.  A **Compute Instance** provisioned and **Running** inside your Azure ML workspace.

> **Note:** For detailed, step-by-step instructions on setting up these prerequisites, please see the [**Vegetation Analysis Lab - Guide.docx**](./lab1/Lab%201%20-%20Instructions.docx) file located in the `lab1` folder.

---

## 💻 Environment Setup Instructions

You will run these commands in the Azure ML Terminal to download the lab files and build the correct Python environment.

### 1. Open the Azure ML Terminal

1.  Navigate to your **Azure ML Studio** (ml.azure.com).
2.  On the left-hand menu, click **Compute**.
3.  Find your running Compute Instance and click **Terminal**.

### 2. Clone the Workshop Repository

Run the following command in the terminal. This will download the entire `geospatial-workshop-labs` folder (containing `lab1` and `lab2`) into your user directory.

```bash
git clone https://github.com/eeshu-raaj-saasthaa/geospatial-workshop-labs.git
```
