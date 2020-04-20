#!/bin/bash
#PBS -A NTDD0002
#PBS -l walltime = 00:20:00
###2 nodes with 36 CPUs 
#PBS -l select = 1 : ncpus = 1 : mpiprocs = 0
#PBS -N mpi_daxpy_test
#PBS -o daxpy.out
#PBS -e daxpy.err
#PBS -r regular

module purge
module load intel/19.0.2

export TMPDIR = /glade/scratch/mshippy/
mkdir $TMPDIR

module list

cd /glade/scratch/mshippy/MPI-Exercise

ifort -o daxpy daxpy.f90

./daxpy
