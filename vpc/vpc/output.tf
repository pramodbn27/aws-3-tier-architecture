output "vpc_id" {
    value = aws_vpc.eos_vpc.id
}

output "pub_subnet1" {
    value = aws_subnet.pub_sub1.id
}
output "pub_subnet2" {
    value = aws_subnet.pub_sub2.id
}

output "priv_subnet1" {
    value = aws_subnet.priv_sub1.id
}

output "priv_subnet2" {
    value = aws_subnet.priv_sub2.id
}