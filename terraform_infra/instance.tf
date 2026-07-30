resource "aws_instance" "control_plane" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = aws_subnet.frontend[0].id
  vpc_security_group_ids      = [aws_security_group.control_plane_sg.id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ec2_profile.name
  user_data                   = filebase64("${path.module}/scripts/server.sh")

  tags = {
    Name        = "${var.environment}-${var.project}-control-plane"
    Environment = var.environment
    Project     = var.project
  }
}