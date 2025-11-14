# 🛰️ Azure Geospatial Workshop

Welcome! This repository contains all the materials, notebooks, and instructions for the hands-on Azure Geospatial Analysis workshop.

## Workshop Structure

### [Lab 1: Vegetation Analysis](./lab1)
* **Topic:** Calculating NDVI using Sentinel-2 imagery.
* **Tools:** Azure ML, GeoPandas, Planetary Computer.
* **Status:** ✅ Ready
### [Lab 2: Advanced Analysis](./lab2)
* **Topic:** (TBD)
* **Status:** 🚧 Coming Soon

---

## 🚀 Getting Started: Workshop Setup

Follow these instructions to set up your environment in Azure Machine Learning.

### Prerequisites

Before you begin, please ensure you have the following:

1.  An active **Azure Subscription**. (A free trial account will work).
2.  An **Azure Machine Learning Workspace** created in your subscription.
3.  A **Compute Instance** provisioned and **Running** inside your Azure ML workspace.

> **Note:** For detailed, step-by-step instructions on setting up these prerequisites, please see the [**Vegetation Analysis Lab - Guide.docx**](./lab1/Vegetation%20Analysis%20Lab%20-%20Guide.docx) file located in the `lab1` folder.

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
git clone [https://github.com/eeshu-raaj-saasthaa/geospatial-workshop-labs.git](https://github.com/eeshu-raaj-saasthaa/geospatial-workshop-labs.git)

### 3. Navigate to the Lab 1 Folder

Once the download is complete, change into the `lab1` directory using this command:

**Bash**
```bash
cd geospatial-workshop-labs/lab1

### 4. Create the Conda Environment
The `lab1` folder contains an `azureml_environment.yml` file. Use it to create the Python environment with all the necessary geospatial packages.

This step is crucial and will take 5-10 minutes to complete.

**Bash**
```bash
conda env create -f azureml_environment.yml

### 5. Start the Lab!

After the environment is created, go to the **Notebooks** tab in Azure ML Studio.

1.  Navigate into `geospatial-workshop-labs` > `lab1`.
2.  Open the `Lab_1_GeoSpatial_Analysis.ipynb` notebook.
3.  In the top-right corner, click the kernel name and select the new environment you just created (it will be named `geo-labs-azureml`).

You are now ready to begin the lab!
