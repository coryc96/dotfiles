{ config, pkgs, ... }:

{
    programs.walker = {
      enable = true;
      runAsService = false; # Or false, as you prefer

      # Assign the Nix attribute set directly here
      config = {
        # Top-level settings
        app_launch_prefix = "uwsm app -- ";
        terminal_title_flag = "";
        locale = "";
        close_when_open = true;
        theme = "default";
        monitor = "";
        hotreload_theme = false;
        as_window = false;
        timeout = 0;
        disable_click_to_close = false;
        force_keyboard_focus = false;

        # [keys] section
        keys = {
          accept_typeahead = [ "tab" ];
          trigger_labels = "lctrl";
          next = [ "down" ];
          prev = [ "up" ];
          close = [ "esc" ];
          remove_from_history = [ "shift backspace" ];
          resume_query = [ "ctrl r" ];
          toggle_exact_search = [ "ctrl m" ];

          # [keys.activation_modifiers] subsection
          activation_modifiers = {
            keep_open = "shift";
            alternate = "alt";
          };

          # [keys.ai] subsection
          ai = {
            clear_session = [ "ctrl x" ];
            copy_last_response = [ "ctrl c" ];
            resume_session = [ "ctrl r" ];
            run_last_response = [ "ctrl e" ];
          };
        };

        # [events] section
        events = {
          on_activate = "";
          on_selection = "";
          on_exit = "";
          on_launch = "";
          on_query_change = "";
        };

        # [list] section
        list = {
          dynamic_sub = true;
          keyboard_scroll_style = "emacs";
          max_entries = 50;
          show_initial_entries = true;
          single_click = true;
          visibility_threshold = 20;
          placeholder = "No Results";
        };

        # [search] section
        search = {
          argument_delimiter = "#";
          placeholder = "Search...";
          delay = 0;
          resume_last_query = false;
        };

        # [activation_mode] section
        activation_mode = {
          labels = "jkl;asdf";
        };

        applications = {
            cache = false;
        };
        # [builtins] section (contains all subsections like builtins.applications)
        builtins = {
          applications = {
            weight = 5;
            name = "applications";
            placeholder = "Applications";
            prioritize_new = true;
            hide_actions_with_empty_query = true;
            context_aware = true;
            refresh = true;
            show_sub_when_single = true;
            show_icon_when_single = true;
            show_generic = true;
            history = false;

            actions = {
              enabled = true;
              hide_category = false;
              hide_without_query = true;
            };
          };

          bookmarks = {
            weight = 5;
            placeholder = "Bookmarks";
            name = "bookmarks";
            icon = "bookmark";
            switcher_only = true;
            # [[builtins.bookmarks.entries]] becomes a list of attrsets
            entries = [ {
                label = "Walker";
                url = "https://github.com/abenz1267/walker";
                keywords = [ "walker" "github" ];
              }
              # Add more entries here if needed
            ];
          };

          xdph_picker = {
            hidden = true;
            weight = 5;
            placeholder = "Screen/Window Picker";
            show_sub_when_single = true;
            name = "xdphpicker";
            switcher_only = true;
          };

          ai = {
            weight = 5;
            placeholder = "AI";
            name = "ai";
            icon = "help-browser";
            switcher_only = true;
            show_sub_when_single = true;

            # Note the structure for nested arrays like anthropic.prompts
            anthropic = {
               # [[builtins.ai.anthropic.prompts]] becomes a list of attrsets
              prompts = [
                {
                  model = "claude-3-7-sonnet-20250219";
                  temperature = 1.0; # Nix uses floating point for this
                  max_tokens = 1000; # Nix doesn't use _ in numbers
                  label = "General Assistant";
                  prompt = "You are a helpful general assistant. Keep your answers short and precise.";
                }
                # Add more prompts here if needed
              ];
            };
          };

          calc = {
            require_number = true;
            weight = 5;
            name = "calc";
            icon = "accessories-calculator";
            placeholder = "Calculator";
            min_chars = 4;
          };

          windows = {
            weight = 5;
            icon = "view-restore";
            name = "windows";
            placeholder = "Windows";
            show_icon_when_single = true;
          };

          clipboard = {
            always_put_new_on_top = true;
            exec = "wl-copy";
            weight = 5;
            name = "clipboard";
            avoid_line_breaks = true;
            placeholder = "Clipboard";
            image_height = 300;
            max_entries = 10;
            switcher_only = true;
          };

          commands = {
            weight = 5;
            icon = "utilities-terminal";
            switcher_only = true;
            name = "commands";
            placeholder = "Commands";
          };

          custom_commands = {
            weight = 5;
            icon = "utilities-terminal";
            name = "custom_commands";
            placeholder = "Custom Commands";
          };

          emojis = {
            exec = "wl-copy";
            weight = 5;
            name = "emojis";
            placeholder = "Emojis";
            switcher_only = true;
            history = true;
            typeahead = true;
            show_unqualified = false;
          };

          symbols = {
            after_copy = "";
            weight = 5;
            name = "symbols";
            placeholder = "Symbols";
            switcher_only = true;
            history = true;
            typeahead = true;
          };

          finder = {
            use_fd = false;
            fd_flags = "--ignore-vcs --type file";
            weight = 5;
            icon = "file";
            name = "finder";
            placeholder = "Finder";
            switcher_only = true;
            ignore_gitignore = true;
            refresh = true;
            concurrency = 8;
            show_icon_when_single = true;
            preview_images = false;
          };

          runner = {
            eager_loading = true;
            weight = 5;
            icon = "utilities-terminal";
            name = "runner";
            placeholder = "Runner";
            typeahead = true;
            history = true;
            generic_entry = false;
            refresh = true;
            use_fd = false;
          };

          ssh = {
            weight = 5;
            icon = "preferences-system-network";
            name = "ssh";
            placeholder = "SSH";
            switcher_only = true;
            history = true;
            refresh = true;
          };

          switcher = {
            weight = 5;
            name = "switcher";
            placeholder = "Switcher";
            prefix = "/";
          };

          websearch = {
            keep_selection = true;
            weight = 5;
            icon = "applications-internet";
            name = "websearch";
            placeholder = "Websearch";
            # [[builtins.websearch.entries]] becomes a list of attrsets
            entries = [
              {
                name = "Google";
                url = "https://www.google.com/search?q=%TERM%";
              }
              {
                name = "DuckDuckGo";
                url = "https://duckduckgo.com/?q=%TERM%";
                switcher_only = true;
              }
              {
                name = "Ecosia";
                url = "https://www.ecosia.org/search?q=%TERM%";
                switcher_only = true;
              }
              {
                name = "Yandex";
                url = "https://yandex.com/search/?text=%TERM%";
                switcher_only = true;
              }
              # Add more entries here if needed
            ];
          };

          dmenu = {
            hidden = true;
            weight = 5;
            name = "dmenu";
            placeholder = "Dmenu";
            switcher_only = true;
            show_icon_when_single = true;
          };

          translation = {
            delay = 1000;
            weight = 5;
            name = "translation";
            icon = "accessories-dictionary";
            placeholder = "Translation";
            switcher_only = true;
            provider = "googlefree";
          };
        }; # End of builtins section
      }; # End of programs.walker.config
    }; # End of programs.walker
}
