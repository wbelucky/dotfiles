DOTFILES := $(shell echo $${DOTFILES:-${HOME}/dotfiles})
INSTALL := apt-get install -y
UPDATE := apt-get update -y

.PHONY: all
all: vim-plug /usr/bin/fish ts-lsp

.PHONY: lsp
ts-lsp: nodejs
	sudo npm i --location=global typescript diagnostic-languageserver typescript-language-server

/usr/bin/fish: upgraded-apt ${HOME}/.config /usr/bin/apt-add-repository tzdata
	sudo sh -c ' sudo apt-add-repository -y ppa:fish-shell/release-3 \
	  && sudo $(UPDATE) \
	  && sudo $(INSTALL) fish \
	  && sudo chsh -s /usr/bin/fish' \
	  && ln -snfv $(DOTFILES)/.config/fish ${HOME}/.config/fish
	  

.PHONY: vim-plug
vim-plug: /usr/bin/nvim /usr/bin/curl /usr/bin/git build-essential
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-${HOME}/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
	  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
	  && nvim --headless +'PlugInstall --sync' +qall

/usr/bin/nvim: upgraded-apt ${HOME}/.config /usr/bin/apt-add-repository
	sudo sh -c 'add-apt-repository -y ppa:neovim-ppa/unstable \
	  && $(UPDATE) \
	  && $(INSTALL) neovim'
	ln -snfv $(DOTFILES)/.config/nvim ${HOME}/.config/nvim

/usr/bin/curl: upgraded-apt
	sudo $(INSTALL) curl

.PHONY: ghq
ghq: /usr/bin/go
	go install github.com/x-motemen/ghq@latest

.PHONY: tzdata
tzdata: upgraded-apt
	sudo DEBIAN_FRONTEND=noninteractive $(INSTALL) --no-install-recommends tzdata

/usr/bin/git: upgraded-apt tzdata /usr/bin/apt-add-repository
	sudo sh -c 'add-apt-repository -y ppa:git-core/ppa \
	  && $(UPDATE) \
	  && $(INSTALL) git'
	ln -snfv $(DOTFILES)/private/.gitconfig ${HOME}/.gitconfig

.PHONY: upgraded-apt
upgraded-apt:
	sudo sh -c '$(UPDATE) \
	  && apt-get upgrade -y \
	  && apt-get autoremove -y'

.PHONY: nodejs
nodejs: /usr/bin/curl
	sudo sh -c 'curl -sL https://deb.nodesource.com/setup_16.x | bash && $(INSTALL) nodejs'	

/usr/bin/apt-add-repository:
	sudo $(INSTALL) software-properties-common

.PHONY: build-essential
build-essential:
	sudo $(INSTALL) build-essential

${HOME}/.config:
	mkdir -p ${HOME}/.config
