resource "aws_eks_cluster" "uddasp-eks-cluster" {
  name     = "uddasp"
  role_arn = aws_iam_role.uddasp_eks_role.arn
  version  = "1.27"


  vpc_config {
    subnet_ids = concat(
      tolist(data.terraform_remote_state.network.outputs.public_subnet_ids[*]),
      tolist(data.terraform_remote_state.network.outputs.private_subnet_ids[*])
    )
    endpoint_public_access = true
  }

  depends_on = [
    aws_iam_role_policy_attachment.uddasp-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.uddasp-AmazonEKSVPCResourceController,
  ]
}


resource "aws_eks_node_group" "worker-node-group" {
  cluster_name    = aws_eks_cluster.uddasp-eks-cluster.name
  node_group_name = "uddasp-eks-workernodes"
  node_role_arn   = aws_iam_role.uddasp_worker_role.arn
  subnet_ids      = data.terraform_remote_state.network.outputs.public_subnet_ids[*]
  instance_types  = ["t3.xlarge"]

  scaling_config {
    desired_size = 2
    max_size     = 3
    min_size     = 1
  }

  depends_on = [
    aws_iam_role_policy_attachment.uddasp-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.uddasp-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.uddasp-AmazonEC2ContainerRegistryReadOnly,
  ]
}
