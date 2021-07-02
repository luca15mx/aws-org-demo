provider "aws" {
  alias  = "master"
  region = "us-east-1"
}

provider "aws" {
  alias  = "invited"
  region = "us-east-1"
}
