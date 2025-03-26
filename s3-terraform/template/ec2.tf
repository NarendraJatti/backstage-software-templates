resource "aws_instance" "web_server" {
  ami           = "ami-0c7217cdde317cfec"  # Amazon Linux 2023 AMI in us-east-1
  instance_type = "t2.micro"
  key_name      = "your-key-pair-name"     # Replace with your EC2 key pair name

  tags = {
    Name        = "BackstageWebServer"
    Environment = "Production"
    ManagedBy   = "Terraform"
  }

  # Basic security group allowing SSH and HTTP
  vpc_security_group_ids = [aws_security_group.web_sg.id]
}

resource "aws_security_group" "web_sg" {
  name        = "web_server_sg"
  description = "Allow SSH and HTTP traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  # Warning: This allows SSH from anywhere
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "ec2_public_ip" {
  value = aws_instance.web_server.public_ip
}
