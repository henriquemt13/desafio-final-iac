# Input variable definitions
variable "vpc_name" {
  description = "VPC"
  type        = string
  default     = "desafio-vpc"
}

variable "vpc_cidr" {
  description = "CIDR block for VPC"
  type        = string
  default     = "10.100.0.0/16"
}

variable "vpc_azs" {
  description = "Availability zones for VPC"
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "vpc_public_subnets" {
  description = "Public subnets for VPC"
  type        = list(string)
  default     = ["10.100.1.0/24", "10.100.2.0/24"]
}

variable "vpc_enable_nat_gateway" {
  description = "Enable NAT gateway for VPC"
  type        = bool
  default     = true
}

variable "vpc_tags" {
  description = "Tags to apply to resources created by VPC module"
  type        = map(string)
  default = {
    Terraform = "true"
    Environment = "desafio"
  }
}


variable "sg_ports" {
    type = list(number)
    description = "Lista com as portas para o ingress do sg"
    default = [80, 443, 22]
}

variable "instance_type" {
    type = string
    default = "t3.medium"
}

variable "instance_name" {
    type = string
    default = "desafio"
}

variable "instance_ami" {
    type = string
    default = "ami-04902260ca3d33422"
}

variable "instance_tags" {
  description = "Tags to apply to resources created by Instances module"
  type        = map(string)
  default = {
    Name = "desafio-ec2"
    Terraform = "true"
    Environment = "desafio"
    Application = "desafio-app"
    BU = "java-script"

  }
}