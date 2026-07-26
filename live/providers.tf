# The provider reads CLOUDFLARE_API_TOKEN from the environment. Do not add an
# api_token argument here — that is how tokens end up in git.
provider "cloudflare" {}

variable "account_id" {
  description = "Cloudflare account id"
  type        = string

  # Taken from existing notes; verify with
  #   curl -s -H "Authorization: Bearer $CLOUDFLARE_API_TOKEN" \
  #     https://api.cloudflare.com/client/v4/accounts | jq '.result[].id'
  # A zone-scoped token returns zero accounts here, which is a false negative —
  # it does not mean the id is wrong.
  default = "00000000000000000000000000000002"
}

# The public IP of aws.example.com. This is aws_eip.aws_node in the aws-iac
# repo, where it is guarded with prevent_destroy. Hardcoded deliberately: wiring
# terraform_remote_state across two roots to read one string costs more than it
# is worth. If the EIP ever changes, change it here too.
variable "aws_node_ip" {
  description = "EIP of the aws node (aws-iac: aws_eip.aws_node)"
  type        = string
  default     = "192.0.2.10"
}
