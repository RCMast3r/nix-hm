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
    vscode.enable = true;
    vscode.profiles.default = {
      extensions = [
        pkgs.vscode-extensions.eamodio.gitlens
        pkgs.vscode-extensions.ms-python.vscode-pylance
        pkgs.vscode-extensions.ms-python.black-formatter
        pkgs.vscode-extensions.ms-python.python
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
      ] ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
        {
          name = "cpp-helper";
          publisher = "amiralizadeh9480";
          version = "0.3.4";
          sha256 = "sha256-TXvKciewjm/Mw6t60Z56C5yjujfONO/gLuijctkvCzg=";
        }
        {
          name = "cmake-language-support-vscode";
          publisher = "josetr";
          version = "0.0.9";
          sha256 = "sha256-LNtXYZ65Lka1lpxeKozK6LB0yaxAjHsfVsCJ8ILX8io=";
        }
        {
          name = "doc-doxygen";
          publisher = "dusartvict";
          version = "0.3.16";
          sha256 = "sha256-33zA0ya0MFfNnusR8Ro75weOwTLv1ksXOtiGp9hArzI=";
        }
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
      profiles.default.userSettings = {
        "files.userSettings" = "on";
        "files.autoSave" = "afterDelay";
        "cmake.configureOnOpen" = false;
        "editor.minimap.enabled" = false;
        "window.zoomLevel" = 1;
        "[python]" = { "editor.defaultFormatter" = "ms-python.black-formatter"; };
        "terminal.external.linuxExec" = "/bin/bash";
      };
    };
  };
}