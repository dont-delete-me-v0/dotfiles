# tmux keymaps

This tmux setup uses modes instead of many global shortcuts.

## Global shortcuts

```text
Option-t      tab mode
Option-s      split mode
Option-p      pane mode
Option-e      copy mode
Option-R      reload tmux config
```

The default tmux prefix is still available as fallback:

```text
Ctrl-b
```

## Tab mode

Enter:

```text
Option-t
```

Keys inside tab mode:

```text
n        new tab/window
h        previous tab/window
[        previous tab/window
l        next tab/window
]        next tab/window
r        rename tab/window
q        close tab/window
Esc      exit tab mode
```

## Split mode

Enter:

```text
Option-s
```

Keys inside split mode:

```text
v        split right
|        split right
s        split down
-        split down
w        close current pane
Esc      exit split mode
```

## Pane mode

Enter:

```text
Option-p
```

Keys inside pane mode:

```text
h        focus pane left
j        focus pane down
k        focus pane up
l        focus pane right

H        resize pane left
J        resize pane down
K        resize pane up
L        resize pane right

w        close current pane
q        exit pane mode
Esc      exit pane mode
```

## Status bar hints

The tmux status bar shows a compact cheat sheet for the current mode:

```text
NORMAL Opt-t:tabs Opt-s:splits Opt-p:panes
TAB n:new h/l:prev/next r:rename q:close Esc:exit
SPLIT v:right s:down w:close Esc:exit
PANE h/j/k/l:focus H/J/K/L:resize w:close q/Esc:exit
```
