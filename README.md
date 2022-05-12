# mpi-common

This repositories contains:

* Setup common files needed for testing and reporting for MPI fabrics and providers
* Jarvice MPI image generation tools and instructions
* Instructions on how to simply use Jarvice MPI and benchmark current cluster MPI performances

## mpi-common testing scripts

### Helpful utilities installed by mpi-common scripts
OSU Micro-benchmarks:
https://mvapich.cse.ohio-state.edu/benchmarks/

MPI Tutorials:
https://mpitutorial.com/tutorials/mpi-hello-world

### Supported MPI Distributions

* Open MPI
* Intel MPI

## Jarvice MPI image building

The content of jarvice-mpi/build-image allows to build jarvice_mpi image from 
jarvice init image. jarvice_mpi should be make public so users can use it to 
build their MPI applications.

See jarvice-mpi/build-image/README.md for basic instructions. 

## Jarvice MPI benchmarks

The content of jarvice-mpi/benchmark-example allows to build a simple application 
that can be used to benchmark cluster based on jarvice-mpi OpenMPI. It will run 
Intel MPI Benchmark IMB-MPI1 test, and OSU latency and bandwith tests.

See jarvice-mpi/benchmark-example/README.md for instructions. 
