terraform {
  backend "s3" {
    bucket = "terraform-tfstate-101"
    key    = "terraform.tfstate"
  }
}

