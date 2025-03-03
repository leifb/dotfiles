# Dotfiles

Use GNU `stow` to install:

```bash
stow . -t ~
```

To reverse this, use:

```bash
stow -D . -t ~
```

## Misc setup hints

### Better git diffs with diff-so-fancy

```bash
git config --global core.pager "diff-so-fancy | less --tabs=4 -RF"
git config --global interactive.diffFilter "diff-so-fancy --patch"
```
