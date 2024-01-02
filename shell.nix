{ pkgs ? import <nixpkgs> {} }:

pkgs.mkShell {
    name = "terraform-aws-lambda-docker";
    buildInputs = with pkgs; [
        opentofu
        terraform-docs
        tflint
        tfsec
        awscli2
        pre-commit
    ];
}

