{ pkgs, ... }: {
  programs.nvf = {
    enable = true;
    settings = {
      vim = {
        # language.nix.enable = true;
        package = pkgs.neovim-unwrapped;
        options = {
          tabstop = 2;
          shiftwidth = 2;
        };
        telescope = {
          enable = true;
        };
        autocomplete.nvim-cmp.enable = true;
        extraPlugins = {
          "monokai-pro-nvim" = with pkgs.vimPlugins; {
            package = monokai-pro-nvim;
            setup = ''
              require("monokai-pro").setup {
                filter = "octagon",
              }
              vim.cmd([[colorscheme monokai-pro]])
            '';
          };
        };
      };
    };
  };
}
