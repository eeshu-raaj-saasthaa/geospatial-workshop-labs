#!/bin/bash

set -e  # Exit immediately if a command exits with a non-zero status

ENV_NAME="geo-labs-lab2"
LOGFILE="$HOME/env_setup.log"

# Cleanup log on exit if success
trap 'cleanup' EXIT INT TERM

cleanup() {
    local exit_code=$?
    if [ $exit_code -eq 0 ]; then
        echo "Cleaning up log file..."
        rm -f "$LOGFILE"
    else
        echo ""
        echo "Setup failed. Log preserved at: $LOGFILE"
    fi
}

echo "──────────────────────────────────────────────────────"
echo "🚀 Environment Setup: $ENV_NAME"
echo "──────────────────────────────────────────────────────"
echo "Logs: $LOGFILE"
echo ""

# Test log file writing
echo "Script started at $(date)" > "$LOGFILE"
if [ ! -f "$LOGFILE" ]; then
    echo "ERROR: Cannot create log file at $LOGFILE"
    exit 1
fi

#########################################
# HELPER: Stream logs with progress bar
#########################################

run_with_progress() {
    local message=$1
    shift
    
    echo "$message"
    echo "DEBUG: Running command: $@" >> "$LOGFILE"
    
    local start_time=$(date +%s)
    local bar_width=30
    local last_output_time=$start_time
    
    # Run command in background and capture PID immediately
    "$@" >> "$LOGFILE" 2>&1 &
    local pid=$!
    
    echo "DEBUG: Started process with PID: $pid" >> "$LOGFILE"
    
    # Verify process started
    if ! kill -0 $pid 2>/dev/null; then
        echo "      ✗ Process failed to start"
        echo "DEBUG: Process $pid not found immediately after launch" >> "$LOGFILE"
        exit 1
    fi
    
    # Show progress bar while running
    local counter=0
    while kill -0 $pid 2>/dev/null; do
        local elapsed=$(($(date +%s) - start_time))
        local current_time=$(date +%s)
        
        # Force output every 30 seconds to prevent SSH timeout
        if [ $((current_time - last_output_time)) -ge 30 ]; then
            echo "DEBUG: Still running at ${elapsed}s" >> "$LOGFILE"
            last_output_time=$current_time
        fi
        
        local filled=$((counter % (bar_width + 1)))
        local empty=$((bar_width - filled))
        
        # Build progress bar
        local bar="["
        for ((i=0; i<filled; i++)); do bar+="█"; done
        for ((i=0; i<empty; i++)); do bar+="░"; done
        bar+="]"
        
        printf "\r      %s %ds" "$bar" "$elapsed"
        
        counter=$((counter + 1))
        sleep 0.15
    done
    
    # Check exit status
    wait $pid
    local exit_code=$?
    
    local elapsed=$(($(date +%s) - start_time))
    
    echo "DEBUG: Process completed with exit code: $exit_code" >> "$LOGFILE"
    
    if [ $exit_code -eq 0 ]; then
        # Full bar on success
        local full_bar="["
        for ((i=0; i<bar_width; i++)); do full_bar+="█"; done
        full_bar+="]"
        printf "\r      %s ✓ %ds\n" "$full_bar" "$elapsed"
    else
        printf "\r      [ERROR] ✗ %ds\n" "$elapsed"
        echo ""
        echo "ERROR: Command failed. Last 20 lines:"
        echo "──────────────────────────────────────────────────────"
        tail -n 20 "$LOGFILE"
        echo "──────────────────────────────────────────────────────"
        exit 1
    fi
    echo ""
}

#########################################
# CHECK: Is mamba/conda available?
#########################################

echo "[1/6] Checking conda/mamba installation..."

if command -v mamba &> /dev/null; then
    CONDA_CMD="mamba"
    echo "      → mamba found"
elif command -v conda &> /dev/null; then
    CONDA_CMD="conda"
    echo "      → conda found"
    echo "      → installing mamba for faster resolution..."
    
    # Install mamba in base environment
    if conda install -n base mamba -y -q >> "$LOGFILE" 2>&1; then
        CONDA_CMD="mamba"
        echo "      → mamba installed ✓"
    else
        echo "      → mamba install failed, using conda"
    fi
else
    echo "      ✗ Neither mamba nor conda found"
    echo "      Please install miniforge or miniconda"
    exit 1
fi
echo ""

#########################################
# 1) CLEANUP EXISTING ENVIRONMENT
#########################################

echo "[2/7] Checking for existing environment..."

if conda env list | grep -q "^${ENV_NAME} "; then
    echo "      → environment '$ENV_NAME' already exists"
    echo "      → removing old environment..."
    conda env remove -n "$ENV_NAME" -y 2>&1 | tee -a "$LOGFILE"
    
    # Wait a moment for cleanup
    sleep 2
    
    # Verify removal
    if conda env list | grep -q "^${ENV_NAME} "; then
        echo "      ✗ Failed to remove old environment"
        exit 1
    fi
    
    echo "      ✓ Old environment removed"
else
    echo "      → no existing environment found"
fi
echo ""

#########################################
# 2) CLEANUP AND PREPARE
#########################################

echo "[3/7] Preparing environment..."
run_with_progress "      → cleaning package cache..." $CONDA_CMD clean --all -y -q

if [ "$CONDA_CMD" = "mamba" ]; then
    run_with_progress "      → updating mamba..." $CONDA_CMD update -n base mamba -y -q
fi
echo ""

#########################################
# 3) CREATE CONDA ENV
#########################################

echo "[4/7] Creating base environment..."
run_with_progress "      → creating $ENV_NAME with Python 3.10..." \
    $CONDA_CMD create -n "$ENV_NAME" python=3.10 -y
echo ""

