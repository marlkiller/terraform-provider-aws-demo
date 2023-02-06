## terraform deployment project
### module info
#### [common_account_infra](terraform%2Fdeployment%2Fcommon_account_infra)

- vpc
- iam

#### [backend](terraform%2Fdeployment%2Fbackend)

- sqs
- sns
- lambda
- cloudwatch
- eventbridge

#### [ec2](terraform%2Fdeployment%2Fec2)

- ec2

### env
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

### deploy

#### deploy module
```shell
sh deploy.sh 413236434696_UserFull ${ssp_env} common_account_infra
sh deploy.sh 413236434696_UserFull ${ssp_env} backend
sh deploy.sh 413236434696_UserFull ${ssp_env} ec2
```
#### deploy all modules
```shell
sh full_deploy.sh 413236434696_UserFull ${ssp_env}
```

### destroy

#### destroy module
```shell
sh destroy.sh 413236434696_UserFull ${ssp_env} common_account_infra
sh destroy.sh 413236434696_UserFull ${ssp_env} backend
sh destroy.sh 413236434696_UserFull ${ssp_env} ec2
```
#### destroy all modules
```shell
sh full_destroy.sh 413236434696_UserFull ${ssp_env}
```