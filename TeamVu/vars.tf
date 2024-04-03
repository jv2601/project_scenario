variable "region" {
  description = "The AWS region"
  default     = "us-east-2"
}

variable "access_key" {
  description = "AWS Access Key"
  default = "AKIA3FLDZWMXWJUEHPOX"
}

variable "secret_key" {
  description = "AWS Secret Key"
  default = "ZxNj4BAa/8SgElAhCAFQemDvqIRK2XTZ4WbVFr4P"
}

variable "ami_id" {
  description = "The ID of the Amazon Linux 2 AMI"
  default     = "ami-0b8b44ec9a8f90422"
}

variable "instance_type" {
  description = "The type of EC2 instance"
  default     = "t2.micro"
}

variable "public_key_path" {
  description = "Path to the public key file"
  default     = "/home/administrator/.ssh/plex.pub"
}
