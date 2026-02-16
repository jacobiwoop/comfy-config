#!/bin/bash

cd /content/ComfyUI

GPU=$(python - <<EOF
import torch
print("1" if torch.cuda.is_available() else "0")
EOF
)

if [ "$GPU" = "1" ]; then
    echo "GPU détecté → lancement normal"
    python main.py
else
    echo "Mode CPU"
    export CUDA_VISIBLE_DEVICES=""
    python main.py --cpu
fi
