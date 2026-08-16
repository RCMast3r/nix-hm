{
  config,
  lib,
  pkgs,
  ...
}:
let
  # everything the profiles have in common - only the color theme differs
  sharedProfile = {
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
      pkgs.vscode-extensions.drblury.protobuf-vsc
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
      "workbench.secondarySideBar.defaultVisibility" = "hidden";
      "terminal.integrated.scrollback" = 50000;
    };
  };

  mkProfile = colorTheme: sharedProfile // {
    userSettings = sharedProfile.userSettings // {
      "workbench.colorTheme" = colorTheme;
    };
  };
in
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

    # identical profiles apart from the theme. note that having a non-default
    # profile flips programs.vscode.mutableExtensionsDir to false, so
    # extensions can no longer be installed from within vscode itself.
    programs.vscode.profiles.default = mkProfile "Dark+";
    programs.vscode.profiles.light = mkProfile "Light+";
  };
}
