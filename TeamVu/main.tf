provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}

resource "aws_key_pair" "aws_ssh_key" {
  key_name   = "plex"  
  public_key = file(var.public_key_path)
}

resource "aws_vpc" "teamvu" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "teamvu"
  }
}

resource "aws_instance" "plex" {
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = aws_key_pair.aws_ssh_key.key_name  # Using the key pair created above
  subnet_id     = aws_subnet.subnet.id

  tags = {
    Name = "plex"
  }

  provisioner "local-exec" {
    when        = create
    interpreter = ["/bin/bash", "-c"]
    command     = "ansible-playbook -i ${self.public_ip}, /home/administrator/Desktop/Terraform/plexansible.yml"
    working_dir = "/home/administrator/Desktop/Terraform/"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id     = aws_vpc.teamvu.id
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "subnet-1"
  }
}

resource "aws_security_group" "ssh_access" {
  name        = "ssh-access"
  description = "Allow SSH, HTTP, and HTTPS access"
  vpc_id      = aws_vpc.teamvu.id

  // Ingress rule for SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow access from any IP address
  }

  // Ingress rule for HTTP access
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow access from any IP address
  }

  // Ingress rule for HTTPS access
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] // Allow access from any IP address
  }

  // Egress rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] // Allow access to any IP address
  }
}
