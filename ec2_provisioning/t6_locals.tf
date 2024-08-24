locals {
  for_each = [for subnet in aws_subnet.demo-subnets : subnet.id]  # Extracting only the subnet IDs
}
