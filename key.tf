resource "aws_key_pair" "key" {
  key_name   = "umg"
  public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
