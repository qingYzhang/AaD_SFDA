#!/bin/bash

#SBATCH --job-name=AaD_job
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --output=test.out
#SBATCH --error=test.err
#SBATCH --cpus-per-task=2
#SBATCH --mem=80GB
#SBATCH --time=48:00:00
#SBATCH --gres=gpu
#SBATCH --partition=a100_1,a100_2,v100,rtx8000

# job info

# Singularity path
ext3_path=/scratch/$USER/overlay-25GB-500K.ext3
sif_path=/scratch/$USER/cuda11.4.2-cudnn8.2.4-devel-ubuntu20.04.3.sif

# start running
singularity exec --nv \
--overlay ${ext3_path}:ro \
${sif_path} /bin/bash -c "
source /ext3/env.sh
cd /scratch/qz2208/AaD_SFDA
python tar_adaptation.py
"
