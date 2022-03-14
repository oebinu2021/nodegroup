

## 01_variable.tf ##

variable "cluster_name" {
	default = ""
	type = string
	description = "eks cluster name"
}

variable "region" {
	default = ""  
	description = "aws region"
}

variable "instance_type" {
	default = ""
	type    = string
}

variable "subnet_ids" {
	type	=	list(string)
	default	=	[
		"aws_subnet.cluster-0.id", 
		"aws_subnet.cluster-1.id"
		]  
} 


variable "node_list" {
  type = list(object({
    name            = string
    instance_type   = string
    instance_volume = string
    desired_size    = number
    min_size        = number
    max_size        = number
    description     = string
  }))

  default     = []
  description = "definition to create node groups"
}

