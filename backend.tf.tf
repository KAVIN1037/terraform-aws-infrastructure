terraform {
  backend "s3" {
    bucket       = "kavin-terraform-state-634393785817"
    key          = "terraform/project-03/terraform.tfstate"
    region       = "us-east-1"
    use_lockfile = true
    encrypt      = true
  }
}