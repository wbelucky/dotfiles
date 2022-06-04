.PHONY: coc-pyright
coc-pyright: vim-plug nodejs
	nvim --headless +'CocInstall coc-pyright -sync' +qall

.PHONY: vim-plug
vim-plug: nvim curl git
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-$${HOME}/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
	  && nvim --headless +'PlugInstall --sync' +qall

.PHONY: nvim 
nvim: upgraded-apt
	sudo apt-get install -y neovim


.PHONY: curl
curl: upgraded-apt
	sudo apt-get install -y curl

.PHONY: git
git: upgraded-apt
	sudo sh -c 'apt-get install -y software-properties-common \
	  && sudo add-apt-repository ppa:git-core/ppa \
	  && sudo apt-get update -y \
	  && apt-get install -y git'

.PHONY: upgraded-apt
upgraded-apt:
	sudo sh -c 'apt-get update -y \
	  && apt-get upgrade -y \
	  && apt-get autoremove -y'

.PHONY: nodejs curl
nodejs: 
	sudo sh -c 'curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install -y nodejs'
	

