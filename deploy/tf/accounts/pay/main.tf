terraform {
  backend "s3" {
    bucket  = "circle-tf-pay-us-east-1"
    key     = "fluentd-kubernetes-daemonset"
    region  = "us-east-1"
    encrypt = "true"
    dynamodb_table = "circle-tf-pay-lock-us-east-1"
  }
}

module "codepipeline" {
  source = "git@github.com:circlefin/circle-terraform//lib/codepipeline-single-build"

  region                      = "us-east-1"
  account                     = "pay"
  github_oauth_secret_id      = "arn:aws:secretsmanager:us-east-1:908968368384:secret:/ops/utilities/github/oauth"
  github_oauth_secret_id_path = "GitHubOAuthToken"
  name                        = "fluentd-kubernetes-daemonset"
  owner                       = "circlefin"
  repo                        = "fluentd-kubernetes-daemonset"
  vpc_id                      = "vpc-241d1646"
  vpc_subnets                 = ["subnet-9ed3a7b6", "subnet-43b09b37"]
}
