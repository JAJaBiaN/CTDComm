#!/bin/bash
# Usage (for iridis/slurm):
# sbatch train_pp_hard_commnet.sh [seed=0]
#
# Optional config arguments:
#     Communication: --comm_action_one --comm_mask_zero
#     Algorithms: --commnet, --ic3net, --tarcomm --ic3net (TarMAC), --gacomm

#SBATCH --ntasks=8      # Number of tasks
#SBATCH --nodes=1       # Number of nodes
#SBATCH --cpus-per-task=1
#SBATCH --time=60:00:00 # Walltime (maximum is 60 hours for batch)

# Specific setup for my cluster and virtual environment
source activate marl37

export OMP_NUM_THREADS=1

if [ $# -eq 1 ]; then
  seed=$1
else
  seed=1
fi

printf -v date '%(%Y-%m-%d_%H:%M:%S)T' -1

python -u run_baselines.py \
  --env_name predator_prey \
  --nagents 10 \
  --dim 20 \
  --max_steps 80 \
  --vision 1 \
  --nprocesses 16 \
  --num_epochs 500 \
  --epoch_size 10 \
  --hid_size 128 \
  --value_coeff 0.015 \
  --detach_gap 10 \
  --lrate 0.0003 \
  --magic \
  --recurrent \
  --directed \
  --gat_num_heads 4 \
  --gat_hid_size 32 \
  --gat_num_heads_out 1 \
  --use_gat_encoder \
  --gat_encoder_out_size 32 \
  --self_loop_type1 2 \
  --self_loop_type2 2 \
  --first_gat_normalize \
  --second_gat_normalize \
  --message_decoder \
  --save \
  --save_adjacency \
  --save_every 25 \
  --seed $seed \
  # --load "/home/jabn1n20/CTDComm/saved/predator_prey_hard/magic/run"$seed"/model_ep900.pt"

# --num_epochs 1000

# Changed cf pp med
#  --value_coeff 0.01 \
#  --lrate 0.001 \

# Added cf pp med
#  --ge_num_heads 8 \
#  --learn_second_graph \

# Removed cf pp med
#  --message_decoder \