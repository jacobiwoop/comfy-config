#!/bin/bash

set -e

BASE_DIR="/content"
COMFY_DIR="$BASE_DIR/ComfyUI"

echo "=== Installation ComfyUI propre ==="

# 1) Nettoyage
rm -rf $COMFY_DIR

# 2) Clone ComfyUI
git clone https://github.com/Comfy-Org/ComfyUI.git $COMFY_DIR
cd $COMFY_DIR

# 3) Installer dépendances Python
pip install --upgrade pip
pip install -r requirements.txt

# 4) Installer ComfyUI-Manager
cd $COMFY_DIR/custom_nodes
git clone https://github.com/Comfy-Org/ComfyUI-Manager.git

# 5) Installer custom nodes utiles
git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git
git clone https://github.com/kijai/ComfyUI-KJNodes.git

# 6) Installer requirements des nodes
for d in */ ; do
  if [ -f "$d/requirements.txt" ]; then
    echo "Installing requirements for $d"
    pip install -r "$d/requirements.txt" || true
  fi
done

cd $COMFY_DIR

echo "=== Détection GPU ==="

python - <<EOF
import torch
if torch.cuda.is_available():
    print("GPU_DETECTED")
else:
    print("CPU_ONLY")
EOF
