terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-2"
}

resource "aws_vpc" "vpc_test" {
    cidr_block = "10.0.0.0/16"
  
}

resource "aws_subnet" "subnet_1" {
    vpc_id = aws_vpc.vpc_test.id
    cidr_block = "10.0.1.0/24"  
}

resource "aws_security_group" "sg_1" {
    vpc_id = aws_vpc.vpc_test.id
    description = "allow rules"

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_internet_gateway" "ig1" {
    vpc_id = aws_vpc.vpc_test.id
}

resource "aws_route_table" "rt1" {
    vpc_id = aws_vpc.vpc_test.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.ig1.id
    }
  
}

resource "aws_route_table_association" "rt1asso" {
    subnet_id = aws_subnet.subnet_1.id
    route_table_id = aws_route_table.rt1.id
  
}

resource "aws_instance" "vm_test" {
    ami = "ami-0f5daaa3a7fb3378b"
    instance_type = "t2.micro"
    key_name = "keyfile"
    subnet_id = aws_subnet.subnet_1.id
    vpc_security_group_ids = [aws_security_group.sg_1.id]
    associate_public_ip_address = true
 
}

