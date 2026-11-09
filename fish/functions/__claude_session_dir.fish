function __claude_session_dir --description 'Directory to resume a Claude Code session from: the cwd whose path encodes to its transcript folder'
    # Prompt history can name the repo root while the transcript is filed under a worktree,
    # and `claude --resume` only finds the session from the directory it is filed under.
    set -l cfg ~/.claude
    set -q CLAUDE_CONFIG_DIR; and set cfg $CLAUDE_CONFIG_DIR
    set -l t $cfg/projects/*/$argv[1].jsonl
    set -q t[1]; or return 1
    set -l folder (path basename (path dirname $t[1]))
    set -l scan rg -o --no-filename
    command -q rg; or set scan command grep -ohE
    for p in ($scan '"cwd":"[^"]*"' $t[1] | sort -u | string replace -r '^"cwd":"(.*)"$' '$1')
        if test (string replace -ra '[^A-Za-z0-9]' '-' -- $p) = $folder
            echo $p
            return
        end
    end
    return 1
end
