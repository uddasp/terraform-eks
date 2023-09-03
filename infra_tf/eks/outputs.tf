data "terraform_remote_state" "network" {
  backend = "s3"
  config = {
    bucket         = "uddasp-tfstate"
    key            = "network.tfstate" 
    region         = "us-east-1"  
    encrypt        = true
  }
}


#  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id
#  pub_subnets     = [data.terraform_remote_state.vpc.outputs.public_subnet_ids]
#  pri_subnets = [data.terraform_remote_state.vpc.outputs.private_subnet_ids]

output "endpoint" {
  value = aws_eks_cluster.uddasp-eks-cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.uddasp-eks-cluster.certificate_authority[0].data
}