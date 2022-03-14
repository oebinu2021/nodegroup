

cluster_name    =   "first_cluster"
region          =   "ap-northeast-2"

#subnet_list =[]
#subnet_id = [ aws_subnet.cluster-0.id, aws_subnet.cluster-1.id ]

# eks_node_group_list = []
node_list = [
  {
    "name"            = "first-t2micro"
    "instance_type"   = "t2.micro"
    "instance_volume" = "30"
    "desired_size"    = 1
    "min_size"        = 1
    "max_size"        = 3
    "description"     = "eks node"
  },
  {
    "name"            = "first-t3medium"
    "instance_type"   = "t3.medium"
    "instance_volume" = "30"
    "desired_size"    = 1
    "min_size"        = 1
    "max_size"        = 4
    "description"     = "for operations"
  },
]
