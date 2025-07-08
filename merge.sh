#!/bin/bash


apapters=/root/data/swift_output/InternLM2.5-1.8B-Lora/$1
output_dir=/root/data/merge_output/$2

# 打印参数
echo "=== Adapters to merge: $apapters; Output directory: $output_dir  ==="

# 检查参数是否提供
if [ -z "$apapters" ] || [ -z "$output_dir" ]; then
    echo "Usage: $0 <adapters> <output_dir>"
    exit 1
fi


swift export \
    --adapters $apapters \
    --merge_lora true \
    --output_dir $output_dir

exit 0