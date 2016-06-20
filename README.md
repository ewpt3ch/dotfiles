# ewpt3ch's dotfiles

#### usage: 
currently the repo is .dotfiles in ~ with symlinks from the default file to it's corresponding file in the repo. (ie ~/.tmux.conf is a symlink to ~/.dotfiles/tmux.conf) the master branch is files that I want to match on all machines I use (tmux.conf, vimrc, bashrc) and each machine has a branch for customizations specific to that machine. (yoga2 Xresources are different from y410 due to screen resolution).

#### naming conventions
Kernels: kernel.*machine-name* ie kernel.yoga2

#### Local config
Notes on local configuration stuff are in Local-config.*machine-name* ir Local-config.yoga2
Things included kernel cmdline, Xorg config, other customizations for working around bugs
or hardware issues.
