# Lab 2 - Environment Setup

## Quick Start

This lab uses a custom Python environment with geospatial and AI libraries. Follow the steps below to set it up automatically.

### Prerequisites

- Access to Azure ML compute instance
- Terminal access

### Installation

**1. Clone the repository:**
```bash
git clone https://github.com/eeshu-raaj-saasthaa/geospatial-workshop-labs.git
cd geospatial-workshop-labs/lab2
```

**2. Run the setup script:**
```bash
bash setup_env.sh
```

**3. Wait for completion (approximately 4-5 minutes):**

The script will automatically:
- ✓ Check and install mamba (if needed)
- ✓ Create a new conda environment with Python 3.10
- ✓ Install geospatial packages (GDAL, Rasterio, GeoPandas)
- ✓ Install AI libraries (mmcv, mmsegmentation, terratorch)
- ✓ Configure Jupyter kernel
- ✓ Test all package imports

### Expected Output
```
──────────────────────────────────────────────────────
🚀 Environment Setup: geo-labs-lab2
──────────────────────────────────────────────────────
Logs: /tmp/env_setup_1234567890.log

[1/7] Checking conda/mamba installation...
      → mamba found

[2/7] Checking for existing environment...
      → no existing environment found

[3/7] Preparing environment...
      → cleaning package cache...
      [██████████████████████████████] ✓ 2s
      → updating mamba...
      [██████████████████████████████] ✓ 3s

[4/7] Creating base environment...
      → creating geo-labs-lab2 with Python 3.10...
      [██████████████████████████████] ✓ 6s

[5/7] Installing geospatial packages...
      → environment path: /anaconda/envs/geo-labs-lab2
      → installing gdal, rasterio, geopandas...
      [██████████████████████████████] ✓ 12s

[6/7] Installing Python packages...
      → installing pip packages...
      [██████████████████████████████] ✓ 205s
      → installing AI libraries (mmcv, mmsegmentation)...
      [██████████████████████████████] ✓ 14s

[7/7] Configuring Jupyter kernel...
      → registering kernel...
      [██████████████████████████████] ✓ 1s

[8/8] Testing package imports...
Testing imports...
  ✓ gdal
  ✓ rasterio
  ✓ geopandas
  ✓ mmcv (version: 2.1.0)
  ✓ mmseg (version: 1.2.2)
  ✓ terratorch
All critical packages imported successfully!

──────────────────────────────────────────────────────
✓ Setup complete - Environment ready to use!
──────────────────────────────────────────────────────

The environment 'geo-labs-lab2' is fully configured.
All packages have been installed and tested.

To use in Jupyter:
  1. Open your Jupyter notebook
  2. Click 'Kernel' → 'Change Kernel'
  3. Select 'Python (geo-labs-lab2)'

To use in terminal:
  conda activate geo-labs-lab2

Logs saved: /tmp/env_setup_1234567890.log
```

### Using the Environment in Jupyter

1. **Open your lab notebook** (e.g., `lab2_notebook.ipynb`)
2. **Change the kernel:**
   - Click on the kernel name in the top-right corner, OR
   - Go to: `Kernel` → `Change Kernel` → `Python (geo-labs-lab2)`
3. **Start coding!** All required packages are ready to use.

### Installed Packages

The environment includes:

**Geospatial Libraries:**
- GDAL - Geospatial Data Abstraction Library
- Rasterio - Raster data processing
- GeoPandas - Vector data processing
- Shapely - Geometric operations

**AI/ML Libraries:**
- mmcv 2.1.0 - Computer vision foundation
- mmsegmentation 1.2.2 - Semantic segmentation
- terratorch - Geospatial AI models
- timm - PyTorch image models
- huggingface_hub - Model repository access

**Additional Tools:**
- leafmap - Interactive mapping
- localtileserver - Local tile serving
- pystac-client - STAC API access
- planetary-computer - Microsoft Planetary Computer access

### Troubleshooting

**If the script fails:**

1. Check the logs:
```bash
   cat /tmp/env_setup_*.log
```

2. Remove the environment and try again:
```bash
   conda env remove -n geo-labs-lab2 -y
   bash setup_env.sh
```

**If imports fail in Jupyter:**

1. Make sure you selected the correct kernel: `Python (geo-labs-lab2)`
2. Restart the kernel: `Kernel` → `Restart Kernel`
3. If issues persist, check the environment in terminal:
```bash
   conda activate geo-labs-lab2
   python -c "import mmcv, mmseg; print(mmcv.__version__, mmseg.__version__)"
```

**Common Issues:**

- **"mamba: command not found"** - The script will install it automatically
- **"Environment already exists"** - The script will remove and recreate it
- **Terminal disconnects during setup** - Run the script in a persistent session:
```bash
  screen -S env_setup
  bash setup_env.sh
  # Detach with Ctrl+A, D
  # Reattach with: screen -r env_setup
```

### Manual Installation (Alternative)

If the automated script doesn't work, you can install manually:
```bash
# Create environment
conda create -n geo-labs-lab2 python=3.10 -y
conda activate geo-labs-lab2

# Install geospatial packages
conda install -c conda-forge gdal rasterio geopandas shapely -y

# Install Python packages
pip install requests leafmap localtileserver large-image \
    large-image-source-rasterio pystac-client planetary-computer \
    openmim terratorch timm huggingface_hub

# Install AI libraries
mim install mmcv==2.1.0 mmsegmentation==1.2.2

# Register Jupyter kernel
python -m ipykernel install --user --name geo-labs-lab2 \
    --display-name "Python (geo-labs-lab2)"
```

### Support

If you encounter issues not covered in troubleshooting:
1. Save your error logs
2. Note which step failed
3. Contact the course instructor with the log file

---

**Estimated Setup Time:** 4-5 minutes  
**Environment Name:** `geo-labs-lab2`  
**Python Version:** 3.10
