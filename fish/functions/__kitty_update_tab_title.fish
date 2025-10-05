function __kitty_update_tab_title --description 'Set kitty tab title from project title (tab only)'
    # Only proceed inside kitty.
    if test -z "$KITTY_WINDOW_ID"
        return
    end

    set -l title (__project_title)

    # Avoid redundant remote calls.
    if test "$KITTY_CURRENT_TAB_TITLE" = "$title"
        return
    end
    set -gx KITTY_CURRENT_TAB_TITLE "$title"

    # Set the tab title (do not touch window title).
    command kitty @ set-tab-title "$title" >/dev/null 2>&1
end
