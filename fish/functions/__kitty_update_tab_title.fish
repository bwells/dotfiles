function __kitty_update_tab_title --description 'Set kitty TAB title (not window title)'
    test -n "$KITTY_WINDOW_ID"; or return

    set -l title (__project_title)
    # set the TAB title for THIS tab (running inside it)
    kitty @ set-tab-title "$title"
end
