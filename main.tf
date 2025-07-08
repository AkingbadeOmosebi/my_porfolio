#This is your standard provider block from registry.terraform docs

terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "6.2.0"
    }
  }
}