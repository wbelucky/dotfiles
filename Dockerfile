FROM ghcr.io/wbelucky/dotfiles-with-docker/base

COPY . $HOME/dotfiles
RUN make
