FROM ghcr.io/wbelucky/dotfiles-with-docker/base

COPY . $HOME/dotfiles
RUN sudo chown -R $USERNAME:$USERNAME $HOME/dotfiles && make
WORKDIR /workspace
CMD ["fish"]

