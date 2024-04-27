{ ... }: 
{
  programs.bottom = {
    enable = true;
    settings = {
      flags = {
        cpu_left_legend = true;
        enable_gpu = true;
      };
      processes = {
        columns = [ "Name" "CPU%" "Mem%" "User" "State" ]; 
      };
      cpu = {
        default = "average";
      };
      colors = {
        table_header_color = "Light Magenta";
        widget_title_color = "Light Blue";
        text_color = "Cyan";
        highlighted_border_color = "Light Magenta";
        border_color = "Green";
        graph_color = "Green";
      };
    };
  };
}
