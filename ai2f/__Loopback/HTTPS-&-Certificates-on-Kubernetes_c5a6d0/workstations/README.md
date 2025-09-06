# Provision attendee workstations

## Prerequisites
Must have built aks-cluster and resource group from other directory.

## Login to Azure

    az login

## Create workstations using Terraform

    terraform init
    terraform apply -auto-approve -target random_pet.pet
    terraform apply -auto-approve

Note: May need to perform `terraform refresh` if **azure_vm_public_ips** are not generated on initial apply.




