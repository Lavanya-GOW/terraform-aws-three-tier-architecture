variable "region" {
  description = "Region of VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = list(string)
}

variable "frontend_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}

variable "backend_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = list(string)
}

variable "database_subnet_cidr" {
  description = "The CIDR block for the external ALB subnet"
  type        = list(string)
}

variable "availability_zones" {
  description = "The availability zones for the subnet"
  type        = list(string)
}

variable "instance_tenancy" {
  description = "The instance tenancy for the VPC"
  type        = string
  default     = "default"
}

variable "route_table_cidr" {
  description = "The CIDR block for the route table"
  type        = string
  default     = "0.0.0.0/0"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
}

variable "project" {
  description = "The project name for the resources"
  type        = string
}

variable "tags" {
  description = "A map of tags to assign to the resources"
  type        = map(string)
  default     = {}
}

variable "enable_nat_gateway" {
  description = "Whether to enable the NAT gateway"
  type        = bool
  default     = true
}

variable "single_nat_gateway" {
  description = "Whether to create a single NAT gateway or one per availability zone"
  type        = bool
}

variable "instance_type" {
  description = "The instance type for the bastion host"
  type        = string
  default     = "t3.micro"
}

variable "key_name" {
  description = "The name of the key pair to use for the bastion host"
  type        = string
}

variable "target_group_port" {
  description = "The port for the target group"
  type        = number
  default     = 5000
}

variable "enable_deletion_protection" {
  description = "Whether to enable deletion protection for the ALB"
  type        = bool
  default     = false
}

variable "enable_cross_zone_load_balancing" {
  description = "Whether to enable cross-zone load balancing for the ALB"
  type        = bool
  default     = true
}

variable "enable_http2" {
  description = "Whether to enable HTTP/2 for the ALB"
  type        = bool
  default     = true
}

variable "idle_timeout" {
  description = "The idle timeout for the ALB in seconds"
  type        = number
  default     = 60
}

variable "health_check_path" {
  description = "The path for the health check of the target group"
  type        = string
  default     = "/health"
}

variable "certificate_arn" {
  description = "The ARN of the SSL certificate for the ALB"
  type        = string
  default     = ""
}

variable "internal" {
  description = "Whether the ALB is internal or internet-facing"
  type        = bool
  default     = false
}

variable "allowed_ssh_cidrs" {
  description = "List of CIDR blocks allowed to access the bastion host via SSH"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "alarm_action_arn" {
  description = "The ARN of the action to take when the CloudWatch alarm is triggered"
  type        = string
  default     = ""
}

variable "max_size" {
  description = "Max number of instances"
  type        = number
}

variable "min_size" {
  description = "Min number of instances"
  type        = number
}

variable "desired_size" {
  description = "Desired number of instances"
  type        = number

}

variable "target_group_arn" {
  description = "Target group ARN for ALB"
  type        = string
  default     = ""
}

variable "instance_class" {
  description = "RDS instance class"
  type        = string
}

variable "allocated_storage" {
  description = "Allocated storage in GB"
  type        = number
}

variable "engine_version" {
  description = "PostgreSQL engine version"
  type        = string
}

variable "db_name" {
  description = "Database name"
  type        = string
}

variable "db_username" {
  description = "Master username"
  type        = string
}

variable "db_password" {
  description = "Master password"
  type        = string
  sensitive   = true
}

variable "multi_az" {
  description = "Enable Multi-AZ deployment"
  type        = bool
}

variable "db_availability_zone" {
  description = "Availability zone for single-AZ deployment"
  type        = string
  default     = null
}

variable "backup_retention_period" {
  description = "Backup retention period in days"
  type        = number
}

variable "skip_final_snapshot" {
  description = "Skip final snapshot when destroying"
  type        = bool
}

variable "deletion_protection" {
  description = "Enable deletion protection"
  type        = bool
  default     = false
}

variable "monitoring_interval" {
  description = "Enhanced monitoring interval in seconds (0, 1, 5, 10, 15, 30, 60)"
  type        = number
  default     = 0
}

variable "ami_id" {
  description = "AMI ID for bastion"
  type        = string
  default     = ""
}

variable "secrets_arns" {
  description = "Secrets ARN for IAM"
  type        = list(string)
  default     = ["*"]
}

variable "recovery_window_in_days" {
  description = "Recovery window for secret"
  type        = number
  default     = 0
}

variable "db_host" {
  description = "Database host"
  type        = string
  default     = null
}

variable "db_port" {
  description = "Database port"
  type        = number
  default     = 5432
}