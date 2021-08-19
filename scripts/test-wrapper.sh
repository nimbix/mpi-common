#!/usr/bin/env bash

# dump the environment we see at startup
env

# determine the fabric(s) we can use
fi_info
ucx_info
ompi_info


# compile the helloworld script
mkdir /tmp/helloworld && cd /tmp/helloworld
git clone https://github.com/mpitutorial/mpitutorial
#https://mpitutorial.com/tutorials/mpi-hello-world/
#wget https://github.com/mpitutorial/mpitutorial/blob/gh-pages/tutorials/mpi-hello-world/code/mpi_hello_world.c

export MPICC=/home/kendall/bin/mpicc
make
#mpicc mpi_hello_world.c

# compile the benchmarks
OSU_BM_SRC=https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.7.1.tgz
