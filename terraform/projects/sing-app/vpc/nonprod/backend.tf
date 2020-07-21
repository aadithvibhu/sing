terraform {
 backend "s3" {
  encrypt = true
  bucket = ""
  region = "ap-southeast-1"
  key = "terraform/symbiosis/prod/main.tfstate"
 }
}
