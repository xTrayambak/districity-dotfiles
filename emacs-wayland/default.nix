{ pkgs, inputs, ... }:
{
	home.packages = with pkgs; [
		emacs29-pgtk
		nimlsp
		tree-sitter
		fzf
		lua-language-server
		nixd
		gopls
		llvmPackages_15.clang-unwrapped
		python311Packages.jedi-language-server
		nodePackages_latest.grammarly-languageserver
		nodePackages_latest.vscode-langservers-extracted
		nodePackages_latest.bash-language-server
		nodePackages_latest.yaml-language-server
	];
	xdg.configFile = {
		"emacs/early-init.el".source = "${inputs.self}/setup/emacs/early-init.el";
		"emacs/init.el".source = "${inputs.self}/setup/emacs/init.el";
    		"emacs/config.org".source = "${inputs.self}/setup/emacs/config.org";
	};
}
