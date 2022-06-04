FROM ghcr.io/wbelucky/dotfiles-with-docker/base

COPY . $HOME/dotfiles
RUN chown -R $USERNAME:$USERNAME $HOME/dotfiles && make
WORKDIR /workspace
CMD ["fish"]

