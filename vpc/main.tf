resource "aws_vpc" "vpc" {
  cidr_block           = "172.16.0.0/16"
  instance_tenancy     = "default" ## 테넌시-기본값
  enable_dns_hostnames = true

  tags = {
    Name    = "philoberry-vpc-${var.service_type}"
    Service = "philoberry-{var.service_type}"
  }
}

# 퍼블릭 서브넷1
resource "aws_subnet" "public-subnet-1" {
  vpc_id                  = aws_vpc.vpc.id    // VPC ID
  cidr_block              = "172.16.0.0/24"   //CIDR block
  availability_zone       = "ap-northeast-2a" //가용영역
  map_public_ip_on_launch = true
  tags = {
    Name    = "philoberry-public-subnet-1-${var.service_type}"
    Service = "philoberry-{var.servic_type}"
  }
}

# 퍼블릭 서브넷2
# 위치 : VPC > Virtual Private Cloud > 서브넷
resource "aws_subnet" "public-subnet-2" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "172.16.1.0/24"
  availability_zone       = "ap-northeast-2b"
  map_public_ip_on_launch = true
  tags = {
    Name    = "philoberry-public-subnet-2-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

#프라이빗 서브넷 1
resource "aws_subnet" "private-subnet-1" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.2.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name    = "philoberry-private-subnet-1-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

#프라이빗 서브넷 2
resource "aws_subnet" "private-subnet-2" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.3.0/24"
  availability_zone = "ap-northeast-2b"
  tags = {
    Name    = "philoberry-private-subnet-2-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}
#프라이빗 서브넷 3
resource "aws_subnet" "private-subnet-3" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.4.0/24"
  availability_zone = "ap-northeast-2a"
  tags = {
    Name    = "philoberry-private-subnet-3-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}
#프라이빗 서브넷 4
resource "aws_subnet" "private-subnet-4" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "172.16.5.0/24"
  availability_zone = "ap-northeast-2b"
  tags = {
    Name    = "philoberry-private-subnet-4-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

#Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id // 현재 사용가능한 vpc
  tags = {
    Name    = "philoberry-igw-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

# 탄력적 IP 할당
# 위치 : VPC > Virtual Private Cloud > 탄력적 IP => public IP 1에 사용 
resource "aws_eip" "eip_1" {
  #   vpc = true ==> 예전버전에 사용하던 방식
  domain = "vpc"
  tags = {
    Name    = "philoberry-natgw-eip_1-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

# 탄력적 IP 할당
# 위치 : VPC > Virtual Private Cloud > 탄력적 IP => public IP 2에 사용 
resource "aws_eip" "eip_2" {
  #   vpc = true ==> 예전버전에 사용하던 방식
  domain = "vpc"
  tags = {
    Name    = "philoberry-natgw-eip_2-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}


# NAT 게이트웨이 각 public 서브넷에 1개씩 배치 
# 위치 : VPC > Virtual Private Cloud > NAT 게이트웨이
resource "aws_nat_gateway" "natgw_1" {
  allocation_id = aws_eip.eip_1.id              //탄력적 IP 할당 ID
  subnet_id     = aws_subnet.public-subnet-1.id //퍼블릭 서브넷 1

  tags = {
    Name    = "philoberry-natgw-public1-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}


resource "aws_nat_gateway" "natgw_2" {
  allocation_id = aws_eip.eip_2.id              //탄력적 IP 할당 ID
  subnet_id     = aws_subnet.public-subnet-2.id //퍼블릭 서브넷 2

  tags = {
    Name    = "philoberry-natgw-public2-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

# 퍼블릭 라우팅 테이블
# 위치 : VPC > Virtual Private Cloud > 라우팅 테이블
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"                 //Destination (대상)
    gateway_id = aws_internet_gateway.igw.id //Target (대상)
  }

  tags = {
    Name    = "philoberry-public-rt-${var.service_type}" //라우팅 테이블 이름
    Service = "philoberry-${var.service_type}"
  }
}

# 프라이빗 라우팅 테이블
# 위치 : VPC > Virtual Private Cloud > 라우팅 테이블
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"                //Destination (대상)
    gateway_id = aws_nat_gateway.natgw_1.id //Target (대상)
  }

  tags = {
    Name    = "philoberry-private-rt-${var.service_type}"
    Service = "philoberry-${var.service_type}"
  }
}

# 퍼블릭 라우팅 테이블에 퍼블릭 서브넷1 연결
resource "aws_route_table_association" "public-rt-association-1" {
  subnet_id      = aws_subnet.public-subnet-1.id
  route_table_id = aws_route_table.public-rt.id
}

# 퍼블릭 라우팅 테이블에 퍼블릭 서브넷2 연결
resource "aws_route_table_association" "public-rt-association-2" {
  subnet_id      = aws_subnet.public-subnet-2.id
  route_table_id = aws_route_table.public-rt.id
}

# 프라이빗 라우팅 테이블에 프라이빗 서브넷1 연결
resource "aws_route_table_association" "private-rt-association-1" {
  subnet_id      = aws_subnet.private-subnet-1.id
  route_table_id = aws_route_table.private-rt.id
}

# 프라이빗 라우팅 테이블에 프라이빗 서브넷2 연결
resource "aws_route_table_association" "private-rt-association-2" {
  subnet_id      = aws_subnet.private-subnet-2.id
  route_table_id = aws_route_table.private-rt.id
}

# 프라이빗 라우팅 테이블에 프라이빗 서브넷3 연결
resource "aws_route_table_association" "private-rt-association-3" {
  subnet_id      = aws_subnet.private-subnet-3.id
  route_table_id = aws_route_table.private-rt.id
}

# 프라이빗 라우팅 테이블에 프라이빗 서브넷4 연결
resource "aws_route_table_association" "private-rt-association-4" {
  subnet_id      = aws_subnet.private-subnet-4.id
  route_table_id = aws_route_table.private-rt.id
}
