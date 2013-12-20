# dotfiles

Resource: [USING GIT AND GITHUB TO MANAGE YOUR DOTFILES](http://blog.smalleycreative.com/tutorials/using-git-and-github-to-manage-your-dotfiles/)

I have changed makesymlinks.sh to use .filename.

```
$ mv ~/.filename ~/dotfiles/.filename

# add .filename to makesymlinks.sh
...
files=".vimrc .vim .NERDTree .Xresources .bashrc .oh-my-zsh .zsh .zshrc .filename"
...

# run makesymlinks.sh
cd ~/dotfiles
chmod +x makesymlinks.sh
# note that makesymlinks.sh doesn't work. Use ./
./makesymlinks.sh 

# prepare git
git init

# add to git
git add .
git commit -m ".filename added"
git remote 
git remmote add origin http://github.com/shinokada/dotfiles.git
git push -u origin master

# from the second time
git push origin master

```
