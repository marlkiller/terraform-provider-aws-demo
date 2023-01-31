#!/bin/bash

echo "FULL PCP BACKEND DEPLOYMENT"

source ./clean_python_files.sh

if [ ! -z $1 ]; then
    echo "Profile passed as first param"
    export AWS_PROFILE=$1
else
    if [ -z "${AWS_PROFILE}" ]; then
        echo "Which PROFILE do you want use?"
        read profile
        export AWS_PROFILE=$profile
        echo "AWS_PROFILE environment variable set to ${AWS_PROFILE}"
    else
        echo "AWS_PROFILE=${AWS_PROFILE}"
    fi
fi

if [ ! -z $2 ]; then
    echo "stage name/environment passed as second param"
    export STAGE_NAME=$2
else
    if [ -z "${STAGE_NAME}" ]; then
        echo "Which STAGE do you want to destroy to?"
        read stage
        export STAGE_NAME=$stage
        echo "STAGE_NAME environment variable set to ${STAGE_NAME}"
    else
        echo "STAGE_NAME=${STAGE_NAME}"
    fi
fi

echo "******************************************************"
echo "**  destroy \033[1;ec2\033[0;30m to  \033[0;34m$STAGE_NAME\033[0;30m**"
echo "******************************************************"

cd ../terraform/deployment/ec2/
/Users/artemis/Documents/command/terraform_1.3.7/terraform destroy -auto-approve -lock=false -var-file ../../settings/$STAGE_NAME/variables.tfvars
cd ..

cd ./backend
echo "******************************************************"
echo "**  destroy \033[1;34mbackend\033[0;30m to  \033[0;34m$STAGE_NAME\033[0;30m                      **"
echo "******************************************************"

/Users/artemis/Documents/command/terraform_1.3.7/terraform destroy -auto-approve -lock=false -var-file ../../settings/$STAGE_NAME/variables.tfvars
cd ..

cd ./common_account_infra
echo "******************************************************"
echo "**  destroy \033[1;34mcommon_account_infra\033[0;30m to  \033[0;34m$STAGE_NAME\033[0;30m                      **"
echo "******************************************************"
/Users/artemis/Documents/command/terraform_1.3.7/terraform destroy -auto-approve -lock=false -var-file ../../settings/$STAGE_NAME/variables.tfvars -out tfplan
cd ..



cd ../../../scripts
