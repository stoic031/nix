{
	description = "Andy nix";
	inputs = {
		nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
		nix-darwin = {
			url = "github:LnL7/nix-darwin";
			inputs.nixpkgs.follows = "nixpkgs";
		};	
		mac-app-util.url = "github:hraban/mac-app-util";
		home-manager = {
			url = "github:nix-community/home-manager/master";
			inputs.nixpkgs.follows = "nixpkgs";
		};
		nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";

	};
	
	outputs = inputs@{
		self,
		nix-darwin,
		nixpkgs,
		mac-app-util,
		home-manager,
		nix-homebrew,
		...
	}:{

	# ── Mac ──────────────────────────────────────────
	darwinConfigurations."Andys-MacBook-Pro" = nix-darwin.lib.darwinSystem {
    		system = "aarch64-darwin";
    		specialArgs = { inherit inputs; };
    		modules = [ ./hosts/mac/default.nix
			mac-app-util.darwinModules.default
			home-manager.darwinModules.home-manager {
        		home-manager.useGlobalPkgs = true;
        		home-manager.useUserPackages = true;
        		home-manager.backupFileExtension = "backup";
        		home-manager.users.andy = import ./home/default.nix;        					   }
		];
  	};
	# ── NixOS PC ─────────────────────────────────────


};
		



}
