terraform {
  # Same bucket as aws-iac, different key: one bucket to secure, separate state
  # and separate locks. Note this means the Cloudflare root still needs AWS
  # credentials — for state access only, not for managing anything in AWS.
  backend "s3" {
    bucket = "tfstate-example-com"
    key    = "cloudflare/terraform.tfstate"
    region = "ca-central-1"

    encrypt      = true
    use_lockfile = true
  }
}
