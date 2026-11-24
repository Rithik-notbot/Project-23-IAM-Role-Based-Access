data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-2023.*-kernel-*-x86_64"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

resource "aws_iam_role" "ec2_s3_role" {
  name = "project-23-ec2-s3-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
        Action = "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name      = "Project-23-EC2-S3-Role"
    ManagedBy = "Terraform"
  }
}

resource "aws_iam_role_policy" "s3_access" {
  name = "project-23-s3-access"
  role = aws_iam_role.ec2_s3_role.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "s3:ListBucket"
        ]
        Resource = "arn:aws:s3:::${var.s3_bucket_name}"
      },
      {
        Effect = "Allow"
        Action = [
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource = "arn:aws:s3:::${var.s3_bucket_name}/*"
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = "project-23-ec2-s3-profile"
  role = aws_iam_role.ec2_s3_role.name
}

resource "aws_security_group" "ec2" {
  name        = "project-23-ec2-sg"
  description = "No inbound access; allow outbound traffic"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name      = "Project-23-EC2-Security-Group"
    ManagedBy = "Terraform"
  }
}

resource "aws_instance" "s3_test_server" {
  ami                    = data.aws_ami.amazon_linux.id
  instance_type          = "t2.micro"
  subnet_id              = var.subnet_id
  vpc_security_group_ids = [aws_security_group.ec2.id]
  iam_instance_profile   = aws_iam_instance_profile.ec2_s3_profile.name

  tags = {
    Name        = "Project-23-S3-Role-Test-Server"
    Environment = "Testing"
    ManagedBy   = "Terraform"
  }
}