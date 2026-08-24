#!/bin/bash
# ==============================================================================
# Script de descarga rápida para Network Volume en RunPod
# Ejecutar en la terminal de un Pod temporal conectado al Network Volume
# (El volumen se monta en /workspace en Pods y en /runpod-volume en Serverless)
# ==============================================================================

set -e

echo "=== 1. Creando estructura de directorios en el volumen ==="
mkdir -p /workspace/models/diffusion_models \
         /workspace/models/text_encoders \
         /workspace/models/vae \
         /workspace/models/loras

# Detectar herramienta de descarga rápida
if command -v aria2c &> /dev/null; then
    DL_CMD="aria2c -x 16 -s 16 -k 1M -c"
else
    DL_CMD="wget -c"
fi

echo "=== 2. Descargando UNET (19.53 GB) ==="
$DL_CMD "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors" \
    -o /workspace/models/diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors \
    || wget -c "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors" \
    -O /workspace/models/diffusion_models/minimax_h3_fl2va_pruned_int8_convrot.safetensors

echo "=== 3. Descargando Text Encoder / LLM (14.61 GB) ==="
$DL_CMD "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/text_encoders/qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors" \
    -o /workspace/models/text_encoders/qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors \
    || wget -c "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/text_encoders/qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors" \
    -O /workspace/models/text_encoders/qwen3vl_32b_minimax_h3_nvfp4_awq.safetensors

echo "=== 4. Descargando Video VAE (4.85 GB) ==="
$DL_CMD "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/vae/minimax_h3_video_vae_fp16.safetensors" \
    -o /workspace/models/vae/minimax_h3_video_vae_fp16.safetensors \
    || wget -c "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/vae/minimax_h3_video_vae_fp16.safetensors" \
    -O /workspace/models/vae/minimax_h3_video_vae_fp16.safetensors

echo "=== 5. Descargando Audio VAE (0.56 GB) ==="
$DL_CMD "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/vae/minimax_h3_audio_vae_fp32.safetensors" \
    -o /workspace/models/vae/minimax_h3_audio_vae_fp32.safetensors \
    || wget -c "https://huggingface.co/Comfy-Org/MiniMax-H3/resolve/main/vae/minimax_h3_audio_vae_fp32.safetensors" \
    -O /workspace/models/vae/minimax_h3_audio_vae_fp32.safetensors

echo "=== 6. Descargando MiniMax-H3 Turbo LoRA (0.73 GB) ==="
$DL_CMD "https://huggingface.co/larryvrh/MiniMax-H3-Turbo-Lora/resolve/main/minimax_h3_turbo_v4_step600_ema.safetensors" \
    -o /workspace/models/loras/minimax_h3_turbo_v4_step600_ema.safetensors \
    || wget -c "https://huggingface.co/larryvrh/MiniMax-H3-Turbo-Lora/resolve/main/minimax_h3_turbo_v4_step600_ema.safetensors" \
    -O /workspace/models/loras/minimax_h3_turbo_v4_step600_ema.safetensors

echo "=== ¡DESCARGA COMPLETA Y VERIFICADA! ==="
ls -lh /workspace/models/diffusion_models
ls -lh /workspace/models/text_encoders
ls -lh /workspace/models/vae
ls -lh /workspace/models/loras