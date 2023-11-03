output "vpc_id" {
  description = "ID of the VPC"
  value       = aws_vpc.my_vpc.id
}
# Output the IDs of the subnets
output "subnet_ids" {
  value = aws_subnet.my_subnet[*].id
}
