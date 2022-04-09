#!/bin/bash
#SBATCH --job-name example_run_python_job
#SBATCH --partition=p100_normal_q
#SBATCH --nodes=1
#SBATCH --gres=gpu:2
#SBATCH --ntasks 4
#SBATCH --cpus-per-task 4
#SBATCH --time=12:00:00
#SBATCH --account="bigdata"
#SBATCH --mail-user=$USER
#SBATCH --mail-type=BEGIN,END,FAIL

# Choose Anaconda environment name string.
CONDA_ENV_NAME="tf-p100"

# Load modules.
echo "Loading modules"
module reset
module load Anaconda3/2020.11

# Run python command using Anaconda enviroment.
conda run -n ${CONDA_ENV_NAME} python -c "import tensorflow as tf; print(tf.config.list_physical_devices('GPU'))"