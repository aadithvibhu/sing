terraform {
 backend "s3" {
  encrypt = true
  bucket = "ais3"
  region = "ap-southeast-1"
  key = "terraform/singtel/nonprod.tfstate"
 }
}
