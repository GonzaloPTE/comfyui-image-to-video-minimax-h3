# MiniMax H3 Turbo Workflows (Image-to-Video & Reference-to-Video)

Optimized ComfyUI workflows for **MiniMax H3** with [MiniMax-H3 Turbo LoRA](https://huggingface.co/larryvrh/MiniMax-H3-Turbo-Lora) by Larryvrh and [ComfyUI-MiniMax-H3-Turbo](https://github.com/Larryvrh/ComfyUI-MiniMax-H3-Turbo).

- **Sampling Steps:** Reduced from 20 to 6 steps (~3.3x speedup).
- **LoRA Checkpoint:** `minimax_h3_turbo_v4_step600_ema.safetensors`
- **Output:** Native high-quality video with synchronized stereo audio.

## Workflows Included
1. **Reference to Video (R2V) [Recommended]:**
   - File: `api-workflow-r2v.json` / `workflow-r2v.json`
   - Node: `MiniMaxH3ReferenceToVideo`
   - UNET: `minimax_h3_ref2va_pruned_int8_convrot.safetensors`
   - Features: Uses 1 or 2 reference images for persistent character/subject consistency without locking the starting frame.

2. **Image to Video (FL2VA / First-Last Frame):**
   - File: `api-workflow.json` / `workflow.json`
   - Node: `MiniMaxH3ImageToVideo`
   - UNET: `minimax_h3_fl2va_pruned_int8_convrot.safetensors`

## Deploy on RunPod Serverless
1. Connect this repository at https://runpod.io/console/serverless
2. Create or edit an endpoint, selecting **Deploy from GitHub**
3. Pick this repository, branch `master`
4. Attach your RunPod Network Volume with models mounted at `/runpod-volume`
5. Send jobs via API with `api-workflow-r2v.json` or `api-workflow.json`

## Files
- `Dockerfile` — installs `ComfyUI-MiniMax-H3-Turbo` and configures Network Volume model mapping.
- `extra_model_paths.yaml` — maps ComfyUI model directories to `/runpod-volume/models/`.
- `download_to_volume.sh` — one-line setup script to populate the Network Volume from Hugging Face.
- `api-workflow-r2v.json` — Reference-to-Video Turbo API payload.
- `workflow-r2v.json` — Reference-to-Video visual graph.
- `api-workflow.json` — Image-to-Video (First/Last frame) Turbo API payload.
- `workflow.json` — Image-to-Video visual graph.
- `README.md` — documentation.
