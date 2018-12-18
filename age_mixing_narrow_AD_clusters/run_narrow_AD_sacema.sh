#!/bin/bash -l
#
#PBS -N narrowAD
#PBS -P CBBI1106
#PBS -q bigmem
#PBS -l select=1:ncpus=56:mpiprocs=56:nodetype=haswell_fat
#PBS -W group_list=bigmemq
#PBS -l walltime=48:00:00
#PBS -m be
#PBS -M niyukuri@aims.ac.za






ulimit -s unlimited

module add /apps/chpc/scripts/modules/bio/app/simpact-cyan/0.21.0
module add /apps/chpc/scripts/modules/bio/app/Seq-Gen/1.3.4
module add /apps/chpc/scripts/modules/bio/app/FastTree/2.1.10
module add chpc/R/3.4.4-gcc7.2.0


cd /mnt/lustre/users/dniyukuri/age_mixing_narrow_AD_clusters


Rscript wrapper.age.mix.R
