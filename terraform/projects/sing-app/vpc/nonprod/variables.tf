variable vpc_cidr {}
variable sub_public_cidr_1 {}
variable sub_private_cidr_1 {}
variable sub_private_cidr_2 {}
variable project {}
variable environment {}
variable region {}
variable "avz" {
  type = "map"
  default = {
   a = "ap-southeast-1a"
   b = "ap-southeast-1b"
   c = "ap-southeast-1c"
	}
}
