{ config, pkgs, lib, ... }:

{

  programs.plasma = {
    enable = true;

    shortcuts = {
      "Alacritty.desktop"."New" = "Meta+Return";
      "kwin"."ExposeAll" = ["Meta+Space" "Ctrl+F10"];
      "kwin"."Overview" = "Meta+W";
      "kwin"."PoloniumCycleLayouts" = "Meta+\\,none";
      "kwin"."PoloniumFocusAbove" = "Meta+K";
      "kwin"."PoloniumFocusBelow" = "Meta+J";
      "kwin"."PoloniumFocusLeft" = "Meta+H";
      "kwin"."PoloniumFocusRight" = "Meta+L";
      "kwin"."PoloniumInsertAbove" = "Meta+Shift+K";
      "kwin"."PoloniumInsertBelow" = "Meta+Shift+J";
      "kwin"."PoloniumInsertLeft" = "Meta+Shift+H";
      "kwin"."PoloniumInsertRight" = "Meta+Shift+L";
      "kwin"."PoloniumRebuildLayout" = "Meta+Ctrl+Space";
      "kwin"."PoloniumResizeTileDown" = "Meta+Shift+Down";
      "kwin"."PoloniumResizeTileLeft" = "Meta+Shift+Left";
      "kwin"."PoloniumResizeTileRight" = "Meta+Shift+Right";
      "kwin"."PoloniumResizeTileUp" = "Meta+Shift+Up";
      "kwin"."PoloniumRetileWindow" = "Meta+Shift+Space";
      "kwin"."PoloniumShowSettings" = "Meta+|";
      "kwin"."PoloniumSwapAbove" = "Meta+Ctrl+K";
      "kwin"."PoloniumSwapBelow" = "Meta+Ctrl+J";
      "kwin"."PoloniumSwapLeft" = "Meta+Ctrl+H";
      "kwin"."PoloniumSwapRight" = "Meta+Ctrl+L";
      "kwin"."Switch One Desktop to the Left" = "Meta+Ctrl+Left";
      "kwin"."Switch One Desktop to the Right" = "Meta+Ctrl+Right";
      "kwin"."Switch Window Down" = "Meta+Alt+Down";
      "kwin"."Switch Window Left" = "Meta+Alt+Left";
      "kwin"."Switch Window Right" = "Meta+Alt+Right";
      "kwin"."Switch Window Up" = "Meta+Alt+Up";
      "kwin"."Switch to Desktop 1" = ["Ctrl+F1" "Meta+1"];
      "kwin"."Switch to Desktop 2" = ["Ctrl+F2" "Meta+2"];
      "kwin"."Switch to Desktop 3" = ["Ctrl+F3" "Meta+3"];
      "kwin"."Walk Through Windows" = "Alt+Tab";
      "kwin"."Walk Through Windows (Reverse)" = "Alt+Shift+Backtab";
      "kwin"."Window Close" = ["Meta+Shift+Q" "Alt+F4"];
      "kwin"."Window Maximize" = "Meta+PgUp";
      "kwin"."Window Minimize" = "Meta+PgDown";
      "kwin"."Window Quick Tile Bottom" = "Meta+Down";
      "kwin"."Window Quick Tile Left" = "Meta+Left";
      "kwin"."Window Quick Tile Right" = "Meta+Right";
      "kwin"."Window Quick Tile Top" = "Meta+Up";
      "kwin"."Window to Desktop 1" = "Meta+!";
      "kwin"."Window to Desktop 2" = "Meta+@";
      "kwin"."Window to Desktop 3" = "Meta+#";
      "org.kde.dolphin.desktop"."_launch" = "Meta+E";
      "org.kde.krunner.desktop"."_launch" = ["Alt+Space" "Search" "Meta+D" "Alt+F2"];
      "org.kde.spectacle.desktop"."ActiveWindowScreenShot" = "Meta+Print";
      "org.kde.spectacle.desktop"."FullScreenScreenShot" = "Shift+Print";
      "org.kde.spectacle.desktop"."RectangularRegionScreenShot" = "Meta+Shift+Print";
      "org.kde.spectacle.desktop"."WindowUnderCursorScreenShot" = "Meta+Ctrl+Print";
    };


    configFile = {
      "kcminputrc"."Libinput.2362.628.PIXA3854:00 093A:0274 Touchpad"."ClickMethod" = 2;
      "kcminputrc"."Libinput.2362.628.PIXA3854:00 093A:0274 Touchpad"."NaturalScroll" = true;

      "kscreenlockerrc"."Greeter.Wallpaper.org.kde.image.General"."Image" = "../../assets/space-cowboy.png";
      "kscreenlockerrc"."Greeter.Wallpaper.org.kde.image.General"."PreviewImage" = "../../assets/space-cowboy.png";
      "ksplashrc"."KSplash"."Engine" = "none";
      "kwalletrc"."Wallet"."First Use" = false;
      "kwinrc"."Desktops"."Number" = 3;
      "kwinrc"."Desktops"."Rows" = 1;
      "kwinrc"."NightColor"."Active" = true;
      "kwinrc"."Plugins"."poloniumEnabled" = true;
      "kwinrc"."Script-polonium"."Borders" = 3;
      "kwinrc"."Script-polonium"."InsertionPoint" = 1;
      "kwinrc"."Script-polonium"."TimerDelay" = 7;
      "kwinrulesrc"."0851dfa1-5227-4f19-8a05-1d8de3765ad8"."Description" = "Application settings for Alacritty";
      "kwinrulesrc"."0851dfa1-5227-4f19-8a05-1d8de3765ad8"."noborderrule" = 3;
      "kwinrulesrc"."0851dfa1-5227-4f19-8a05-1d8de3765ad8"."wmclass" = "alacritty Alacritty";
      "kwinrulesrc"."0851dfa1-5227-4f19-8a05-1d8de3765ad8"."wmclasscomplete" = true;
      "kwinrulesrc"."0851dfa1-5227-4f19-8a05-1d8de3765ad8"."wmclassmatch" = 1;
      "kwinrulesrc"."1"."Description" = "Application settings for Alacritty";
      "kwinrulesrc"."1"."noborder" = true;
      "kwinrulesrc"."1"."noborderrule" = 2;
      "kwinrulesrc"."1"."types" = 1;
      "kwinrulesrc"."1"."wmclass" = "Alacritty";
      "kwinrulesrc"."1"."wmclassmatch" = 1;
      "kwinrulesrc"."1a0bdb84-9c97-40c2-bd48-eb890bfc6d33"."Description" = "Application settings for Alacritty";
      "kwinrulesrc"."1a0bdb84-9c97-40c2-bd48-eb890bfc6d33"."noborderrule" = 2;
      "kwinrulesrc"."1a0bdb84-9c97-40c2-bd48-eb890bfc6d33"."wmclass" = "Alacritty";
      "kwinrulesrc"."1a0bdb84-9c97-40c2-bd48-eb890bfc6d33"."wmclassmatch" = 1;
      "kwinrulesrc"."2"."Description" = "Ignore Requested Geometry";
      "kwinrulesrc"."2"."ignoregeometryrule" = 2;
      "kwinrulesrc"."2"."types" = 1;
      "kwinrulesrc"."21ac7470-6e94-494e-9852-c71a39bf8458"."Description" = "Window settings for Alacritty";
      "kwinrulesrc"."21ac7470-6e94-494e-9852-c71a39bf8458"."noborderrule" = 2;
      "kwinrulesrc"."21ac7470-6e94-494e-9852-c71a39bf8458"."title" = "coryc@nixpc:~";
      "kwinrulesrc"."21ac7470-6e94-494e-9852-c71a39bf8458"."types" = 1;
      "kwinrulesrc"."21ac7470-6e94-494e-9852-c71a39bf8458"."wmclass" = "Alacritty";
      "kwinrulesrc"."21ac7470-6e94-494e-9852-c71a39bf8458"."wmclasscomplete" = true;
      "kwinrulesrc"."21ac7470-6e94-494e-9852-c71a39bf8458"."wmclassmatch" = 1;
      "kwinrulesrc"."3a85c80a-9fdb-456c-87b8-2b237ce38912"."Description" = "Ignore Requested Geometry";
      "kwinrulesrc"."3a85c80a-9fdb-456c-87b8-2b237ce38912"."ignoregeometryrule" = 2;
      "kwinrulesrc"."3a85c80a-9fdb-456c-87b8-2b237ce38912"."types" = 1;
      "kwinrulesrc"."9bcb3a01-ac24-413b-95b3-a41e4d513efe"."Description" = "Window settings for Alacritty";
      "kwinrulesrc"."9bcb3a01-ac24-413b-95b3-a41e4d513efe"."noborderrule" = 2;
      "kwinrulesrc"."9bcb3a01-ac24-413b-95b3-a41e4d513efe"."title" = "coryc@nixpc:~";
      "kwinrulesrc"."9bcb3a01-ac24-413b-95b3-a41e4d513efe"."types" = 1;
      "kwinrulesrc"."9bcb3a01-ac24-413b-95b3-a41e4d513efe"."wmclass" = "alacritty Alacritty";
      "kwinrulesrc"."9bcb3a01-ac24-413b-95b3-a41e4d513efe"."wmclasscomplete" = true;
      "kwinrulesrc"."9bcb3a01-ac24-413b-95b3-a41e4d513efe"."wmclassmatch" = 1;
      "kwinrulesrc"."General"."count" = 2;
      "kwinrulesrc"."General"."rules" = "1,2";
      "plasmarc"."Wallpapers"."usersWallpapers" = "/home/coryc/dotfiles/assets/stag-wallpaper-uw.jpg";
      "systemsettingsrc"."KFileDialog Settings"."detailViewIconSize" = 16;
    };
  };
}
