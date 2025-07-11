# Zsh Options (setopt)

# History
setopt SHARE_HISTORY         # Share history between running shells
setopt HIST_IGNORE_ALL_DUPS  # Remove older duplicate entries from history
setopt HIST_SAVE_NO_DUPS     # Don't save duplicates to the history file
setopt HIST_EXPIRE_DUPS_FIRST # Expire duplicates first when trimming history
unsetopt HIST_IGNORE_DUPS    # Needed for HIST_IGNORE_ALL_DUPS to work correctly