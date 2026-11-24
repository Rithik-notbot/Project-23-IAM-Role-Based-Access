output "ec2_instance_id" {
  description = "ID of the EC2 test server"
  value       = aws_instance.s3_test_server.id
}

output "ec2_private_ip" {
  description = "Private IP address of the EC2 test server"
  value       = aws_instance.s3_test_server.private_ip
}

output "iam_role_name" {
  description = "Name of the EC2 IAM role"
  value       = aws_iam_role.ec2_s3_role.name
}

output "instance_profile_name" {
  description = "Name of the EC2 IAM instance profile"
  value       = aws_iam_instance_profile.ec2_s3_profile.name
}