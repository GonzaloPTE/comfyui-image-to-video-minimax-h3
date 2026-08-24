# clean base image containing only comfyui, comfy-cli and comfyui-manager
FROM runpod/worker-comfyui:5.8.4-base

# 1. Update ComfyUI to latest master (provides native MiniMaxH3ReferenceToVideo and new audio-video schedulers)
RUN git -C /comfyui fetch origin master && \
    git -C /comfyui reset --hard origin/master && \
    if [ -f /comfyui/requirements.txt ]; then pip install -r /comfyui/requirements.txt; fi

# 2. Install MiniMax-H3 Turbo custom node
RUN git clone https://github.com/Larryvrh/ComfyUI-MiniMax-H3-Turbo /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo && \
    if [ -f /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo/requirements.txt ]; then pip install -r /comfyui/custom_nodes/ComfyUI-MiniMax-H3-Turbo/requirements.txt; fi

# 3. Configure ComfyUI to read models from Network Volume (/runpod-volume)
COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml


