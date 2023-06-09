resource "aws_vpc" "vpc" {
    cidr_block              = "${var.cidr_vpc}"
    enable_dns_support      = true
    enable_dns_hostnames    = true
    tags                    = {
        "Name"              = "${var.project_name}-${var.node_env}-vpc"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id                  = aws_vpc.vpc.id
    tags                    = {
        "Name"              = "${var.project_name}-${var.node_env}-igw"
    }
}

resource "aws_subnet" "public_subnet" {
    vpc_id                  = aws_vpc.vpc.id
    cidr_block              = "${var.cidr_public_subnet}"
    map_public_ip_on_launch = "true"
    availability_zone       = "${var.availability_zone}"
    tags                    = {
        "Name"              = "${var.project_name}-${var.node_env}-public-subnet"
    }
}

resource "aws_route_table" "public_rtb" {
    vpc_id                  = aws_vpc.vpc.id

    route {
        cidr_block  = "0.0.0.0/0"
        gateway_id  = aws_internet_gateway.igw.id
    }

    tags                    = {
        "Name"              = "${var.project_name}-${var.node_env}-public-rtb"
    }
}

resource "aws_route_table_association" "public_subnet_rta" {
    subnet_id               = aws_subnet.public_subnet.id
    route_table_id          = aws_route_table.public_rtb.id
}

resource "aws_security_group" "sg" {
    vpc_id                  = aws_vpc.vpc.id

    # SSM access
    ingress {
        from_port           = 21
        to_port             = 21
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }

    # SSH access
    ingress {
        from_port           = 22
        to_port             = 22
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }

    # HTTPS access (IPv4)
    ingress {
        from_port           = 443
        to_port             = 443
        protocol            = "tcp"
        cidr_blocks         = ["0.0.0.0/0"]
    }

    # HTTPS access (IPv6)
    ingress {
        from_port           = 443
        to_port             = 443
        protocol            = "tcp"
        ipv6_cidr_blocks    = ["::/0"]
    }

    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        cidr_blocks         = ["0.0.0.0/0"]
    }

    egress {
        from_port           = 0
        to_port             = 0
        protocol            = "-1"
        ipv6_cidr_blocks    = ["::/0"]
    }

    tags                    = {
        "Name"              = "${var.project_name}-${var.node_env}-sg"
    }
}