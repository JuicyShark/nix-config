{ inputs, pkgs, ...} :
{
	imports = [
	inputs.nixvim.homeManagerModules.nixvim
	./nixvim.nix
	];
}
