# Lab 2
## 🚀 Environment Setup Instructions

Follow the steps below to create and activate the lab environment.

---

### 1. Navigate to the Lab 2 Folder
Once the download is complete, change into the lab1 directory using this command:

bash```
cd geospatial-workshop-labs/lab2
```
---
### 🛠️ 2. Create the environment (with progress bar)

Open the **Terminal** in Azure ML and run:

```bash
# Remove any previous environment with the same name (avoids conflicts)
conda env remove -n geo-labs-lab2 -y 2>/dev/null || true

# Run the environment creation script
chmod +x create_env_with_progress.sh
./create_env_with_progress.sh
```

This will:
- Delete older broken environments (if any)
- Create the new `geo-labs-lab2` environment
- Show a live progress indicator ✔️

---

### 🧪 3. Activate the environment

Once the environment is created, activate it:

```bash
conda activate geo-labs-lab2
```

---

### 🎓 4. Register the Jupyter kernel

This step makes the environment appear in the Notebook Kernel menu.

```bash
python -m ipykernel install --user --name geo-labs-lab2 --display-name "Geo Labs Lab2"
```

After this step:
- Go to your notebook
- Select **Kernel → Change Kernel → Geo Labs Lab2**

You're ready to start the lab! 🚀
