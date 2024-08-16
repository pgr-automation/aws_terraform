

# Security group
resource "aws_security_group" "demo-efs-sg" {
  name = "demo-efs-sg"
  vpc_id = data.aws_vpc.demo-vpc.id 
  tags ={
    Name = "demo-efs-sg"
  } 
  ingress  {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create an EFS File System
resource "aws_efs_file_system" "demo-efs" {
  lifecycle_policy {
    transition_to_ia = "AFTER_30_DAYS"
  }
  tags = {
    Name = "demo-efs"
  }
}

resource "aws_efs_mount_target" "name" {
  file_system_id = aws_efs_file_system.demo-efs.id
  subnet_id = var.subnet_id_value
  security_groups = [aws_security_group.demo-efs-sg.id]
  
}