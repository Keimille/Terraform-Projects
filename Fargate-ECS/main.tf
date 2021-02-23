provider "aws" {
  region = "var.region"
}

resource "aws_vpc" "fargate-vpc" {
  cidr_block = var.cidr
}

resource "aws_internet_gateway" "fargate-main" {
  vpc_id = aws_vpc.fargate-vpc.id
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.fargate-vpc.id
  cidr_block = var.private_subnet
  #availabilty_zone
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.fargate-vpc.id
  cidr_block = var.public_subnet
  #availabilty_zone
}