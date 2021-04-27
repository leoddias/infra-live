# Terragrunt will copy the Terraform configurations specified by the source parameter, along with any files in the
# working directory, into a temporary folder, and execute your Terraform commands in that folder.
terraform {
  source = "git::https://github.com/leoddias/infra-modules//eks?ref=v1.0.1"
}

# Include all settings from the root terragrunt.hcl file
include {
  path = find_in_parent_folders()
}

# These are the variables we have to pass in to use the module specified in the terragrunt configuration above
inputs = {
  cluster_name = "eks_infra"
  cluster_version = "1.16"
  
  vpc_id  = "vpc-11111111"
  subnets = ["subnet-11111111","subnet-11111111","subnet-11111111","subnet-11111111"]
  
  node_groups_defaults = {
    ami_type  = "AL2_x86_64"
    disk_size = 50
  }

  node_groups = {
    principal = {
      name             = "principal"
      desired_capacity = 1
      max_capacity     = 10
      min_capacity     = 1

      instance_type = "m5.large"
      k8s_labels = {
        nodeGroup = "principal"
      }
    }
  }

  map_roles = [
    {
      rolearn  = "arn:aws:iam::AAAAAAAAAAAA:role/Admin_Role"
      username = "Admin"
      groups   = ["system:masters"]
    }
  ]

  map_users = [
    {
      userarn  = "arn:aws:iam::AAAAAAAAAAAA:user/user_1"
      username = "user-devops"
      groups   = ["system:masters"]
    }
  ]

}