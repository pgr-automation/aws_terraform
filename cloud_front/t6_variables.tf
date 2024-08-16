variable "ami_value" {
  description = "ami_value"
  
}

variable "instance_type_value" {
  description = "instance_type_value"
  
}

variable "instance_name" {
  description = "List of instance configurations"
  type = list(object({
    name  = string
  
  }))

  default = [
    {
      name = "web1"
     
    }
    
  ]
}