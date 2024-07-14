{ config, ... }:

{
	programs.starship = {
    enable = true;
    enableNushellIntegration = true;

    settings = {
      add_newline = false;
      scan_timeout = 10;
      command_timeout = 1000;

      prompt = {
        right_format = "[$sudo $fill $cmd_duration $jobs]";
      };
      fill = {
        symbol = " ";
        style = "bold purple";
      };
      jobs = {
        symbol = " ";
      };
      sudo.disabled = true;
      time = {
        disabled = true;
      };

      battery = {
        disabled = true;
      };
      character = {
        success_symbol = "[󰜃 ](green) ";
        error_symbol = "[ ](red)";
      };
      cmd_duration = {
        min_time = 5;
        show_milliseconds = true;
        format = "[󰔟 ](yellow) [$duration](green italic)";
      };
      username = {
        style_user = "bright-blue";
        style_root = "purple";
        format = "[$user]($style) ";
        disabled = false;
        show_always = false;
      };
      hostname = {
        ssh_only = true;
        format = "@ [$hostname](bold purple) ";
        disabled = false;
      };
      directory = {
        home_symbol = "󰋞";
        style = "bright-cyan";
        read_only_style = "197";
        read_only = "  ";
        format = " [$path]($style)[$read_only]($read_only_style) ";
      };
      git_commit.disabled = true;
      git_branch = {
        symbol = " ";
        ignore_branches = ["master"];
        format = "via [$symbol$branch]($style) ";
        style = "bold green";
      };
      git_status = {
        format = "[\($uptodate $conflicted $stash $behind $ahead $modified $ahead_behind\)]($style) ";
        style = "bold green";
        conflicted = "🏳";
        up_to_date = "[](bright-green)";
        untracked = " ";
        ahead = "⇡\${count}(green)";
        diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
        behind = "⇣\${count}(red)";
        stashed = " ";
        modified = "[ ](yellow)";
        staged = "[++\($count\)](bright-green)";
        renamed = "襁 ";
        deleted = "[ ](bright-red)";
      };
		};
	};
}
