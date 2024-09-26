# Emacs configuration

My emacs configuration, written in elisp and packaged with nix.

## Usage

```nix
# flake.nix
{
  inputs.emacs-config = {
	url = "github:LilleAila/emacs-nix";
	inputs.nixpkgs.follows = "nixpkgs";
  };
}
```

```nix
# home.nix
{ pkgs, inputs, ... }: {
	home.packages = [
		(inputs.emacs-config.packages.${pkgs.system}.default.override { inherit (config) colorScheme; })
	];
}
```
