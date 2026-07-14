#vpc-values
region = "eu-west-1"

vpc_cidr = "10.0.0.0/16"

project_name = "cicd-microservices-deployment"

public_subnet_1_cidr = "10.0.1.0/24"
public_subnet_2_cidr = "10.0.2.0/24"

private_subnet_1_cidr = "10.0.3.0/24"
private_subnet_2_cidr = "10.0.4.0/24"

availability_zone_1 = "eu-west-1a"
availability_zone_2 = "eu-west-1b"


#eks.tf-values
cluster_name = "microservices-eks"
node_instance_type = "t3.medium"

desired_size = 2
min_size     = 2
max_size     = 3
