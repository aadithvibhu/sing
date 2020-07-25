# Internet GW
#************

resource "aws_internet_gateway" "igw_main" {
    vpc_id = "${aws_vpc.main.id}"

    tags = {
        Name = "${var.project}_igw"
    }
}

# NAT Gateway
#**************

resource "aws_eip" "eip_main"{
  vpc      = true
}

resource "aws_nat_gateway" "ngw_main" {
  allocation_id = "${aws_eip.eip_main.id}"
  subnet_id = "${aws_subnet.public_subnet_1.id}"
  depends_on = [aws_internet_gateway.igw_main]
   
  tags = {
    Name = "${var.project}_ngw"
  }
}


# Route tables
#*************

resource "aws_default_route_table" "public-route" {
  default_route_table_id = "${aws_vpc.main.default_route_table_id}"

    route {
        cidr_block = "${var.default_route}"
        gateway_id = "${aws_internet_gateway.igw_main.id}"
    }

    tags = {
        Name = "${var.project}-public-route"
    }
}

# you can use if you need sepearte route table
# resource "aws_route_table" "public-route" {
#     vpc_id = "${aws_vpc.main.id}"
#     route {
#         cidr_block = "${var.default_route}"
#         gateway_id = "${aws_internet_gateway.igw_main.id}"
#     }
#     tags = {
#         Name = "${var.project}-public-route"
#     }
# }

resource "aws_route_table" "private-route" {
    vpc_id = "${aws_vpc.main.id}"
    route {
        cidr_block = "${var.default_route}"
        nat_gateway_id = "${aws_nat_gateway.ngw_main.id}"
    }

    tags = {
        Name = "${var.project}-private-route"
    }
}

# Route table associations
#*************************#

# Private
#********

resource "aws_route_table_association" "private-route-assoc1" {
    subnet_id = "${aws_subnet.private_subnet_1.id}"
    route_table_id = "${aws_route_table.private-route.id}"
}

resource "aws_route_table_association" "private-route-assoc2" {
    subnet_id = "${aws_subnet.private_subnet_2.id}"
    route_table_id = "${aws_route_table.private-route.id}"
}

# Public
#********

resource "aws_route_table_association" "public-route-assoc" {
    subnet_id = "${aws_subnet.public_subnet_1.id}"
    route_table_id = "${aws_default_route_table.public-route.id}"
}

# you can use if you want sepearte route table
# resource "aws_route_table_association" "public-route-assoc" {
#     subnet_id = "${aws_subnet.public_subnet_1.id}"
#     route_table_id = "${aws_route_table.public-route.id}"
# }

#***********************************

# Variables
#************

#variable project {}
#variable default_route {}
