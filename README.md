# pve-k8-storage
This repository contains Terraform scripts that allocate storage, that later can be used for creation of a Kubernetes cluster [pve-k8s](https://github.com/vnedkov/pve-k8s)

## Problem statement
I need a reliable way to manage storage, **independently** from any other hardware that may or may not use it.

## Solution
Create a placeholder VM. It will only have data disks allocated, managed by terraform. Because that VM does not have a boot disk it can never be started and disks can be attached to another machine. 

## Deploying
* Copy/rename provided `terraform.tfvars.example` file to `terraform.tfvars`
* Modify the values in `terraform.tfvars` to match your environment. Edit `nodes` section to allocate the required storage - size and number of disks.
* Please check default values in `variables.tf` and override in `terraform.tfvars` if necessary.
* Run terraform
```sh
terraform init -backend-config=backends/pve.s3.tfbackend -upgrade
terraform plan
terraform apply
```

## Results
Check generated **output/data_vms.json** file to make sure the result is satisfactory. Make a note of `datastore_id` and `path_in_datastore` attributes. They will be necessary later when attaching the disks to another VM.

## Rollback
This will delete all data in the disks. Use with cautions.
```sh
terraform destroy
```