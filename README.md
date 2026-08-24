# Image to Video MiniMax H3 Turbo (LoRA)

Optimized ComfyUI workflow for **MiniMax H3 Image-to-Video** with [MiniMax-H3 Turbo LoRA](https://huggingface.co/larryvrh/MiniMax-H3-Turbo-Lora) by Larryvrh and [ComfyUI-MiniMax-H3-Turbo](https://github.com/Larryvrh/ComfyUI-MiniMax-H3-Turbo).

- **Sampling Steps:** Reduced from 20 to 6 steps (~3.3x speedup).
- **LoRA Checkpoint:** `minimax_h3_turbo_v4_step600_ema.safetensors`
- **Output:** Native high-quality video with synchronized stereo audio.

## Build it yourself
```bash
docker build -t minimax-h3-turbo-workflow .
docker run --rm --gpus all -p 8188:8188 minimax-h3-turbo-workflow
```

## Deploy on RunPod Serverless
1. Connect this repository at https://runpod.io/console/serverless
2. Create or edit an endpoint, selecting **Deploy from GitHub**
3. Pick this repository, branch `master`
4. RunPod's builder will build the Dockerfile and deploy the resulting worker
5. Send jobs via API with `api-workflow.json`

## Files
- `Dockerfile` — installs `ComfyUI-MiniMax-H3-Turbo`, base models, and Turbo LoRA weights.
- `api-workflow.json` — flattened, API-ready ComfyUI `/prompt` payload with 6-step Turbo sampler.
- `workflow.json` — raw visual workflow representation.
- `README.md` — documentation.