# terraform-aws-remote-state-s3-backend

## What is Does:

- Create a S3 bucket to store remote state files, using a KMS encryption key.
- Enable bucket version to prevent accident losses.
- Create a DynamoDB table for state locking.

## Resource naming

### Suffix: 

    'terraform-remote-state-<region>-<accountid>'
    
### Example

    's3-terraform-remote-state-eu-west-1-123456789'
    'dynamodb-terraform-remote-state-eu-west-1-123456789'

## Usage

```hcl
provider "aws" {}

module "remote_state" {
  source  = "sergioUjo/remote-state-s3-backend/aws"
  tags = {
    cost_center = "myProject"
  }
}

```
