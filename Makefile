.PHONY: coc-pyright
coc-pyright: vim-plug nodejs git
	nvim --headless +'CocInstall coc-pyright -sync' +qall

.PHONY: vim-plug
vim-plug: nvim
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
	nvim --headless +'PlugInstall --sync' +qall

.PHONY: nvim 
nvim: upgraded-apt
	sudo apt-get -y install nvim


.PHONY: curl
curl: upgraded-apt
	sudo apt-get -y install curl

.PHONY: git
git: upgraded-apt
	sudo sh -c 'apt-get install -y software-properties-common \
	  && sudo add-apt-repository ppa:git-core/ppa \
	  && sudo apt-get update -y
	  && apt-get -y install git'

.PHONY: upgraded-apt
upgraded-apt:
	sudo sh -c 'apt-get update -y \
	  && apt-get upgrade -y \
	  && apt-get autoremove -y'

.PHONY: nodejs curl
nodejs: 
	sudo sh -c 'curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install -y nodejs'
	

