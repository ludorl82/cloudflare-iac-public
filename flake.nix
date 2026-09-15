{
  description = "Cloudflare configuration as code — DNS, Access, Tunnel, Rulesets";

  inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

  outputs = { self, nixpkgs }:
    let
      systems = [ "x86_64-linux" "aarch64-linux" "aarch64-darwin" ];
      forAllSystems = f: nixpkgs.lib.genAttrs systems (system: f nixpkgs.legacyPackages.${system});
    in
    {
      devShells = forAllSystems (pkgs: {
        default = pkgs.mkShell {
          packages = [
            pkgs.opentofu
            pkgs.awscli2 # only for the S3 state backend, not for Cloudflare
            pkgs.curl
            pkgs.jq
          ];

          shellHook = ''
            export AWS_REGION=ca-central-1

            # Git hooks live in hooks/ so they are versioned and shared;
            # .git/hooks is not tracked and would have to be set up by hand.
            if [ -d hooks ] && [ "$(git config --get core.hooksPath || true)" != "hooks" ]; then
              git config core.hooksPath hooks
              echo "enabled pre-commit hook (core.hooksPath=hooks)"
            fi

            if [ -z "''${CLOUDFLARE_API_TOKEN:-}" ]; then
              echo "CLOUDFLARE_API_TOKEN is unset — export it before planning."
              echo "  export CLOUDFLARE_API_TOKEN=\$(kp-get 'Cloudflare General Token')"
            fi
            echo "cloudflare-iac devshell — tofu $(tofu version | head -n1 | cut -d' ' -f2)"
          '';
        };
      });
    };
}
