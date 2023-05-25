# vpc
output "vpc_id" {
    value   = aws_vpc.vpc.id
}

output "public_subnet" {
    value   = [aws_subnet.public_subnet.id]
}

output "public_rtb" {
    value   = [aws_route_table.public_rtb.id]
}

# ec2
output "public_instance_ip" {
    value   = [aws_instance.instance.public_ip]
}

output "public_dns_name" {
    value   = aws_instance.instance.public_dns
}