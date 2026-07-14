variable "region" { type = string }
variable "vpc_cidr" { type = string }
variable "project_name" { type = string }
variable "public_subnet_1_cidr" { type = string }
variable "availability_zone_1" { type = string }
variable "public_subnet_2_cidr" { type = string }
variable "availability_zone_2" { type = string }
variable "private_subnet_1_cidr" { type = string }
variable "private_subnet_2_cidr" { type = string }



#eks.tf -vars
variable "cluster_name" {type = string}

variable "node_instance_type" {type = string}
variable "desired_size" {type = number}
variable "min_size" {type = number}
variable "max_size" {type = number}

