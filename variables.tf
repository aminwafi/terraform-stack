# utils
variable "aws_region" {
    description = "AWS default region"
    type        = string
    default     = "ap-southeast-1"
}

variable "project_name" {
    description = "Name of project"
    type        = string
    default     = ""
}

variable "node_env" {
    description = "Environment setup of project"
    type        = string
    default     = "dev"
}

# vpc
variable "cidr_vpc" {
    description = "CIDR block of VPC"
    type        = string
    default     = "10.0.0.0/16"
}

variable "cidr_public_subnet" {
    description = "CIDR block of public subnet"
    type        = string
    default     = "10.0.0.0/24"
}

variable "cidr_private_subnet" {
    description = "CIDR block of private subnet"
    type        = string
    default     = "10.0.1.0/24"
}

variable "availability_zone" {
    description = "AZ of subnet"
    type        = string
    default     = "ap-southeast-1b"
}

# ec2
variable "instance_ami" {
    description = "AMI of instance"
    type        = string
    default     = ""
}

variable "instance_type" {
    description = "Type of instance"
    type        = string
    default     = "t2.micro"
}

variable "key_pair_name" {
    description = "Name of SSH key associated with instance"
    type        = string
    default     = ""
}