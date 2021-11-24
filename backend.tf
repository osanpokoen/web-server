terraform {
  backend "s3" {
    key    = "web-server/terraform.tfstate"
    region = "ap-northeast-1"
  }
}