#########################################
# 4) INSTALL CONDA PACKAGES
#########################################

echo "[5/7] Installing geospatial packages..."

# Get the environment path directly
ENV_PATH=$(conda env list | grep "^${ENV_NAME} " | awk '{print $NF}')

if [ -z "$ENV_PATH" ]; then
    echo "      ✗ Environment path not found"
    exit 1
fi

echo "      → environment path: $ENV_PATH"

# Install directly to the environment without activation
run_with_progress "      → installing gdal, rasterio, geopandas..." \
    $CONDA_CMD install -n "$ENV_NAME" gdal rasterio geopandas shapely ipykernel pip -y
echo ""

#########################################
# 5) INSTALL PIP PACKAGES
#########################################

echo "[6/7] Installing Python packages..."

# Use the environment's pip directly
ENV_PATH=$(conda env list | grep "^${ENV_NAME} " | awk '{print $NF}')
PIP_PATH="$ENV_PATH/bin/pip"

# Right after creating the environment, before other packages
run_with_progress "      → downgrading numpy for compatibility..." \
    "$PIP_PATH" install "numpy<2" --force-reinstall

# Batch 1: Core packages (without terratorch)
pip_packages=(
    "requests>=2.31"
    leafmap
    localtileserver
    "large-image>=1.33.3"
    "large-image-source-rasterio>=1.33.3"
    pystac-client
    planetary-computer
    openmim
    timm
    huggingface_hub
)

run_with_progress "      → installing core packages..." \
    "$PIP_PATH" install --upgrade --no-cache-dir "${pip_packages[@]}" --no-input

# Batch 2: Terratorch dependencies
terratorch_deps=(
    ftfy
    regex
    einops
    "albumentations>=1.4.0"
    "segmentation-models-pytorch>=0.3.0"
    "kornia>=0.7.0"
)

run_with_progress "      → installing terratorch dependencies..." \
    "$PIP_PATH" install --upgrade --no-cache-dir "${terratorch_deps[@]}" --no-input

# Batch 3: PyTorch CPU-only (specific version for mmcv compatibility)
run_with_progress "      → installing PyTorch 2.1.0 (CPU-only)..." \
    "$PIP_PATH" install --upgrade \
        torch==2.1.0 torchvision==0.16.0 torchaudio==2.1.0 \
        --index-url https://download.pytorch.org/whl/cpu

# Batch 4: AI libraries (mmcv CPU-only for torch 2.1)
run_with_progress "      → installing mmcv (CPU-only build)..." \
    "$PIP_PATH" install --no-cache-dir \
        mmcv==2.1.0 \
        -f https://download.openmmlab.com/mmcv/dist/cpu/torch2.1/index.html

run_with_progress "      → installing mmsegmentation..." \
    "$PIP_PATH" install --upgrade --no-cache-dir mmsegmentation==1.2.2 --no-input

# Batch 5: Terratorch (LAST - after all dependencies)
run_with_progress "      → installing terratorch..." \
    "$PIP_PATH" install --upgrade --no-cache-dir terratorch --no-input

echo ""

#########################################
# 6) INSTALL JUPYTER KERNEL
#########################################

echo "[7/7] Configuring Jupyter kernel..."

# Use the environment's python directly
ENV_PATH=$(conda env list | grep "^${ENV_NAME} " | awk '{print $NF}')
PYTHON_PATH="$ENV_PATH/bin/python"

run_with_progress "      → registering kernel..." \
    "$PYTHON_PATH" -m ipykernel install --user --name "$ENV_NAME" --display-name "Python ($ENV_NAME)"
echo ""

#########################################
# 8) TEST IMPORTS
#########################################

echo "[8/8] Testing package imports..."

# Test critical imports
TEST_SCRIPT="
import sys
print('Testing imports...')

try:
    from osgeo import gdal
    print('  ✓ gdal')
except ImportError as e:
    print(f'  ✗ gdal: {e}')
    sys.exit(1)

try:
    import rasterio
    print('  ✓ rasterio')
except ImportError as e:
    print(f'  ✗ rasterio: {e}')
    sys.exit(1)

try:
    import geopandas
    print('  ✓ geopandas')
except ImportError as e:
    print(f'  ✗ geopandas: {e}')
    sys.exit(1)

try:
    import mmcv
    print(f'  ✓ mmcv (version: {mmcv.__version__})')
except ImportError as e:
    print(f'  ✗ mmcv: {e}')
    sys.exit(1)

try:
    import mmseg
    print(f'  ✓ mmseg (version: {mmseg.__version__})')
except ImportError as e:
    print(f'  ✗ mmseg: {e}')
    sys.exit(1)

try:
    import terratorch
    print('  ✓ terratorch')
except ImportError as e:
    print(f'  ✗ terratorch: {e}')
    sys.exit(1)

print('All critical packages imported successfully!')
"

echo "$TEST_SCRIPT" | "$PYTHON_PATH" 2>&1 | tee -a "$LOGFILE"

if [ ${PIPESTATUS[1]} -ne 0 ]; then
    echo ""
    echo "✗ Import test failed!"
    echo "Check logs: $LOGFILE"
    exit 1
fi

echo ""

echo "──────────────────────────────────────────────────────"
echo "✓ Setup complete - Environment ready to use!"
echo "──────────────────────────────────────────────────────"
echo ""
echo "The environment '$ENV_NAME' is fully configured."
echo "All packages have been installed and tested."
echo ""
echo "To use in Jupyter:"
echo "  1. Open your Jupyter notebook"
echo "  2. Click 'Kernel' → 'Change Kernel'"
echo "  3. Select 'Python ($ENV_NAME)'"
echo ""
echo "To use in terminal:"
echo "  conda activate $ENV_NAME"
echo ""
echo "Logs saved: $LOGFILE"