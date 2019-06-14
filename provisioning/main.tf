variable "app_name" {}
variable "access_key" {}
variable "secret_key" {}
variable "db_user" {}
variable "db_pass" {}
variable "region" { default = "ap-northeast-1" }

terraform {
  backend "s3" {
    bucket  = "uetomae-expd"
    key     = "expd-boilerplate.terraform.tfstate"
    region  = "ap-northeast-1"
  }
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "base" {
  app_name = "${var.app_name}"
  db_user  = "${var.db_user}"
  db_pass  = "${var.db_pass}"
  region   = "${var.region}"
  source   = "./modules"
}
