
# stuff that I've run so far (more or less)

sudo apt-get update
sudo apt-get install -y htop git-core vim vim-gui-common python-setuptools

echo "
export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8

export HISTSIZE=1000000
export HISTFILESIZE=1000000000

export WORKON_HOME=/usr/local/virtualenvs
source /usr/local/bin/virtualenvwrapper.sh
" >> .bashrc

export LANGUAGE=en_GB.UTF-8
export LANG=en_GB.UTF-8
export LC_ALL=en_GB.UTF-8
sudo locale-gen en_GB.UTF-8
sudo dpkg-reconfigure locales

git clone git@github.com:aidos/dotfiles.git .dotfiles
cd .dotfile
git submodule init
git submodule update
~/.dotfiles/link.sh 

sudo easy_install virtualenv
sudo easy_install pip
sudo pip install virtualenvwrapper

#sudo mkdir /usr/local/virtualenvs
export WORKON_HOME=~/.virtualenvs
source /usr/local/bin/virtualenvwrapper.sh

mkvirtualenv rapditender

sudo apt-get install nfs-common portmap

# general rapidtender config here

