resource "aws_vpc" "main" {

  cidr_block       = var.vpc_cidr
  instance_tenancy = var.instance_tenancy
  tags             = merge(var.tags, { Name = "${var.project}-${var.environment}-vpc" })

}

resource "aws_subnet" "public" {
  count                   = length(var.availability_zones)
  vpc_id                  = aws_vpc.main.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.availability_zones[count.index]
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-public-subnet"
    }
  )
}

resource "aws_subnet" "frontend" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.frontend_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-frontend-subnet"
    }
  )
}

resource "aws_subnet" "backend" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.backend_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-backend-subnet"
    }
  )
}

resource "aws_subnet" "database" {
  count             = length(var.availability_zones)
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.database_subnet_cidr[count.index]
  availability_zone = var.availability_zones[count.index]

  tags = merge(
    var.tags,
    {
      Name = "${var.project}-${var.environment}-database-subnet"
    }
  )
}

resource "aws_internet_gateway" "main" {

  vpc_id = aws_vpc.main.id
  tags   = merge(var.tags, { Name = "${var.project}-${var.environment}-igw" })

}

resource "aws_eip" "nat" {
  count  = length(var.availability_zones)
  domain = "vpc"

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-nat-eip-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]

}

resource "aws_nat_gateway" "main" {
  count         = length(var.availability_zones)
  allocation_id = aws_eip.nat[count.index].id
  subnet_id     = aws_subnet.public[count.index].id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-nat-gw-${count.index + 1}"
    }
  )

  depends_on = [aws_internet_gateway.main]

}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = var.route_table_cidr
    gateway_id = aws_internet_gateway.main.id
  }

}

resource "aws_route" "public" {
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.main.id
  destination_cidr_block = "11.0.0.0/16"
}

resource "aws_route_table_association" "public" {

  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id

}

resource "aws_route_table" "frontend" {
  count  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-frontend-rt-${count.index + 1}"
      Tier = "frontend"
    }
  )
}

resource "aws_route" "frontend_nat" {
  count                  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  route_table_id         = aws_route_table.frontend[count.index].id
  destination_cidr_block = "12.0.0.0/16"
  nat_gateway_id         = var.single_nat_gateway ? aws_nat_gateway.main[0].id : aws_nat_gateway.main[count.index].id
}

resource "aws_route_table_association" "frontend" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.frontend[count.index].id
  route_table_id = var.enable_nat_gateway ? aws_route_table.frontend[count.index].id : null
}

resource "aws_route_table" "backend" {
  count  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-backend-rt-${count.index + 1}"
      Tier = "backend"
    }
  )
}

resource "aws_route" "backend_nat" {
  count                  = var.enable_nat_gateway ? length(var.availability_zones) : 0
  route_table_id         = aws_route_table.backend[count.index].id
  destination_cidr_block = "13.0.0.0/16"
  nat_gateway_id         = var.single_nat_gateway ? aws_nat_gateway.main[0].id : aws_nat_gateway.main[count.index].id
}

resource "aws_route_table_association" "backend" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.backend[count.index].id
  route_table_id = var.enable_nat_gateway ? aws_route_table.backend[count.index].id : null
}

resource "aws_route_table" "database" {
  vpc_id = aws_vpc.main.id

  tags = merge(
    var.tags,
    {
      Name = "${var.environment}-${var.project}-database-rt"
      Tier = "database"
    }
  )
}

resource "aws_route_table_association" "database" {
  count          = length(var.availability_zones)
  subnet_id      = aws_subnet.database[count.index].id
  route_table_id = aws_route_table.database.id
}