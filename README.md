# Project 23 — IAM Role-Based Access

## Objective
Configure an AWS IAM role for an EC2 instance so it can access a specific S3 bucket without storing AWS access keys.

## Tools Used
- AWS
- Terraform
- Amazon EC2
- AWS IAM
- Amazon S3

## Implementation
1. Define an IAM role trusted by the EC2 service.
2. Create a least-privilege IAM policy allowing `s3:ListBucket`, `s3:GetObject`, and `s3:PutObject` on one specified bucket.
3. Attach the role to an EC2 instance through an IAM instance profile.
4. Launch an Amazon Linux 2023 test instance in an approved existing VPC and subnet.
5. Verify S3 access from the instance using the AWS CLI.

## Security
- No long-lived AWS access keys are stored on the EC2 instance.
- S3 permissions are scoped to the configured bucket.
- The EC2 security group has no inbound rules.
- Deployment requires company approval and approved network and bucket details.

## Files
- `versions.tf` — Terraform and AWS provider configuration.
- `variables.tf` — Required VPC, subnet, and S3 bucket variables.
- `main.tf` — IAM role, policy, instance profile, security group, and EC2 instance.
- `outputs.tf` — EC2 and IAM outputs.
- `terraform.tfvars.example` — Placeholder configuration.
- `.gitignore` — Excludes Terraform state and sensitive files.

## Status

- Terraform configuration prepared.
- EC2 IAM role and instance profile configured.
- S3 permissions configured for bucket listing and object read/write.
- EC2 security group configured without inbound access.
- Amazon Linux AMI filter corrected.
- Terraform formatting completed.
- Terraform validation successful.
- AWS deployment and live S3 access testing pending account access and approval.
- EC2-to-S3 verification evidence pending.

## Deliverables
- Terraform source code in GitHub.
- EC2 instance with attached IAM role.
- Successful S3 CLI access test from the EC2 instance.
- Evidence screenshots of the role and access test.