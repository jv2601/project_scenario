output "aws_internal_ip" {
  value = aws_instance.plex.private_ip
}

output "aws_public_ip" {
  value = aws_instance.plex.public_ip
}
