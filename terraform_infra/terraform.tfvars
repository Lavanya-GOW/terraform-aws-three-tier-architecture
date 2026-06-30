region      = "ap-south-1"
environment = "dev"
project     = "3-tier-architecture"

vpc_cidr             = "10.0.0.0/16"
availability_zones   = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
public_subnet_cidr   = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
frontend_subnet_cidr = ["10.0.11.0/24", "10.0.12.0/24", "10.0.13.0/24"]
backend_subnet_cidr  = ["10.0.21.0/24", "10.0.22.0/24", "10.0.23.0/24"]
database_subnet_cidr = ["10.0.31.0/24", "10.0.32.0/24", "10.0.33.0/24"]
single_nat_gateway   = true

key_name          = "EC2TUT"
allowed_ssh_cidrs = ["0.0.0.0/0"]

instance_type = "t3.micro"

min_size     = 2
max_size     = 4
desired_size = 2

instance_class          = "db.t3.micro"
allocated_storage       = 20
engine_version          = "11.22-rds.20241121"
db_name                 = "goalsdb"
db_username             = "postgres"
db_password             = "YourPassword"
multi_az                = false
backup_retention_period = 7
skip_final_snapshot     = true