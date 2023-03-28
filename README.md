<center><h1> Dotfiles <br> ~/.* </h1></center>

The dotfiles of my current GNU/Linux [EndeavorOS](https://endeavouros.com/) install managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Basic workflow:

1. Each folder corresponds to a particular app. Make sure that the internal folder and file structure corresponds to the relative path as if the user would be in the parent folder of wherever dotfiles is stored (~/)
2. Use touch to quickly create empty files for the respective dotfiles one wishes to track
3. Call `stow --adopt -(n)v $APP$` with APP as the desired folder to stow. The -n flag is used to simulate what would happen and -v for verbose output. Hence, inspect with -nv and run with -v afterwards.
4. Manage the git repo

## Example:

Assuming the dotfiles folder is located in `~`, stow `starship.toml` which simply resides in the user's .config folder:

    ~
    └── .config
        └── starship.toml
    └── dotfiles

1. cd into dotfiles:
    
        cd ~/dotfiles

2. Create the folder structure: 
    
        mkdir -p ./starship/.config

3. Initialize empty files for the ones we wish to track

        touch ./starship/.config/starship.toml

4. Simulate what would happen if we were to stow adopt

        stow --adopt -nv starship

5. Stow if output above was desirable

        stow --adopt -v starship

If all went well a symlink will have been created from `~/.config/starship.toml` to `~/dotfiles/starship/.config/starship.toml`. The user may now make changes to `starship.toml` and everything will be nicely tracked in the dotfiles git repo. 

## Reverse Operation

The reverse operation involves placing config files that one pulled in from the repo in the folder where they normally live, as defined by the relative folder structure. This is easily done with the `stow $APP$` command for one folder at a time or `stow */` for all folders at once. Use with care.