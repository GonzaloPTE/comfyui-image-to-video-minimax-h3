# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# 1. Update ComfyUI to latest master
RUN git -C /comfyui fetch origin master && \
    git -C /comfyui reset --hard origin/master

# 2. Install all latest ComfyUI dependencies into /opt/venv with CUDA PyTorch index
RUN /opt/venv/bin/pip install --no-cache-dir --extra-index-url https://download.pytorch.org/whl/cu124 -r /comfyui/requirements.txt

# 3. Configure PyTorch memory management
ENV PYTORCH_CUDA_ALLOC_CONF=expandable_segments:True

# 4. Install MiniMax-H3 Turbo custom node
RUN git clone https://github.com/Larryvrh/ComfyUI-MiniMax-H3-Turbo /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo && \
    if [ -f /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo/requirements.txt ]; then /opt/venv/bin/pip install --no-cache-dir -r /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo/requirements.txt; fi

# 3. Configure ComfyUI to read models from Network Volume (/runpod-volume)
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml


