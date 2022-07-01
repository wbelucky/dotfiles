FROM ghcr.io/wbelucky/dotfiles-with-docker/base

COPY . $HOME/dotfiles

ENV PATH="$HOME/.local/share/aquaproj-aqua/bin:$PATH"
ENV AQUA_GLOBAL_CONFIG=$DOTFILES/aqua.yaml

RUN sudo chown -R $USERNAME:$USERNAME $HOME/dotfiles && make all
WORKDIR /workspace
CMD ["fish"]

