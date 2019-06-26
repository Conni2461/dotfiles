# Linux Dotfiles

## How to clone as git bare

```
# Move to your home folder
cd
# Create a alias to work with the git bare repository. Don't close the bash session or you have to run this command again.
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
# Ignore the .cfg folder. This makes sure that you don't create weird recursion problems
echo ".cfg" >> .gitignore
# Close the repository
git clone --bare https://github.com/conni2461/dotfiles.git
# Get the files
config checkout
```

Now files like `.bashrc` and `.gitconfig` are untracked. Either remove or move elsewhere.

```
config checkout
# Change git setup to only show tracked Files
config config --local status.showUntrackedFiles no
```

## Homw to work with git bare dotfiles

```
# Show status of dotfile repository
config status
# Add a file
config add .file
# Create a commit
config commit -m "Message"
# Push to the remote repository
config push
```

Also you should change the email and name in the `.gitconfig` as well as the remote adresse.

```
git remote set-url origin <url>
```
