resource "aws_vpc" "fargate-vpc" {
  cidr_block = var.cidr
}

resource "aws_internet_gateway" "fargate-main" {
  vpc_id = aws_vpc.fargate-vpc.id
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.fargate-vpc.id
  cidr_block = var.private_subnet
  #availabilty_zone
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.fargate-vpc.id
  cidr_block = var.public_subnet
  #availabilty_zone
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.fargate-vpc.id
}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.fargate-main.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

# Attach NAT gateways for private subnet(s)
resource "aws_eip" "nat" {
  vpc = true

}

resource "aws_nat_gateway" "fargate-main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public.id
  depends_on    = [aws_internet_gateway.fargate-main.id]

}

# Route table for the private subnet
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.fargate-main.id
}

resource "aws_route" "private" {
  route_table_id         = aws_route_table.private.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.fargate-main.id
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table_id.private.id
}