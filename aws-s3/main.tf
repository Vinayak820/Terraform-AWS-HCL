terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "6.26.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.7.2"
    }
  }
}

provider "aws" {
  # Configuration options
  region = "ap-south-1"
}

resource "random_id" "rand_id" {
  byte_length = 8
}

resource "aws_s3_bucket" "demo-bucket" {
  bucket = "my-demo-bucket-${random_id.rand_id.hex}"
  force_destroy = true
}

resource "aws_s3_object" "bucket-object" {
  bucket = aws_s3_bucket.demo-bucket.id
  source = "./myfile.txt"
  key    = "mydata.txt"
}

output "name" {
  value = random_id.rand_id.b64_url
}
