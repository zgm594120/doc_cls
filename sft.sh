#!/bin/bash

# 创建日志目录
LOG_DIR="logs"
mkdir -p $LOG_DIR

# 获取当前时间戳
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
LOG_FILE="$LOG_DIR/internlm2.5-1.8b_lora_sft_${TIMESTAMP}.log"
data_path=$1

# 设置CUDA设备
export NPROC_PER_NODE=1
export OMP_NUM_THREADS=1
export CUDA_VISIBLE_DEVICES=0

nohup swift sft \
    --model /root/public-model/models/Shanghai_AI_Laboratory/internlm2_5-1_8b-chat \
    --train_type lora \
    --dataset $1 \
    --torch_dtype bfloat16 \
    --num_train_epochs 1 \
    --per_device_train_batch_size 4 \
    --learning_rate 5e-5 \
    --warmup_ratio 0.1 \
    --split_dataset_ratio 0 \
    --lora_rank 8 \
    --lora_alpha 32 \
    --target_modules all-linear \
    --gradient_accumulation_steps 2 \
    --save_steps 2000 \
    --save_total_limit 5 \
    --gradient_checkpointing_kwargs '{"use_reentrant": false}' \
    --logging_steps 5 \
    --max_length 2048 \
    --output_dir ./swift_output/InternLM2.5-1.8B-Lora \
    --dataloader_num_workers 256 \
    --model_author JimmyMa99 \
    --model_name InternLM2.5-1.8B-Lora \
    > "$LOG_FILE" 2>&1 &

# 打印进程ID和日志文件位置
echo "Training started with PID $!"
echo "Log file: $LOG_FILE"

# 显示查看日志的命令
echo "To view logs in real-time, use:"
echo "tail -f $LOG_FILE"