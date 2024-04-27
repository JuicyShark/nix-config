{ ... }:
{
  programs.nixvim.keymaps = [
    {
  		mode = "n";
  		key = "<leader>ff";
  		options.silent = true;
  		action = "<cmd>Telescope find_files<CR>";
  	}
  	{
  		mode = "n";
  		key = "<leader>.";
  		options.silent = true;
  		action = "<cmd>Explore<CR>";
  	}
  	{	
  		mode = "n";
  		key = "<leader>/";
  		options.silent = true;
  		action = "<cmd> Telescope find_files<CR>";
	  }
	  {  
	  	mode = "n";
	  	key = "<leader>ot";
	  	options.silent = true;
	  	action = "<cmd>ObsidianToday<CR>";
	  } 
	  {
	  	mode = "n";
	  	key = "<leader>on";
	  	options.silent = true;
	  	action = "<cmd>ObsidianNew<CR>";
	  }
	  {
	  	mode = "n";
	  	key = "<leader>o.";
	  	options.silent = true;
	  	action = "<cmd>ObsidianSearch<CR>";
	  } 
	  {
	  	mode = "n";
	  	key = "<leader>of";
		  options.silent = true;
		  action = "<cmd>ObsidianFollowLink<CR>";
  	}
  	{
  		mode = "n";
  		key = "<leader>ob";
  		options.silent = true;
  		action = "<cmd>ObsidianBacklinks<CR>";
  	}
  	{
  		mode = "n";
  		key = "<leader>oo";
  		options.silent = true;
	  	action = "<cmd>ObsidianOpen<CR>";
	  }
	  {
		mode = "n";
  		key = "<Down>";
  		options.silent = false;
  		options.noremap = true;
  		action = "gj";
  	}
  	{
  		mode = "n";
  		key = "<Up>";
  		options.silent = false;
  		options.noremap = true;
  		action = "gk";
  	}
  	{
  		mode = "n";
  		key = ":split";
  		options.silent = false;
  		options.noremap = true;
  		action = ":lua OpenWithRustScript()<CR>";
  	}
  	{
  		mode = "n";
  		key = ":vsplit";
  		options.silent = false;
  		options.noremap = true;
  		action = ":lua OpenWithRustScript()<CR>";
  	}
  ];
}
