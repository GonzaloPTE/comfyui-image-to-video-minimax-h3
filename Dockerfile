# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# 1. Update ComfyUI to latest master
RUN git -C /comfyui fetch origin master && \
    git -C /comfyui reset --hard origin/master

# 2. Install comfy-aimdo in the worker virtualenv without touching CUDA PyTorch
RUN /opt/venv/bin/pip install --no-cache-dir comfy-aimdo

# 3. Patch start.sh with --disable-mmap for reliable Network Volume tensor loading
RUN sed -i 's|/comfyui/main.py|/comfyui/main.py --disable-mmap|g' /start.sh

# 4. Install MiniMax-H3 Turbo custom node
RUN git clone https://github.com/Larryvrh/ComfyUI-MiniMax-H3-Turbo /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo && \
    if [ -f /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo/requirements.txt ]; then /opt/venv/bin/pip install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo/requirements.txt; fi

# 3. Configure ComfyUI to read models from Network Volume (/runpod-volume)
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml


