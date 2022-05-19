# mpi-common

This repositories contains:

* Setup common files needed for testing and reporting for MPI fabrics and providers
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

## Jarvice MPI benchmarks

The content of jarvice-mpi/benchmark-example allows to build a simple application 
that can be used to benchmark cluster based on jarvice-mpi OpenMPI. It will run 
Intel MPI Benchmark IMB-MPI1 test, and OSU latency and bandwith tests.

See jarvice-mpi/benchmark-example/README.md for instructions. 
