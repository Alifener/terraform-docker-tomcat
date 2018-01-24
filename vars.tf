variable "AWS_REGION" {
  default = "eu-west-2"
}

variable "ECS_AMIS" {
  type = "map"

  default = {
    eu-west-2 = "ami-eb62708f"
  }
}

#machine types
variable "ec2_machine_type" {
  default = "t2.micro"
}

variable "app_version" {
  default = "latest"
}

variable "PATH_TO_PUBLIC_KEY" {
  default = "../key-pairs/umgkey.pub"
}

variable "INSTANCE_USERNAME" {
  default = "ec2-user"
}
