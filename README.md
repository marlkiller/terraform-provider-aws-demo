## Terraform-modules-provider-aws

### Module info

- [common_account_infra](terraform%2Fdeployment%2Fcommon_account_infra)
  - vpc
  - iam
- [backend](terraform%2Fdeployment%2Fbackend)
  - sqs
  - sns
  - lambda
  - cloudwatch
  - eventbridge
- [ec2](terraform%2Fdeployment%2Fec2)
  - ec2

### Configure the environment

```shell
vim ~/.aws/credentials
[413236434696_UserFull]
aws_access_key_id = xxxx
aws_secret_access_key = xxxx
region=cn-north-1
```

```shell
export ssp_env=int-cn
```

### Perform deployment

- Deploy module
    ```shell
    cd scripts
    sh deploy.sh 413236434696_UserFull ${ssp_env} common_account_infra
    sh deploy.sh 413236434696_UserFull ${ssp_env} backend
    sh deploy.sh 413236434696_UserFull ${ssp_env} ec2
    ```

- Deploy all modules
    ```shell
    cd scripts
    sh full_deploy.sh 413236434696_UserFull ${ssp_env}
    ```

### Perform destroy

- Destroy module
    ```shell
    cd scripts
    sh destroy.sh 413236434696_UserFull ${ssp_env} common_account_infra
    sh destroy.sh 413236434696_UserFull ${ssp_env} backend
    sh destroy.sh 413236434696_UserFull ${ssp_env} ec2
    ```

- Destroy all modules

    ```shell
    cd scripts
    sh full_destroy.sh 413236434696_UserFull ${ssp_env}
    ```