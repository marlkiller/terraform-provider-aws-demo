
```shell
export ssp_env=int-cn
export project_root_dir=`pwd`


#export TF_LOG_PATH=${project_root_dir}/terraform.log
#export TF_LOG=DEBUG
#echo "" > ${project_root_dir}/terraform.log

echo 'ssp_env : \t' $ssp_env
echo '$project_root_dir : \t' $project_root_dir

rm -rf ${project_root_dir}/build


cd ${project_root_dir}/scripts/

## remove

sh destroy.sh 413236434696_UserFull ${ssp_env} common_account_infra


echo 'over'
```
