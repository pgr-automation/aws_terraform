data "aws_security_group" "linux" {
  name = "Linux-SG"

}
data "aws_security_group" "fe" {
  name = "FE-SG"

}

data "aws_key_pair" "ssh-key" {
  key_name = "ssh-virgina-key"

}
