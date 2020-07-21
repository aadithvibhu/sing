# Subnets
#********

resource "aws_subnet" "public_subnet_1" {
    availability_zone = "${var.avz.a}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_public_cidr_1}"

    tags = {
        Name = "${var.project}_public_sub"
    }
}


resource "aws_subnet" "private_subnet_1" {
    availability_zone = "${var.avz.a}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_private_cidr_1}"

    tags = {
        Name = "${var.project}_private_sub1"
    }
}

resource "aws_subnet" "private_subnet_2" {
    availability_zone = "${var.avz.b}"
    vpc_id = "${aws_vpc.main.id}"
    cidr_block = "${var.sub_private_cidr_2}"

    tags = {
        Name = "${var.project}_private_sub2"
    }
}


#********* Variables **********

variable sub_public_cidr_1 {}
variable sub_private_cidr_1 {}
variable sub_private_cidr_2 {}
variable project {}
variable avz {}


