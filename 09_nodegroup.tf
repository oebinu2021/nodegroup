
resource "aws_eks_node_group" "node_group" {
  count = length(var.node_list)

  node_role_arn   = aws_iam_role.node_iam.arn
  subnet_ids      = [aws_subnet.cluster-0.id, aws_subnet.cluster-1.id]  
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-${var.node_list[count.index].name}"

  scaling_config {
    desired_size = var.node_list[count.index].desired_size
    min_size     = var.node_list[count.index].min_size
    max_size     = var.node_list[count.index].max_size
  }

 	launch_template {
    id      = aws_launch_template.node[count.index].id
    version = "1"
	} 


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.eks-node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.eks-node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.eks-node-AmazonEC2ContainerRegistryReadOnly,
    aws_launch_template.node,
  ]
}