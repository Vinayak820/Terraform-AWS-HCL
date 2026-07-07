terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
  }
}

provider "aws" {
  # Configuration options
  region = var.aws_region
}

resource "aws_instance" "myserver" {
  ami           = "ami-00ca570c1b6d79f36"
  instance_type = "t3.small"
  tags = {
    Name = "SampleServer"
  }
}
