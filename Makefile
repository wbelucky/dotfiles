DOTFILES := $(shell echo $${DOTFILES:-${HOME}/dotfiles})

.PHONY: all
all: coc-pyright /usr/bin/fish

/usr/bin/fish: upgraded-apt ${HOME}/.config /usr/bin/apt-add-repository tzdata
	sudo sh -c ' sudo apt-add-repository -y ppa:fish-shell/release-3 \
	  && sudo apt update -y \
	  && sudo apt install -y fish \
	  && sudo chsh -s /usr/bin/fish' \
	  && ln -snfv $(DOTFILES)/fish ${HOME}/.config/fish
	  

.PHONY: coc-pyright
coc-pyright: vim-plug nodejs
	nvim --headless +'CocInstall coc-pyright -sync' +qall

.PHONY: vim-plug
vim-plug: /usr/bin/nvim /usr/bin/curl /usr/bin/git
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-${HOME}/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
	  && nvim --headless +'PlugInstall --sync' +qall

/usr/bin/nvim: upgraded-apt ${HOME}/.config
	sudo apt-get install -y neovim
	ln -snfv $(DOTFILES)/nvim ${HOME}/.config/nvim

/usr/bin/curl: upgraded-apt
	sudo apt-get install -y curl

.PHONY: tzdata
tzdata: upgraded-apt
	sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

/usr/bin/git: upgraded-apt tzdata /usr/bin/apt-add-repository
	sudo sh -c 'add-apt-repository -y ppa:git-core/ppa \
	  && apt-get update -y \
	  && apt-get install -y git'
	ln -snfv $(DOTFILES)/private/.gitconfig ${HOME}/.gitconfig

.PHONY: upgraded-apt
upgraded-apt:
	sudo sh -c 'apt-get update -y \
	  && apt-get upgrade -y \
	  && apt-get autoremove -y'

.PHONY: nodejs
nodejs: /usr/bin/curl
	sudo sh -c 'curl -sL https://deb.nodesource.com/setup_16.x | bash && apt-get install -y nodejs'	

/usr/bin/apt-add-repository:
	sudo apt-get install -y software-properties-common

${HOME}/.config:
	mkdir -p ${HOME}/.config
