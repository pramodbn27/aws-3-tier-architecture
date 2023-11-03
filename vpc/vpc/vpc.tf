resource "aws_vpc" "eos_vpc" {
cidr_block = var.vpcid

tags = {
    Name = "eos_database_vpc"
  }

}

resource "aws_internet_gateway" "eos_gw" {
    vpc_id = aws_vpc.eos_vpc.id

}

resource "aws_eip" "ip" {
}

resource "aws_nat_gateway" "eos_nat" {
  allocation_id = aws_eip.ip.id
  subnet_id     = aws_subnet.pub_sub1.id

}