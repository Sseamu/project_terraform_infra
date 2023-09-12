terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  backend "s3" {
    bucket  = "s3-terraform-versioning" # 고유한 S3 버킷 이름을 지정하세요.
    key     = "terraform.tfstate"       # 원격 상태 파일의 이름을 설정하세요.
    region  = "ap-northeast-2"          # AWS 리전을 설정하세요.
    encrypt = true                      # 상태 파일 암호화 여부를 설정하세요.
    # dynamodb_table = "your-lock-table"             # 선택적으로 DynamoDB 락 테이블을 사용하려면 지정하세요.
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


#s3
module "s3" {
  source       = "./s3"
  service_type = var.service_type
  vpc_id       = module.vpc.vpc_id
  bucket       = "philoberry-s3-${var.service_type}"
}




#rds
module "rds" {
  source              = "./rds"
  service_type        = var.service_type
  vpc_id              = module.vpc.vpc_id
  private_subnet3_id  = module.vpc.private_subnet3_id
  private_subnet4_id  = module.vpc.private_subnet4_id
  instance_class      = "db.t2.micro"
  username            = "admin"
  password            = "1q2w3e4r"
  publicly_accessible = false
}




# ALB
module "alb" {
  source       = "./alb"
  service_type = var.service_type
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = [module.vpc.public_subnet1_id, module.vpc.public_subnet2_id]
  depends_on   = [module.ec2]
}
