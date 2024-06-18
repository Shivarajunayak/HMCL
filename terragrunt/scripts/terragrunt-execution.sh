#!/bin/bash

action=$1
pwd=$2

command="terragrunt run-all $action -no-color"
changes=0

while read -r line; do
    dir=$line
    dir="${dir#*/}"
    command="$command --terragrunt-include-dir $dir -no-color"
    changes=1
done < gitFiles/fileChangedInEnv.txt

command="$command --terragrunt-include-external-dependencies --terragrunt-non-interactive -no-color --terragrunt-tfpath /data/terraform/1.5.4/terraform"

echo "Command: $command"

if [ $changes -eq 1 ]; then
    cd $pwd/live/
    eval $command
else
    echo "No directories changed"
fi