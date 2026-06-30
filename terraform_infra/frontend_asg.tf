data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_launch_template" "frontend" {
  name                   = "${var.environment}-${var.project}-frontend_launch-template"
  image_id               = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.frontend_sg.id]
  key_name               = var.key_name
  user_data              = filebase64("${path.module}/scripts/frontend_user_data.sh")

  lifecycle {
    create_before_destroy = true
  }

  monitoring {
    enabled = true
  }

  metadata_options {
    http_tokens                 = "required"
    http_endpoint               = "enabled"
    http_put_response_hop_limit = 2
  }

  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size           = 20
      volume_type           = "gp3"
      delete_on_termination = true
      encrypted             = true
    }
  }

  iam_instance_profile {
    name = aws_iam_instance_profile.ec2_profile.name
  }
}

resource "aws_autoscaling_group" "frontend_asg" {
  name                      = "${var.environment}-${var.project}-frontend-asg"
  max_size                  = 4
  min_size                  = 2
  desired_capacity          = 2
  vpc_zone_identifier       = aws_subnet.frontend[*].id
  target_group_arns         = [aws_lb_target_group.external_tg.arn]
  health_check_type         = "EC2"
  health_check_grace_period = 300

  launch_template {
    id      = aws_launch_template.frontend.id
    version = "$Latest"
  }

  enabled_metrics = ["GroupDesiredCapacity", "GroupInServiceInstances", "GroupMaxSize", "GroupMinSize", "GroupPendingInstances", "GroupStandbyInstances", "GroupTerminatingInstances", "GroupTotalInstances"]


  tag {
    key                 = "Name"
    value               = "${var.environment}-${var.project}-frontend-asg-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_policy" "frontend_cpu" {
  name                   = "${var.environment}-${var.project}-frontend-cpu-policy"
  autoscaling_group_name = aws_autoscaling_group.frontend_asg.name
  policy_type            = "TargetTrackingScaling"


  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = 50.0
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_cpu_high" {
  alarm_name          = "${var.environment}-${var.project}-frontend-cpu-high"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "CPUUtilization"
  namespace           = "AWS/EC2"
  period              = 120
  statistic           = "Average"
  threshold           = 80
  alarm_description   = "This metric monitors ec2 cpu utilization"
  alarm_actions       = [var.alarm_action_arn]
  dimensions = {
    AutoScalingGroupName = aws_autoscaling_group.frontend_asg.name
  }
}

resource "aws_cloudwatch_metric_alarm" "frontend_unhealthy" {
  alarm_name          = "${var.environment}-${var.project}-frontend-unhealthy"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = 2
  metric_name         = "UnhealthyHostCount"
  namespace           = "AWS/ApplicationELB"
  period              = 120
  statistic           = "Average"
  threshold           = 0
  alarm_description   = "This metric monitors unhealthy hosts in the target group"
  alarm_actions       = [var.alarm_action_arn]
  dimensions = {
    TargetGroup  = aws_lb_target_group.external_tg.arn_suffix
    LoadBalancer = aws_lb.external_alb.arn_suffix
  }

  tags = var.tags
}
