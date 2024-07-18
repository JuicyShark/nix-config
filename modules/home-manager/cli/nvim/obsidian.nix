{ pkgs, config, lib, osConfig, ... }:
{
  programs.nixvim.plugins.obsidian = {
    enable = true;
    settings = {
      dir = "${config.xdg.userDirs.documents}/notes";
      image_name_func = ''
        function()
          -- Prefix image names with timestamp.
          return string.format("%s-", os.time())
          end
      '';
      follow_url_func = ''
        function(url)
          -- Open the URL in the default web browser.
          vim.fn.jobstart({"xdg-open", url})  -- linux
        end
        '';
        note_frontmatter_func = ''
          function(note)
            -- Add the title of the note as an alias.
            if note.title then
              note:add_alias(note.title)
            end

            local out = { id = note.id, aliases = note.aliases, tags = note.tags }

            -- `note.metadata` contains any manually added fields in the frontmatter. So here we just make sure those fields are kept in the frontmatter.
            if note.metadata ~= nil and not vim.tbl_isempty(note.metadata) then
              for k, v in pairs(note.metadata) do
                out[k] = v
              end
            end
            return out
          end
          '';
        note_id_func = ''
          function(title)
            local suffix = ""
            if title ~= nil then
              suffix = title:gsub(" ", "-"):gsub("[^A-Za-z0-9-]", ""):lower()
            else
for _ = 1, 4 do
                suffix = suffix .. string.char(math.random(65, 90))
              end
            end
            return tostring(os.time()) .. "-" .. suffix
          end
          '';
          note_path_func = ''
            function(spec)
              -- This is equivalent to the default behavior.
              local path = spec.dir / tostring(spec.id)
              return path:with_suffix(".md")
            end
          '';
          new_notes_location = "current_dir";
          daily_notes.folder = "journal";
          picker.name = "telescope.nvim";
    };
  };
}

