#!/bin/bash
# Usage (for iridis/slurm):
# Optional arguments:
#     Communication: --comm_action_one --comm_mask_zero
#     Algorithms: --commnet, --ic3net, --tarcomm --ic3net (TarMAC), --gacomm
# sbatch run_tj_easy_iridis.sh

#SBATCH --ntasks=1      # Number of tasks
#SBATCH --nodes=1       # Number of nodes
#SBATCH --cpus-per-task=1
#SBATCH --time=60:00:00 # Walltime (maximum is 60 hours for batch) Hopefully we can reduce this!

# Specific setup for my cluster and virtual environment
source activate marl37

export OMP_NUM_THREADS=1

printf -v date '%(%Y-%m-%d_%H:%M)T' -1

python -u run_baselines.py \
  --env_name traffic_junction \
  --nagents 5 \
  --dim 6 \
  --max_steps 20 \
  --add_rate_min 0.3 \
  --add_rate_max 0.3 \
  --difficulty easy \
  --vision 1 \
  --nprocesses 16 \
  --num_epochs 2000 \
  --epoch_size 10 \
  --hid_size 128 \
  --detach_gap 10 \
  --lrate 0.001 \
  --value_coeff 0.01 \
  --gacomm \
  --recurrent \
  --curr_start 0 \
  --curr_end 0 \
  --save \
  --seed 0 \
  | tee train_tj_easy_$date.log # Move to currect dir after the run.