terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }
  backend "s3" {
    bucket = "my-demo-bucket-9c6b2f6135166e9f"
    key    = "backend.tfstate"
    region = "ap-south-1"
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "aws_instance" "myserver" {
  ami           = "ami-00ca570c1b6d79f36"
  instance_type = "t3.micro"
  tags = {
    Name = "SampleServer"
  }
}
