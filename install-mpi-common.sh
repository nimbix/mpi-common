#!/usr/local/bin/bash
#
# Copyright (c) 2021, Nimbix, Inc.
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#
# 1. Redistributions of source code must retain the above copyright notice,
#    this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright notice,
#    this list of conditions and the following disclaimer in the documentation
#    and/or other materials provided with the distribution.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are
# those of the authors and should not be interpreted as representing official
# policies, either expressed or implied, of Nimbix, Inc.
#

MPI_COMMON=/usr/local/mpi-common
OSU_BM_SRC=https://mvapich.cse.ohio-state.edu/download/mvapich/osu-micro-benchmarks-5.7.1.tgz

# Add compilers wrappers for Open MPI distributions
sudo yum install -y gcc g++ make openmpi-devel openmpi3-devel

# Install the MPI Tutorials with Hello World source
echo "Adding MPI Hello World..."
mkdir -p $MPI_COMMON && cd $MPI_COMMON
git clone https://github.com/mpitutorial/mpitutorial

# Install the OSU MPI benchmarks
echo "Adding the OSU Micro-Benchmarks"
mkdir -p $MPI_COMMON/osu-benchmarks && cd $MPI_COMMON/osu-benchmarks
curl -H 'Cache-Control: no-cache' $OSU_BM_SRC | tar xfz - --strip-components=1
make
make install

# Make the whole dir usable by the job users
chmod -R a+w $MPI_COMMON

# Add compilers wrappers for Open MPI distributions
#sudo yum install -y openmpi-devel openmpi3-devel
