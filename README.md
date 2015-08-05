#seeegma's dotfiles

Each program's dotfiles reside in a directory bearing the name of the program. To create symlink in their proper places for a program residing in the folder <folder>, simply type `stow <folder>` (of course this requires the program "stow"). `stow *` will set up everything. See `man stow`, I guess.
