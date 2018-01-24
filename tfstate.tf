terraform {
  backend "s3" {
    bucket = "umg-terraform-docker-bucket"
    key    = "terraform/umg"
    region = "eu-west-2"
  }
}
