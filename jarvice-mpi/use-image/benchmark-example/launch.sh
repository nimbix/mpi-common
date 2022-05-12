#!/usr/bin/env bash
# Source the JARVICE job environment variables
echo "Sourcing JARVICE environment..."
[[ -r /etc/JARVICE/jobenv.sh ]] && source /etc/JARVICE/jobenv.sh
[[ -r /etc/JARVICE/jobinfo.sh ]] && source /etc/JARVICE/jobinfo.sh

# Wait for slaves...max of 60 seconds
echo "Checking slave nodes are operational..."
SLAVE_CHECK_TIMEOUT=60
TOOLSDIR="/usr/local/JARVICE/tools/bin"
${TOOLSDIR}/python_ssh_test ${SLAVE_CHECK_TIMEOUT}
ERR=$?
if [[ ${ERR} -gt 0 ]]; then
  echo "One or more slaves failed to start" 1>&2
  exit ${ERR}
fi

# start SSHd
echo "Starting local sshd..."
if [[ -x /usr/sbin/sshd ]]; then
  sudo service ssh start
fi

# Gather job environment and process input
echo "Processing computational environment..."
MPIHOSTS=
CORES=

CORES=$(cat /etc/JARVICE/cores | wc -l )
NBNODES=$(cat /etc/JARVICE/nodes | wc -l)
if [[ "$NBNODES" -gt 1 ]]; then
  MPIHOSTS="/etc/JARVICE/cores"
  NBPROCPERNODE=$((CORES/NBNODES))
  echo "MPI environment: "
  echo "  - mpi_hosts list file: $MPIHOSTS"
  echo "  - number of process per nodes: $NBPROCPERNODE"
  echo "  - cores: $CORES"
else
  echo "MPI environment: "
  echo "  - cores: $CORES"
fi

set -x
cat /etc/JARVICE/cores
cat /etc/JARVICE/nodes
set +x

# Load mpi environment
echo "Loading Jarvice OpenMPI environment..."
export PATH=/opt/JARVICE/openmpi/bin:$PATH
export LD_LIBRARY_PATH=/opt/JARVICE/openmpi/lib:$LD_LIBRARY_PATH

# Enter case directory
echo "Entering case folder $CASE_FOLDER ..."
cd "$CASE_FOLDER"

# Execute command, add verbosity to see exact command executed
# Also use full path for binaries, even mpirun, to avoid issues on slave nodes
echo "Executing application."
echo "First command explicitely shows who is running MPI (help understanding)."
echo "Second command is the real application."
date
set -x
echo "###############################################################"
echo "################# BASIC HOSTNAMES #############################"
echo "###############################################################"
/opt/JARVICE/openmpi/bin/mpirun -x PATH -x LD_LIBRARY_PATH -np $CORES --hostfile /etc/JARVICE/cores hostname
echo "###############################################################"
echo "################# IMB-MPI #####################################"
echo "###############################################################"
/opt/JARVICE/openmpi/bin/mpirun -x PATH -x LD_LIBRARY_PATH -np $CORES --hostfile /etc/JARVICE/cores /IMB-MPI1
echo "###############################################################"
echo "################# OSU latency #################################"
echo "###############################################################"
/opt/JARVICE/openmpi/bin/mpirun -x PATH -x LD_LIBRARY_PATH -np $NBNODES -N 1 --hostfile /etc/JARVICE/cores /osu_bw
echo "###############################################################"
echo "################# OSU bandwith ################################"
echo "###############################################################"
/opt/JARVICE/openmpi/bin/mpirun -x PATH -x LD_LIBRARY_PATH -np $NBNODES -N 1 --hostfile /etc/JARVICE/cores /osu_latency
set +x
date