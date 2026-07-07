terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.27.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

# create VPC : my-vpc (block name)
resource "aws_vpc" "my-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "my-vpc-03"
  }
}

# private subnet
resource "aws_subnet" "private-subnet" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name = "private-subnet-my-vpc-03"
  }
}

# public subnet
resource "aws_subnet" "public-subnet" {
  cidr_block = "10.0.2.0/24"
  vpc_id     = aws_vpc.my-vpc.id
  tags = {
    Name = "public-subnet-my-vpc-03"
  }
}

# create internet gateway
resource "aws_internet_gateway" "igw-my-vpc" {
  vpc_id = aws_vpc.my-vpc.id
  tags = {
    Name = "igw-my-vpc-03"
  }
}

# create route table
resource "aws_route_table" "public-rt-my-vpc" {
  vpc_id = aws_vpc.my-vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw-my-vpc.id
  }
  tags = {
    Name = "public-rt-my-vpc-03"
  }
}

# subnet association with route table
resource "aws_route_table_association" "public-rt-assoc-my-vpc" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.public-rt-my-vpc.id
}


# ec2
resource "aws_instance" "myserver" {
  ami           = "ami-00ca570c1b6d79f36"
  instance_type = "t3.small"
  subnet_id = aws_subnet.public-subnet.id
  tags = {
    Name = "SampleServer-vpc"
  }
}
