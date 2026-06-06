{
  config,
  lib,
  pkgs,
  ...
}:
{
  options = {
    vscode-settings.enable = lib.mkOption {
      type = lib.types.bool;
      default = false;
      description = "Enable or disable vscode with shared settings";
    };
  };

  config = lib.mkIf config.vscode-settings.enable {
    
    programs.vscode.enable = true;
    programs.vscode.profiles.default = {
      extensions = [
        pkgs.vscode-extensions.eamodio.gitlens
        pkgs.vscode-extensions.ms-vscode-remote.remote-ssh
        pkgs.vscode-extensions.twxs.cmake
        pkgs.vscode-extensions.ms-vscode.cmake-tools
        pkgs.vscode-extensions.shd101wyy.markdown-preview-enhanced
        pkgs.vscode-extensions.llvm-vs-code-extensions.vscode-clangd
        pkgs.vscode-extensions.xaver.clang-format
        pkgs.vscode-extensions.jnoortheen.nix-ide
        pkgs.vscode-extensions.vscodevim.vim
        pkgs.vscode-extensions.rust-lang.rust-analyzer
        pkgs.vscode-extensions.marp-team.marp-vscode
        pkgs.vscode-extensions.dhall.dhall-lang
      ];

      keybindings = [
        {
          key = "ctrl+shift+x";
          command = "-workbench.view.extensions";
          when = "viewContainer.workbench.view.extensions.enabled";
        }
        {
          key = "ctrl+shift+x";
          command = "workbench.action.closeActiveEditor";
        }
        {
          key = "ctrl+w";
          command = "-workbench.action.closeActiveEditor";
        }
        {
          key = "ctrl+shift+tab";
          command = "-workbench.action.quickOpenNavigatePreviousInEditorPicker";
          when = "inEditorsPicker && inQuickOpen";
        }
        {
          key = "ctrl+shift+tab";
          command = "-workbench.action.quickOpenLeastRecentlyUsedEditorInGroup";
          when = "!activeEditorGroupEmpty";
        }
        {
          key = "ctrl+shift+tab";
          command = "workbench.action.previousEditor";
        }
        {
          key = "ctrl+pageup";
          command = "-workbench.action.previousEditor";
        }
        {
          key = "ctrl+tab";
          command = "workbench.action.nextEditor";
        }
        {
          key = "ctrl+pagedown";
          command = "-workbench.action.nextEditor";
        }
      ];
      userSettings = {
        "files.userSettings" = "on";
        "files.autoSave" = "afterDelay";
        "cmake.configureOnOpen" = false;
        "editor.minimap.enabled" = false;
        "window.zoomLevel" = 1;
        "[python]" = { "editor.defaultFormatter" = "ms-python.black-formatter"; };
        "terminal.external.linuxExec" = "/bin/bash";
        "workbench.secondarySideBar.defaultVisibility"= "hidden";
        "workbench.colorTheme" = "Dark+";
      };
    };
  };
}