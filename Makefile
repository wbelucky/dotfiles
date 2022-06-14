DOTFILES := $(shell echo $${DOTFILES:-${HOME}/dotfiles})
INSTALL := apt-get install -y
UPDATE := apt-get update -y
GO_VERSION := 1.18.3

.PHONY: links
links: ${HOME}/.config
	ln -snfv $(DOTFILES)/.config/fish ${HOME}/.config/fish
	ln -snfv $(DOTFILES)/.config/nvim ${HOME}/.config/nvim
	ln -snfv $(DOTFILES)/.tmux.conf ${HOME}/.tmux.conf
	ln -snfv $(DOTFILES)/.gitconfig ${HOME}/.gitconfig

.PHONY: all
all: vim-plug fish tmux links ghq

${HOME}/.config:
	mkdir -p ${HOME}/.config

.PHONY: fzf
fzf:
	command -v fzf || sudo $(INSTALL) fzf

.PHONY: ts-lsp
ts-lsp: nodejs
	sudo npm i --location=global typescript diagnostic-languageserver typescript-language-server

fish: apt-add-repository tzdata
	command -v fish || sudo sh -c ' sudo apt-add-repository -y ppa:fish-shell/release-3 \
		&& sudo $(UPDATE) \
		&& sudo $(INSTALL) fish \
		&& sudo chsh -s fish'

.PHONY: vim-plug
vim-plug: nvim curl git build-essential
	sh -c 'curl -fLo "$${XDG_DATA_HOME:-${HOME}/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' \
		&& nvim --headless +'PlugInstall --sync' +qall;

nvim: apt-add-repository
	command -v nvim || sudo sh -c 'add-apt-repository -y ppa:neovim-ppa/unstable \
		&& $(UPDATE) \
		&& $(INSTALL) neovim'

.PHONY: curl
curl: updated-apt
	command -v curl || sudo $(INSTALL) curl

.PHONY: wget
wget: updated-apt
	command -v wget || sudo $(INSTALL) wget

.PHONY: ghq
ghq: go
	go install github.com/x-motemen/ghq@latest

.PHONY: go
go: wget
	command -v go || wget https://dl.google.com/go/go$(GO_VERSION).linux-amd64.tar.gz \
		&& sudo rm -rf /usr/local/go && sudo tar -C /usr/local -xzf go$(GO_VERSION).linux-amd64.tar.gz \
		&& rm go$(GO_VERSION).linux-amd64.tar.gz \
		&& go version

.PHONY: tzdata
tzdata:
	sudo DEBIAN_FRONTEND=noninteractive $(INSTALL) --no-install-recommends tzdata

tmux: updated-apt
	command -v tmux || sudo $(INSTALL) tmux

git: upgraded-apt tzdata apt-add-repository
	command -v git || sudo sh -c 'add-apt-repository -y ppa:git-core/ppa \
		&& $(UPDATE) \
		&& $(INSTALL) git'

.PHONY: updated-apt
updated-apt:
	sudo $(UPDATE)

.PHONY: upgraded-apt
upgraded-apt:
	sudo sh -c '$(UPDATE) \
		&& apt-get upgrade -y \
		&& apt-get autoremove -y'

.PHONY: nodejs
nodejs: curl
	command -v node || sudo sh -c 'curl -sL https://deb.nodesource.com/setup_16.x | bash && $(INSTALL) nodejs'

apt-add-repository: updated-apt
	command -v apt-add-repository || sudo $(INSTALL) software-properties-common

.PHONY: build-essential
build-essential: updated-apt
	sudo $(INSTALL) build-essential

