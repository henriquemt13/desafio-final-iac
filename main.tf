module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.vpc_name
  cidr = var.vpc_cidr

  azs             = var.vpc_azs
  public_subnets  = var.vpc_public_subnets

  enable_nat_gateway = var.vpc_enable_nat_gateway

  tags = var.vpc_tags
}

#   # Create Internet Gateway
#   resource "aws_internet_gateway" "desafio_gw" {
#     vpc_id = module.vpc.vpc_id
#     tags = {
#       Name = "desafio_gw"
#     }
#   }

# # Create Route table
# resource "aws_route_table" "desafio_rt" {
#   vpc_id = module.vpc.vpc_id
#   route {
#     cidr_block = "0.0.0.0/0"
#     gateway_id = aws_internet_gateway.desafio_gw.id
#   }
#   tags = {
#     Name = "desafio-rt-public"
#   }
# }
# resource "aws_route_table_association" "a" {
#   subnet_id      = module.vpc.public_subnets[0]
#   route_table_id = aws_route_table.desafio_rt.id
# }


resource "aws_security_group" "desafio_sg" {
  name        = "desafio_sg"
  description = "SG desafio via Terraform"
  vpc_id      = module.vpc.vpc_id
  dynamic "ingress" {
    for_each = var.sg_ports
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  dynamic "egress" {
    for_each = var.sg_ports
    content {
      from_port   = egress.value
      to_port     = egress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  tags = {
    Name = "desafio-sg"
  }
}


module "ec2_instance_1" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name          = "${var.instance_name}-1"

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.desafio_sg.id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = var.instance_tags
}

module "ec2_instance_2" {
  source  = "terraform-aws-modules/ec2-instance/aws"

  name          = "${var.instance_name}-2"

  ami                    = var.instance_ami
  instance_type          = var.instance_type
  key_name               = "vockey"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.desafio_sg.id]
  subnet_id              = module.vpc.public_subnets[1]

  tags = var.instance_tags
}