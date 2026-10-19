terraform {
  required_version = ">= 1.10"

  required_providers {
    # v5 is a ground-up rewrite generated from Cloudflare's OpenAPI spec. Resource
    # schemas differ substantially from v4, and most examples you will find online
    # are still v4 and will not apply. Work from the registry docs.
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.0"
    }
  }
}
