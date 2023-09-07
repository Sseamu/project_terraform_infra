terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

## AWS 리전(서울)
provider "aws" {
  region = "ap-northeast-2"
}

module "vpc" {
  source       = "./vpc"
  service_type = var.service_type
}

# Ec2
module "ec2" {
  source             = "./ec2"          ## 모듈의 위치
  service_type       = var.service_type ## servicetype ?? prod : test
  vpc_id             = module.vpc.vpc_id
  private_subnet1_id = module.vpc.private_subnet1_id
  instance_type      = "t2.micro"
  user_data_path     = "./ec2/userdata.yaml"
}

# ALB
module "alb" {
  source = "./alb"
  service_type = var.service_type
  vpc_id = module.vpc.vpc_id
  subnet_ids = [module.vpc.public_subnet1_id, module.vpc.public_subnet2_id]
  depends_on = [module.ec2]
}