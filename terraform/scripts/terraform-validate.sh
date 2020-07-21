#!/bin/bash

###################################################
#   terraform-validate.sh
#  Author: Satheesh Papisetty
#  
##################################################
set -e
set +x
export PATH=${TF_HOME}:$PATH
check=${WORKSPACE}/${PROJECT}/${ENVNAME}
echo $check
cd $check
terraform validate
function log_validation_started {
    echo "Validating $check config..."
}

function log_validation_complete {
    echo "[OK] $check config"
}
