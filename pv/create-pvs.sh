#!/bin/bash 

BASEDIR=$1
[[ "${BASEDIR}" == "" ]] && echo "ERROR: please provide full path to base directory" && exit 1

echo "*** Creating 20x hostPath PVs in ${BASEDIR}"
echo "*** Assuming user has current oc context logged in, with cluster-admin role"
echo "*** This script uses sudo, you may need to provide your password to continue"

sudo mkdir -p ${BASEDIR}/pv{1..20}
sudo chmod a+w ${BASEDIR}/pv{1..20}
sudo chcon -Rt svirt_sandbox_file_t ${BASEDIR}

sizes=(512Mi 1Gi 10Gi)

si=0
for vol in $(seq 1 20)
do
   size=${sizes[$si]}
   pv=pv$vol
  
   sed s/%pv/$pv/g pv-template.yaml | sed s/%basedir/${BASEDIR}/g | sed s/%size/$size/g | oc create -f -

   si=$(($si+1))
   [[ $si -ge 3 ]] && si=0
 
done