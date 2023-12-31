
resource "aws_route_table" "eos_priv_rt" {
    vpc_id = aws_vpc.eos_vpc.id
}

resource "aws_route_table" "eos_pub_rt" {
    vpc_id = aws_vpc.eos_vpc.id
}


resource "aws_route_table_association" "eos-pub-sub1-rt-association" {
    route_table_id = aws_route_table.eos_pub_rt.id
    subnet_id = aws_subnet.pub_sub1.id
}

resource "aws_route_table_association" "eos-pub-sub2-rt-association" {
    route_table_id = aws_route_table.eos_pub_rt.id
    subnet_id = aws_subnet.pub_sub2.id
}

resource "aws_route_table_association" "eos-priv-rt1-association" {
    route_table_id = aws_route_table.eos_priv_rt.id
    subnet_id = aws_subnet.priv_sub1.id
}

resource "aws_route_table_association" "eos-priv-rt2-association" {
    route_table_id = aws_route_table.eos_priv_rt.id
    subnet_id = aws_subnet.priv_sub2.id
}

resource "aws_route" "route-pub-rt" {
  route_table_id = aws_route_table.eos_pub_rt.id
  destination_cidr_block = var.rt_destination_cidr
  gateway_id = aws_internet_gateway.eos_gw.id

}

resource "aws_route" "route-priv1-rt" {
  route_table_id = aws_route_table.eos_priv_rt.id
  destination_cidr_block = var.rt_destination_cidr
  gateway_id = aws_internet_gateway.eos_gw.id

}
