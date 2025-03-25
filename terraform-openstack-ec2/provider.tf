terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Local state for now; can be switched to remote later
  backend "local" {
    path = "terraform.tfstate"
  }
}

provider "aws" {
  region = var.region
}