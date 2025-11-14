# Lab 1: Foundational Geospatial Analysis (Vegetation) with Azure & JupyterLab

This lab provides a hands-on introduction to geospatial data analysis using modern cloud-backed workflows, focusing on how to prepare, manipulate, and visualize spatial datasets within a cloud-hosted JupyterLab compute instance on Azure. You will gain direct experience in environment setup via the terminal, including conda environment management, running analytical notebooks, and working interactively with key Python geospatial libraries. By the end of this lab, you will have executed foundational geospatial pipelines, leveraged cloud computing efficiency, and developed practical skills directly transferable to real-world spatial data projects.

---

## Estimated Time to Complete

- **Total Duration:** ~1 hour
  - **Azure Setup & JupyterLab Launch:** 10–15 minutes
  - **Notebook Execution and Exercises:** 45–50 minutes

---

## Setup Requirements

- **Azure for Students Free Credits:**  
  Register for [Azure for Students](https://aka.ms/azure4students) and confirm activation of your complimentary credits (usually $100 for 12 months). No card required.

- **Required Hardware & Software:**
  - Laptop or desktop with a modern web browser (Chrome, Edge, Firefox, Safari).
  - Stable internet connection.
  - No local installations needed: all activities run on the Azure-hosted JupyterLab compute instance.

- **JupyterLab Environment:**
  - All exercises occur within one cloud compute instance.
  - Terminal access will be used to create and activate the necessary conda environment using the provided `azureml_environment.yml`.
  - Hands-on steps for working with the environment are included in the main notebook.

---

## Lab Workflow

1. **Set up your Azure and JupyterLab environment**
2. **Create & activate a custom conda environment using the terminal (`azureml_environment.yml`)**
3. **Ingest and inspect geospatial datasets**
4. **Execute Python-based analytic workflows in the Jupyter notebook**
5. **Visualize spatial data and interpret geospatial results**

---

## Support & Troubleshooting

- For technical issues with Azure credits, consult the [Azure Students FAQ](https://azure.microsoft.com/en-us/free/students-faq/).
- Reach out to the workshop instructional team or dedicated support channel during the session for help.

---

## Attribution

This lab is part of the [Geospatial Workshop Labs](https://github.com/eeshu-raaj-saasthaa/geospatial-workshop-labs). Adaptation or redistribution for instruction or research is welcome with appropriate credit.

---
## Setting up the lab notebook in Azure ML
### 1. Navigate to the Lab 1 Folder

Once the download is complete, change into the `lab1` directory using this command:

**Bash**
```bash
cd geospatial-workshop-labs/lab1
```
### 2. Create the Conda Environment
The `lab1` folder contains an `azureml_environment.yml` file. Use it to create the Python environment with all the necessary geospatial packages.

This step is crucial and will take 5-10 minutes to complete.

**Bash**
```bash
conda env create -f azureml_environment.yml
```
### 3. Start the Lab!

After the environment is created, go to the **Notebooks** tab in Azure ML Studio.

1.  Navigate into `geospatial-workshop-labs` > `lab1`.
2.  Open the `Lab_1_GeoSpatial_Analysis.ipynb` notebook.
3.  In the top-right corner, click the kernel name and select the new environment you just created (it will be named `geo-labs-azureml`).

You are now ready to begin the lab!
