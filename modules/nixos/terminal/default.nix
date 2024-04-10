{pkgs, ...}:
{
	environment.systemPackages = with pkgs; [
		peaclock
		cmatrix
		pipes
		cava
		fd
		ripgrep
		fzf
		glfw
		ffmpeg 
		eza
		speedtest-cli
		yt-dlp
		tldr
		bottom
		yazi
		btop
		zellij
	];
}
