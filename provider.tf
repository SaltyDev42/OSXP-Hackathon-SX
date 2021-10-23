terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.63"
    }
    local = {
      source  = "hashicorp/local"
      version = "2.1.0"
    }
  }
}

provider "local" {
  ## nothing to add 
}

provider "aws" {
  region  = var.region
  profile = "default"
}
