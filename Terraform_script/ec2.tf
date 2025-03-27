# EC2 instance for running Python scripts
resource "aws_instance" "data_pipeline" {
  ami                    = data.aws_ami.amazon_linux_2.id
  instance_type          = var.ec2_instance_type
  iam_instance_profile   = aws_iam_instance_profile.ec2_profile.name
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  key_name               = aws_key_pair.ec2_key.key_name

  tags = {
    Name        = "${local.name_prefix}-ec2"
    Environment = var.environment
  }

  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y git python3 pip3
              
              # Clone GitHub repo
              git clone ${var.github_repo} /home/ec2-user/data-pipeline
              
              # Install Python dependencies
              pip3 install -r /home/ec2-user/data-pipeline/requirements.txt
              
              # Set up cron job to run Python script
              (crontab -l 2>/dev/null; echo "0 * * * * python3 /home/ec2-user/data-pipeline/${var.python_script_path}") | crontab -
              EOF
}

# Security group for EC2
resource "aws_security_group" "ec2_sg" {
  name        = "${local.name_prefix}-ec2-sg"
  description = "Security group for data pipeline EC2"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # Restrict this to your IP in production
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name        = "${local.name_prefix}-ec2-sg"
    Environment = var.environment
  }
}

# SSH key pair for EC2
resource "aws_key_pair" "ec2_key" {
  key_name   = "${local.name_prefix}-ec2-key"
  public_key = file("~/.ssh/id_rsa.pub") # Replace with your public key path
}

data "aws_ami" "amazon_linux_2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }

  owners = ["amazon"]
}