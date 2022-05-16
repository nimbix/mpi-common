FROM us-docker.pkg.dev/jarvice-system/images/init:latest as JARVICE_INIT_MPI

FROM ubuntu:latest as buffer

COPY --from=JARVICE_INIT_MPI /bin/jarvice-fabric.tar /jarvice-fabric.tar

RUN tar -xvf jarvice-fabric.tar;

COPY jarvice_mpi.sh /opt/JARVICE/jarvice_mpi.sh

FROM alpine:latest

COPY --from=buffer /opt/JARVICE /opt/JARVICE
