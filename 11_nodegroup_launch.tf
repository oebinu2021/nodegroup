

data "aws_ami" "node" {
  filter {
    name   = "name"
    values = ["amazon-eks-node-${aws_eks_cluster.eks.version}-v*"]
  }

  most_recent = true
  owners      = ["602401143452"]
}

locals {
  eks_node_userdata = <<USERDATA
#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${aws_eks_cluster.eks.endpoint}' --b64-cluster-ca '${aws_eks_cluster.eks.certificate_authority.0.data}' '${var.cluster_name}'
USERDATA
}



resource "aws_launch_template" "node" {
    count = length(var.node_list)

    name = "${var.cluster_name}-${var.node_list[count.index].name}"
    disable_api_termination = true
  
  lifecycle {
    create_before_destroy = true
  }

    image_id        = data.aws_ami.node.id
    instance_type   = var.node_list[count.index].instance_type
    vpc_security_group_ids = [aws_security_group.node.id]
    user_data = base64encode(local.eks_node_userdata)
    
    tag_specifications {
      resource_type = "instance"

      tags = {
        "Name" = "${var.cluster_name}-${var.node_list[count.index].name}"
      }
    }
}