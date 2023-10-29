resource "aws_subnet" "pub_sub1" {

cidr_block = var.pub_sub1_cidr
availability_zone = var.pub_sub1_az
vpc_id = aws_vpc.eos_vpc.id

}

resource "aws_subnet" "pub_sub2" {

cidr_block = var.pub_sub2_cidr
availability_zone = var.pub_sub2_az
vpc_id = aws_vpc.eos_vpc.id

}

resource "aws_subnet" "priv_sub1" {

cidr_block = var.priv_sub1_cidr
availability_zone = var.priv_sub1_az
vpc_id = aws_vpc.eos_vpc.id

}

resource "aws_subnet" "priv_sub2" {

cidr_block = var.priv_sub2_cidr
availability_zone = var.priv_sub2_az
vpc_id = aws_vpc.eos_vpc.id

}