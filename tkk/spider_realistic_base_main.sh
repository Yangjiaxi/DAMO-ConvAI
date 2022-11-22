#!/bin/sh

CHECKPOINT_PATH=$1

CUDA_VISIBLE_DEVICES=0 \
python -m torch.distributed.launch --nproc_per_node 1 --master_port 9980 train.py \
  --seed 82 \
  --cfg CFG/T5_base_spider_realistic_main.cfg \
  --run_name T5_base_finetune_spider_realistic/main/1 \
  --prompt_initialization True \
  --load_weights_from $CHECKPOINT_PATH \
  --report_to wandb \
  --logging_strategy steps \
  --logging_first_step True \
  --logging_steps 4 \
  --evaluation_strategy steps \
  --eval_steps 500 \
  --metric_for_best_model avr \
  --greater_is_better True \
  --save_strategy steps \
  --save_steps 500 \
  --save_total_limit 1 \
  --load_best_model_at_end \
  --gradient_accumulation_steps 1 \
  --num_train_epochs 50 \
  --adafactor True \
  --learning_rate 1e-4 \
  --do_eval \
  --predict_with_generate \
  --output_dir output/T5_base_finetune_spider_realistic/main/1 \
  --overwrite_output_dir \
  --per_device_train_batch_size 32 \
  --per_device_eval_batch_size 128 \
  --generation_num_beams 2 \
  --generation_max_length 128 \
  --input_max_length 512 \
  --ddp_find_unused_parameters False
