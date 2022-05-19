# Load jarvice_mpi image as JARVICE_MPI
FROM us-docker.pkg.dev/jarvice/images/jarvice_mpi:4.1 as JARVICE_MPI

# Multistage to optimise, as image does not need to contain jarvice_mpi 
# components, these are side loaded during job containers init.
FROM ubuntu:latest as buffer

# Grab jarvice_mpi from JARVICE_MPI
COPY --from=JARVICE_MPI /opt/JARVICE /opt/JARVICE

# Install needed dependencies to download and build Intel MPI Benchmark
RUN apt-get update; apt-get install -y wget curl gcc g++ git make bash; apt-get clean;

# Build IMB-MPI1 which is enough for basic testing
RUN bash -c 'git clone https://github.com/intel/mpi-benchmarks.git; cd mpi-benchmarks; \
    source /opt/JARVICE/jarvice_mpi.sh; sed -i 's/mpiicc/mpicc/' src_cpp/Makefile; \
    sed -i 's/mpiicpc/mpicxx/' src_cpp/Makefile; make IMB-MPI1;'

RUN bash -c 'wget http://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.9.tar.gz; \
    tar xvzf osu-micro-benchmarks-5.9.tar.gz; cd osu-micro-benchmarks-5.9; source /opt/JARVICE/jarvice_mpi.sh; \
    ./configure CC=mpicc CXX=mpicxx --prefix=/osu/; make && make install;'

# Create final image from Ubuntu
FROM ubuntu:latest

# Install Nimbix environment
RUN apt-get -y update && \
    apt-get -y install wget curl software-properties-common && \
    curl -H 'Cache-Control: no-cache' \
        https://raw.githubusercontent.com/nimbix/image-common/master/install-nimbix.sh \
        | bash && apt-get clean

# Grab MPI benchmarks binaries built before using jarvice-mpi
COPY --from=buffer /mpi-benchmarks/IMB-MPI1 /IMB-MPI1
COPY --from=buffer /osu/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_bw /osu_bw
COPY --from=buffer /osu/libexec/osu-micro-benchmarks/mpi/pt2pt/osu_latency /osu_latency

# Integrate mpi launch script
COPY launch.sh /launch.sh

# Make the script executable
RUN chmod +x /launch.sh;

# Integrate AppDef file
COPY NAE/AppDef.json /etc/NAE/AppDef.json
