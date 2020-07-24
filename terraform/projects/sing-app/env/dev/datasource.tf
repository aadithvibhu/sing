provider aws {
   region = "${var.aws_region}"
}

data "aws_vpc" "main" {
  filter {
    name = "tag:Name"
    values = ["${var.project}-vpc"]
  }
}

###### Private Network  #######
data "aws_subnet_ids" "app_tier" {
  vpc_id = "${data.aws_vpc.main.id}"
}

data "aws_subnet" "private_subnet_1" {
   filter {
    name = "tag:Name"
    values = ["${var.project}_private_sub1"]
  }
}
data "aws_subnet" "private_subnet_2" {
   filter {
    name = "tag:Name"
    values = ["${var.project}_private_sub2"]
  }
}
