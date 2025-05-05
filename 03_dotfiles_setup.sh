#!/bin/bash
set -euo pipefail

echo "🗂 Writing .bashrc..."
cat <<'EOF' > ~/.bashrc
[[ $- != *i* ]] && return

# Load ble.sh without immediately attaching
source ~/.local/share/blesh/ble.sh --noattach

# Initialize Starship prompt
eval "$(starship init bash)"

# Attach ble.sh if available
[[ ${BLE_VERSION-} ]] && ble-attach

# Load aliases
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi
EOF

echo "🖋 Writing .bash_profile..."
cat <<'EOF' > ~/.bash_profile
# Custom environment scripts
. "$HOME/.local/bin/env"

# Source .bashrc for interactive shells
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi
EOF

echo "🔁 Writing .bash_aliases..."
cat <<'EOF' > ~/.bash_aliases
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias diff='diff --color=auto'
EOF

echo "🎨 Writing .blerc..."
cat <<'EOF' > ~/.blerc
# ~/.blerc

# --- Syntax faces ---
ble-face syntax_comment='fg=gray,italic'
ble-face syntax_command='fg=cyan,bold'
ble-face command_builtin='fg=yellow,bold'    # builtins like echo, cd
ble-face command_keyword='fg=magenta,underline'  # if, then, for, while
ble-face syntax_varname='fg=orange,underline'
ble-face syntax_error='bg=I196,fg=white,bold'
ble-face syntax_delimiter='fg=magenta,bold'
ble-face syntax_glob='fg=yellow,bold'
ble-face syntax_brace='fg=teal'

# --- Region faces ---
ble-face region='bg=navy,fg=white'
ble-face region_target='reverse'
ble-face region_match='fg=olive,bg=black'
ble-face region_insert='fg=cyan,bg=gray'

# --- Custom prompt face + Starship integration ---
ble-face git_icon:='fg=magenta,bold'

# Turn off “transient” trimming so old prompts stick around
bleopt prompt_ps1_transient=
bleopt prompt_rps1_transient=
                                                           	
# Use Starship for the *edit-mode* prompt by exporting PS1/RPS1 (ble.sh uses your PS1 environment variable for the prompt you see while typing)
export PS1='$(starship module character)'
export RPS1='$(starship module time)'

# Use Starship for the *edit-mode* right prompt
bleopt prompt_rps1_final='$(starship module time)'
EOF

echo "✅ Dotfiles configured."
