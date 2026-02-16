#!/usr/bin/env bash
set -e

# ⚠️ Remplace par ton token HF
HF_TOKEN="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"

BASE="/content/ComfyUI/models"

echo "📁 Création des dossiers..."
mkdir -p $BASE/diffusion_models
mkdir -p $BASE/loras
mkdir -p $BASE/text_encoders
mkdir -p $BASE/clip_vision
mkdir -p $BASE/vae

download () {
    URL=$1
    DEST=$2
    echo "📥 $(basename $DEST)"
    wget --header="Authorization: Bearer $HF_TOKEN" -c "$URL" -O "$DEST"
}

echo "📥 Diffusion models"
download "https://huggingface.co/Kijai/WanVideo_comfy_fp8_scaled/resolve/main/Wan22Animate/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors" \
  "$BASE/diffusion_models/Wan2_2-Animate-14B_fp8_e4m3fn_scaled_KJ.safetensors"

download "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/diffusion_models/wan2.2_animate_14B_bf16.safetensors" \
  "$BASE/diffusion_models/wan2.2_animate_14B_bf16.safetensors"

echo "📥 CLIP Vision"
download "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/clip_vision/clip_vision_h.safetensors" \
  "$BASE/clip_vision/clip_vision_h.safetensors"

echo "📥 LoRAs"
download "https://huggingface.co/Kijai/WanVideo_comfy/resolve/main/LoRAs/Wan22_relight/WanAnimate_relight_lora_fp16.safetensors" \
  "$BASE/loras/WanAnimate_relight_lora_fp16.safetensors"

echo "📥 Text encoder"
download "https://huggingface.co/Comfy-Org/Wan_2.1_ComfyUI_repackaged/resolve/main/split_files/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors" \
  "$BASE/text_encoders/umt5_xxl_fp8_e4m3fn_scaled.safetensors"

echo "📥 VAE"
download "https://huggingface.co/Comfy-Org/Wan_2.2_ComfyUI_Repackaged/resolve/main/split_files/vae/wan_2.1_vae.safetensors" \
  "$BASE/vae/wan_2.1_vae.safetensors"

echo "✅ Tous les modèles WAN 2.2 Animate sont installés."
