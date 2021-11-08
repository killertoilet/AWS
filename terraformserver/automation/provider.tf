terraform {
	required_version = ">= 1.0.0"
	required_providers {
		aws = {
			source  = "hashicorp/aws"
			version = ">= 3.59.0"
		}
	}
}
provider "aws" {
region = "us-east-1"
profile = "default"  # From a ~/.aws/credentials file.
}
