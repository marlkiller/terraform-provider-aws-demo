#!/usr/bin/env bash
set -eu
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

if [[ -z $1 ]]; then
    echo 'Please define the profile to use as first param'
    exit 1
fi
AWS_PROFILE=$1

if [[ -z $2 ]]; then
    echo 'Please define the terraform settings folder to use (dev/test/prod)'
    exit 1
fi
ENVIRONMENT=$2

if [[ -z $3 ]]; then
    echo 'Please define the component to deploy (dynamodb/frontend_api/user_api etc...)'
    exit 1
fi
COMPONENT=$3

DEPLOYMENT_FOLDER="$DIR/../terraform/deployment/$COMPONENT"
ENVIRONMENTS_FOLDER="$DIR/../terraform/settings"

pushd $DEPLOYMENT_FOLDER || exit

/Users/artemis/Documents/command/terraform_1.3.7/terraform init -reconfigure -backend-config="$ENVIRONMENTS_FOLDER/$ENVIRONMENT/backend_$COMPONENT.tfvars"
/Users/artemis/Documents/command/terraform_1.3.7/terraform apply -lock=false -var-file="$ENVIRONMENTS_FOLDER/$ENVIRONMENT/variables.tfvars"
#terraform apply -auto-approve
popd || exit
